#!/usr/bin/env python3.8
import paramiko
from pathlib import Path


def main():
    return


def get_simple_connection(hostname, username):
    try:
        private_key = paramiko.pkey.PKey().from_private_key_file()
    except (IOError, paramiko.SSHException) as err:
        pass
    ssh_client = paramiko.SSHClient()
    ssh_client = ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(hostname, username=username, pkey=private_key, allow_agent=False, look_for_keys=False)
    return


if __name__ == '__main__':
    main()
