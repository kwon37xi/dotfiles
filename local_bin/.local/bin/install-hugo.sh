#!/bin/sh
# https://github.com/gohugoio/hugo
APPLICATION_NAME=hugo
GITHUB_REPO=gohugoio/hugo
PLATFORM_GREP='.*Linux-64bit.deb'
# hugo 는 extended 버전이 있어서 해당 버전 제거
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP | grep -v extended)
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo dpkg -i /tmp/$PACKAGE_NAME

rm -f /tmp/$PACKAGE_NAME
