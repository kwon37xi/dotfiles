#!/bin/sh
# https://github.com/ransome1/sleek
APPLICATION_NAME=sleek
LATEST_PACKAGE_URL=$(curl -sL https://api.github.com/repos/ransome1/sleek/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.amd64.deb')
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo apt install /tmp/$PACKAGE_NAME

rm -f /tmp/$PACKAGE_NAME
