#!/usr/bin/env python3.8
from pathlib import Path
import sshtunnel


def main():
    return


def create_tunnel(hostname, private_key,
                  remote_bind_port, local_bind_port,
                  username=None, remote_bind_ip='127.0.0.1', local_bind_ip='0.0.0.0'):
    """Establish tunnel for remote port forwading

    Arguments:
        hostname (str):
            Target host to create tunnel
        private_key (str):
            Path to private key file
        remote_bind_port (int):
            Port to forward on remote server
        local_bind_port (int):
            Port to listen to locally, forwarding to remote port

    Keyword Arguments:
        username (str):
            Username for authentication
            Default: ``None``
        remote_bind_ip (str):
            IP to bind to on remote server
            Default: '127.0.0.1'
        local_bind_ip (str):
            IP to bind to on local server
            Default: '0.0.0.0'

    Example:
        >>> create_tunnel('nuc', '~/.ssh/kincerb_forward', 443, 8888)
    """
    with sshtunnel.open_tunnel(hostname,
                               ssh_username=username,
                               ssh_pkey=str(private_key),
                               remote_bind_address=(remote_bind_ip, remote_bind_port),
                               local_bind_address=(local_bind_ip, local_bind_port)
                               ) as tunnel:
        tunnel.close()


def _private_key_verified(key_path):
    """Verify private key exists

    Arguments:
        key_path (str):
            Path to private key
    Return:
        boolean
    """
    private_key = Path.expanduser(key_path)
    return private_key.exists()


if __name__ == '__main__':
    main()
