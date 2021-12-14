#!/usr/bin/bash
# https://github.com/scopatz/nanorc syntax highlights
APPLICATION_NAME=nanorc
GITHUB_REPO=scopatz/nanorc
PLATFORM_GREP='tar.gz'
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e "$PLATFORM_GREP")
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f "/tmp/$PACKAGE_NAME"
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

mkdir -p ~/.config/nano/syntaxhighlights
tar xvzf "/tmp/$PACKAGE_NAME" --strip=1 --directory ~/.config/nano/syntaxhighlights

rm "/tmp/$PACKAGE_NAME"
