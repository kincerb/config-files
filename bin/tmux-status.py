#!/usr/bin/env python3
import argparse
import datetime
import logging
import logging.config
import logging.handlers
import os
from pathlib import Path


def main():
    args = get_args()
    configure_logging(verbosity=args.verbosity)


def get_args() -> argparse.Namespace:
    """Parse arguments passed at invocation.

    Return:
        argparse.Namespace
    """
    parser = argparse.ArgumentParser(
        description='Return chunk of tmux status bar')
    parser.add_argument('status',
                        type=str,
                        help='Bit of status to get and return')
    parser.add_argument('-v', '--verbose',
                        required=False,
                        dest='verbosity',
                        action='count',
                        default=0,
                        help='Increase output verbosity.')
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
    level = 'INFO' if verbosity == 0 else 'DEBUG'
    config = {
        'version': 1,
        'disable_existing_loggers': False,
        'formatters': {
            'console': {
                'format': '%(levelname)-8s %(message)s'
            }
        },
        'handlers': {
            'console': {
                'class': 'logging.StreamHandler',
                'level': level,
                'formatter': 'console',
            }
        },
        'loggers': {
            'root': {
                'level': level,
                'handlers': ['console'],
                'propagate': False
            }
        }
    }
    logging.config.dictConfig(config)


if __name__ == '__main__':
    main()
