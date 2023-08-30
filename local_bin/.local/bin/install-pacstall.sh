#!/bin/sh
# https://github.com/pacstall/pacstall
APPLICATION_NAME=pacstall
GITHUB_REPO=pacstall/pacstall
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep '.deb')
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo dpkg -i "/tmp/$PACKAGE_NAME"
rm -f /tmp/$PACKAGE_NAME
