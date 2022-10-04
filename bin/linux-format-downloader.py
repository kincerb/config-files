#!/usr/bin/env python3
import argparse
import asyncio
import datetime
import logging
import logging.config
import logging.handlers
from pathlib import Path

import aiohttp

BASE_URL = "https://www.linuxformat.com/includes/downloads.php"


def main():
    args = get_args()
    configure_logging(verbosity=args.verbosity)

    if args.download_dir is not Path:
        args.download_dir = Path(args.download_dir)

    start_time = datetime.datetime.now()

    loop = asyncio.get_event_loop()
    results = loop.run_until_complete(download_issues_requested(args.issue_number, args.download_dir))
    loop.close()

    total_run_time = datetime.datetime.now() - start_time
    logging.info(f"Total run time: {total_run_time.total_seconds():.2f} seconds.")
    logging.debug(results)


async def download_issues_requested(issues: str, download_directory: Path) -> tuple:
    cookies = {"SubName": "", "SubNumber": "", "SubExpire": "", "SubSum": ""}
    tasks = []
    async with aiohttp.ClientSession(cookies=cookies) as session:
        if "-" in issues:
            start_issue, stop_issue = issues.split("-")
            for issue_number in range(int(start_issue), int(stop_issue) + 1):
                tasks.append(download_single_issue(session, download_directory, issue_number))
        else:
            tasks.append(download_single_issue(session, download_directory, int(issues)))

        results = await asyncio.gather(*tasks)
    return results


async def download_single_issue(session: aiohttp.ClientSession, download_directory: Path, issue: int):
    download_filename = download_directory.joinpath(f"{issue}.pdf")
    params = {"PDF": f"LXF{issue}.complete.pdf"}

    start_time = datetime.datetime.now()
    logging.debug(f"Started download of issue {issue}")
    try:
        async with session.get(BASE_URL, params=params) as response:
            with download_filename.open(mode="wb") as f:
                while True:
                    chunk = await response.content.read(1024)
                    if not chunk:
                        break
                    f.write(chunk)
    except aiohttp.ClientResponseError as e:
        logging.error(e.message)
    except Exception as e:
        logging.error(e)
    else:
        total_run_time = datetime.datetime.now() - start_time
        logging.info(f"Downloaded issue {issue} to {download_filename} in {total_run_time.total_seconds():.2f}s.")
        return download_filename


def get_args() -> argparse.Namespace:
    """Parse arguments passed at invocation.

    Return:
        argparse.Namespace
    """
    parser = argparse.ArgumentParser(
        description="Download linux format magazines from archive",
        epilog="""
Example:
    linux-format-downloader.py 247
        """,
    )
    parser.add_argument("issue_number", type=str, help="Issue number to download")
    parser.add_argument(
        "-d",
        "--download-dir",
        required=False,
        default=Path("~/Downloads").expanduser(),
        dest="download_dir",
        help="Directory to store download",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        required=False,
        dest="verbosity",
        action="count",
        default=0,
        help="Increase output verbosity.",
    )
    return parser.parse_args()


def configure_logging(verbosity: int = 0) -> None:
    """Configure logging.

    Keyword Arguments:
        verbosity (int):
            Integer representing level of verbosity
            Default: 0

    Returns:
        None
    """
    level = "INFO" if verbosity == 0 else "DEBUG"
    config = {
        "version": 1,
        "disable_existing_loggers": False,
        "formatters": {"console": {"format": "%(levelname)-8s %(message)s"}},
        "handlers": {
            "console": {
                "class": "logging.StreamHandler",
                "level": level,
                "formatter": "console",
            }
        },
        "loggers": {"root": {"level": level, "handlers": ["console"], "propagate": False}},
    }
    logging.config.dictConfig(config)


if __name__ == "__main__":
    main()
