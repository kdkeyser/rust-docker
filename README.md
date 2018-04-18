Docker container for Rust development
=====================================

A Docker container containing:

- Rust compiler / rustup / rust language server
- Visual Studio Code
- Rust plugin for VSC
- LLDB
- LLDB plugin for VSC

docker-compose is used to build the Docker and set some environment variables. This is needed for:

- X11 forwarding to the host system
- Using the .gitconfig of the host system
- Exposing a shared directory (called "shared" in /home/developer) that allows you to keep checked out repositories between subsequent runs of the docker
- Access SSH keys from the host system
- Enable host IPC (required by Visual Studio Code, otherwise it hangs frequently, see https://github.com/Microsoft/vscode/issues/44385)

To build:

docker-compose build

To run:

./run-docker-compose.sh

This script makes sure that the Docker has access to the SSH keys from the host system.

To get access to a shell (after docker-compose is up and running, previous step):

docker exec -it rustdocker_dev_1 /bin/bash
