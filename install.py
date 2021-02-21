#!/usr/bin/env python3.9
import argparse
import json
import logging
import logging.config
import platform
import sys
from pathlib import Path

logger = logging.getLogger(__name__)


def main():
    args = _get_args()
    configure_logging(verbosity=args.verbosity)
    return


def configure_logging(verbosity=0):
    """Configure logging for script

    Keyword Arguments:
        verbosity (int):
            integer representing level of verbosity, starting at 0
    Return:
        None
    """
    level = "INFO" if verbosity == 0 else "DEBUG"
    config = {
        "version": 1,
        "disable_existing_loggers": False,
        "formatters": {
            "standard": {"format": "%(asctime)s %(levelname)-8s %(message)s"},
        },
        "handlers": {
            "console": {
                "class": "logging.StreamHandler",
                "level": level,
                "formatter": "standard",
            },
        },
        "loggers": {
            __name__: {"level": level, "handlers": ["console"], "propagate": False}
        },
    }
    logging.config.dictConfig(config)


def _get_args():
    """Parse arguments passed at invocation

    Return:
        argparse.Namespace
    """
    parser = argparse.ArgumentParser(
        description="Install dotfiles from repo",
        epilog="Example: %(prog)s",
    )
    parser.add_argument(
        "-c",
        "--config-file",
        dest="config_file",
        required=False,
        default=Path().joinpath(".config-files.json"),
        help="Configuration file to use",
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


if __name__ == "__main__":
    main()
