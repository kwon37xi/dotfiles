#!/bin/sh
# https://github.com/yang991178/fluent-reader
APPLICATION_NAME=fluent-reader
GITHUB_REPO=yang991178/fluent-reader
PLATFORM_GREP='.*\.AppImage$'
APP_IMAGE_HOME="$HOME/Applications"
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP)
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

echo "LATEST_PACKAGE_URL : ${LATEST_PACKAGE_URL}"
echo "PACKAGE_NAME : ${PACKAGE_NAME}"

mkdir -p $APP_IMAGE_HOME
wget -O "$APP_IMAGE_HOME/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

chmod +x "${APP_IMAGE_HOME}/$PACKAGE_NAME"
