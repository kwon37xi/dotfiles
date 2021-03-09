#!/bin/sh
# https://github.com/dandavison/delta
APPLICATION_NAME=delta
GITHUB_REPO=dandavison/delta
PLATFORM_GREP='.*amd64.deb'
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP | grep -v musl)
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo dpkg -i /tmp/$PACKAGE_NAME

rm -f /tmp/$PACKAGE_NAME
