Docker container for Rust development
=====================================

A Docker container containing:

- Rust compiler / rustup / rust language server
- Visual Studio Code
- Rust plugin for VSC
- LLDB
- LLDB plugin for VSC
- lcov, code coverage tool

The included bash script builds the container and runs it with a number of practical features enabled:

- X forwarding, enables running X application in the container and get output on the X server running on the host. Useful for Visual Studio Code, Chrome, Firefox, ...
- SSH forwarding to host system, and mapping your .gitconfig into the container: allows to use Git/SSH with the settings/keys from you host system, within the container
- Exposes the "shared" directory in your home folder (host system) as "shared" directory in the container (/home/developer/shared)

## How to use?

1. Build & run the container

./run-docker.sh

You now are logged in to the container as the developer user (password is `developer` too). By default, `tmux` is running as a screen multiplexer, `fish` is running as the shell.

## Useful tools:

- fish (nice terminal)
- tmux (spit screen terminal)
- code (Visual Studio Code, has Rust / lldb plugin preinstalled)

