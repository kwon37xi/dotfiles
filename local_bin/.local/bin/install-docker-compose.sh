#!/bin/sh
# docker-compose plugin install

DOCKER_COMPOSE_PLUGINS=$HOME/.docker/cli-plugins
mkdir -p "$DOCKER_COMPOSE_PLUGINS"
rm -f "$DOCKER_COMPOSE_PLUGINS/docker-compose"

curl -sL https://api.github.com/repos/docker/compose/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*-linux-x86_64' | wget -O "$DOCKER_COMPOSE_PLUGINS/docker-compose" -i -

chmod 755 "$DOCKER_COMPOSE_PLUGINS/docker-compose"
