#!/bin/sh
# https://github.com/muesli/duf
APPLICATION_NAME=duf
LATEST_PACKAGE_URL=$(curl -sL https://api.github.com/repos/muesli/duf/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*linux_amd64.deb')
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo apt install /tmp/$PACKAGE_NAME

rm -f /tmp/$PACKAGE_NAME
