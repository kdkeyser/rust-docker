#!/bin/bash
sudo sysctl -w vm.max_map_count=262144
export SSH_AUTH_SOCK_DIR=$(dirname $SSH_AUTH_SOCK)
docker-compose up
