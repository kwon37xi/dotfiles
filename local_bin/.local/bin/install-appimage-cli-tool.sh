#!/bin/sh
# https://github.com/AppImageCrafters/appimage-cli-tool
APPLICATION_NAME=appimage-cli-tool
LATEST_PACKAGE_URL=$(curl -sL https://api.github.com/repos/AppImageCrafters/appimage-cli-tool/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*_amd64.deb')
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo apt install /tmp/$PACKAGE_NAME

rm -f /tmp/$PACKAGE_NAME
