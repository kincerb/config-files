#!/usr/bin/env python3.9
import argparse
import getpass
import logging
import logging.config
import os
import sys

from pathlib import Path
from time import sleep

import sshtunnel

LOG_DIR = Path(
    os.environ.get('HOME', '/Users/kincerb')).joinpath('Documents', 'log')
logger = logging.getLogger(__name__)
logger = sshtunnel.create_logger(logger)


def main():
    args = get_args()
    configure_logging(args.verbosity)
    create_tunnel(args.gateway, args.destination_address, args.destination_port,
                  args.private_key, gateway_ssh_port=args.gateway_ssh_port, username=args.user,
                  local_address=args.local_address, local_port=args.local_port)


def create_tunnel(gateway_host, destination_address, destination_port, private_key,
                  gateway_ssh_port=22, username=getpass.getuser(), local_address='127.0.0.1', local_port=8888):
    """Establish tunnel for remote port forwading

    Arguments:
        gateway_host (str):
            Host to use as gateway to reach destination
        destination_address (str):
            Address of final destination
        destination_port (int):
            Final destination port of tunnel
        private_key (str):
            Path to private key file

    Keyword Arguments:
        gateway_ssh_port (int):
            SSH listening port of gateway
            Default: 22
        username (str):
            Username for authentication
            Default: ``getpass.getuser()``
        local_address (str):
            IP to bind to on local machine
            Default: '127.0.0.1'
        local_port (int):
            Port to bind on local machine
            Default: 8888
    """
    full_key_path, key_exists = _private_key_verify(private_key)

    if not key_exists:
        logger.critical(f'Key {full_key_path} not found.')
        sys.exit(3)

    with sshtunnel.open_tunnel(
        (gateway_host, gateway_ssh_port),
        ssh_username=username,
        ssh_pkey=full_key_path,
        remote_bind_address=(destination_address, destination_port),
        local_bind_address=(local_address, local_port),
        allow_agent=False,
    ) as tunnel:
        try:
            tunnel.start()
        except (sshtunnel.BaseSSHTunnelForwarderError, sshtunnel.HandlerSSHTunnelForwarderError) as err:
            logger.error(err)
            sys.exit(4)

        logger.info(f'Tunnel established to {destination_address}:{destination_port}')
        logger.info(f'Access {destination_address} at {local_address}:{local_port}')

        while True:
            try:
                tunnel.check_tunnels()
                if not any(tunnel.tunnel_is_up.values()):
                    raise sshtunnel.BaseSSHTunnelForwarderError('Tunnel is not up, exicting.')
                sleep(5)
            except KeyboardInterrupt:
                logger.info('CTRL-C caught, exiting.')
            except sshtunnel.BaseSSHTunnelForwarderError as err:
                logger.error(err)
                sys.exit(5)


def _private_key_verify(key_path):
    """Returns absolute path to key and if key exists

    Arguments:
        key_path (str):
            Path to private key

    Return:
        tuple: (str, bool)
    """
    private_key = Path(key_path).expanduser()
    return (str(private_key), private_key.exists())


def get_args():
    """Parse arguments passed at invocation

    Return:
        argparse.Namespace
    """
    parser = argparse.ArgumentParser(
        description='Create ssh tunnel for remote port forwarding',
        epilog='''
Example:
    ssh-connd.py ~/.ssh/kincerb_forwarder access.nucocer.io 443
        '''
    )
    parser.add_argument('private_key',
                        help='Path to private key')
    parser.add_argument('destination_address',
                        help='Address of destination interface')
    parser.add_argument('destination_port',
                        type=int,
                        help='Port on destination interface')
    parser.add_argument('-u', '--user',
                        dest='user',
                        required=False,
                        default=getpass.getuser(),
                        help='Username')
    parser.add_argument('-g', '--gateway',
                        dest='gateway',
                        required=False,
                        default='wireguard01.lan',
                        help='Hostname of gateway server')
    parser.add_argument('--gateway-port',
                        dest='gateway_ssh_port',
                        type=int,
                        default=22,
                        required=False,
                        help='SSH port of gateway server')
    parser.add_argument('--local-address',
                        dest='local_address',
                        required=False,
                        default='127.0.0.1',
                        help='Address of local interface')
    parser.add_argument('--local-port',
                        dest='local_port',
                        required=False,
                        default=8888,
                        type=int,
                        help='Port on local interface')
    parser.add_argument('-v', '--verbose',
                        required=False,
                        dest='verbosity',
                        action='count',
                        default=0,
                        help='Increase output verbosity.')
    return parser.parse_args()


def configure_logging(verbosity=0):
    """Configure logging

    Keyword Arguments:
        verbosity (int):
            Integer representing level of verbosity
            Default: 0

    Return:
        argparse.Namespace
    """
    level = 'INFO' if verbosity == 0 else 'DEBUG'
    config = {
        'version': 1,
        'disable_existing_loggers': False,
        'formatters': {
            'file': {
                'format': '%(asctime)s %(levelname)-8s %(message)s'
            },
        },
        'handlers': {
            'file': {
                'class': 'logging.handlers.RotatingFileHandler',
                'filename': str(LOG_DIR.joinpath('ssh-connd.log')),
                'level': level,
                'formatter': 'file',
                'maxBytes': 1048576,
                'backupCount': 2,
            },
        },
        'loggers': {
            __name__: {
                'level': level,
                'handlers': ['file'],
                'propagate': False
            }
        }
    }
    logging.config.dictConfig(config)


if __name__ == '__main__':
    main()
