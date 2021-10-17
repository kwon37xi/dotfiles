#!/bin/sh
# https://github.com/Ulauncher/Ulauncher
APPLICATION_NAME=ulauncher
LATEST_PACKAGE_URL=$(curl -sL https://api.github.com/repos/Ulauncher/Ulauncher/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.deb')
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo dpkg -i /tmp/$PACKAGE_NAME

rm -f /tmp/$PACKAGE_NAME
