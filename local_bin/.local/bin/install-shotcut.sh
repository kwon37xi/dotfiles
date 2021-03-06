#!/bin/sh
# https://github.com/mltframework/shotcut
APPLICATION_NAME=shotcut
GITHUB_REPO=mltframework/shotcut
PLATFORM_GREP='.*linux-x86_64.*\.AppImage'
APP_IMAGE_HOME="$HOME/Applications"
# hugo 는 extended 버전이 있어서 해당 버전 제거
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP)
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

echo "LATEST_PACKAGE_URL : ${LATEST_PACKAGE_URL}"
echo "PACKAGE_NAME : ${PACKAGE_NAME}"

mkdir -p $APP_IMAGE_HOME
wget -O "$APP_IMAGE_HOME/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

chmod +x "${APP_IMAGE_HOME}/$PACKAGE_NAME"
