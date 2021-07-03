#!/bin/sh
# https://github.com/balena-io/etcher
APPLICATION_NAME=etcher
GITHUB_REPO=balena-io/etcher
PLATFORM_GREP='.*-x64.AppImage'
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP)
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"
chmod +x /tmp/$PACKAGE_NAME

mkdir -p ~/Applications
mv /tmp/$PACKAGE_NAME ~/Applications/balenaEtcher.AppImage
