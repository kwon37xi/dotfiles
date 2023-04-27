#!/usr/bin/env bash
PACKAGE_NAME="KakaoTalk_Setup.exe"
INSTALLER_URL="https://app-pc.kakaocdn.net/talk/win32/${PACKAGE_NAME}"
rm -f "/tmp/${PACKAGE_NAME}"
wget -O "/tmp/${PACKAGE_NAME}" "${INSTALLER_URL}"

wine "/tmp/${PACKAGE_NAME}"
rm -f "/tmp/${PACKAGE_NAME}"
