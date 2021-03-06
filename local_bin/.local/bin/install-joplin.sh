#!/bin/sh
# https://github.com/laurent22/joplin
APPLICATION_NAME=joplin
GITHUB_REPO=laurent22/joplin
PLATFORM_GREP='.*\.AppImage$'
APP_IMAGE_HOME="$HOME/Applications"
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP)
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

echo "LATEST_PACKAGE_URL : ${LATEST_PACKAGE_URL}"
echo "PACKAGE_NAME : ${PACKAGE_NAME}"

mkdir -p $APP_IMAGE_HOME
wget -O "$APP_IMAGE_HOME/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

chmod +x "${APP_IMAGE_HOME}/$PACKAGE_NAME"
