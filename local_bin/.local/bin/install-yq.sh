#!/bin/sh
# https://github.com/mikefarah/yq
APPLICATION_NAME=yq
GITHUB_REPO=mikefarah/yq
PLATFORM_GREP='linux_amd64'
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP | grep -v 'tar')
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo mv /tmp/$PACKAGE_NAME /usr/local/bin/$APPLICATION_NAME

sudo chown root:root /usr/local/bin/$APPLICATION_NAME
sudo chmod 755 /usr/local/bin/$APPLICATION_NAME

rm -f /tmp/$PACKAGE_NAME
