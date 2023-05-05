#!/usr/bin/env bash
PACKAGE_NAME="NavigationUpdaterInstaller.exe"
INSTALLER_URL="https://oem-setup.map-care.com/update_program_download/nau_client/crossplatform/install/${PACKAGE_NAME}"
rm -f "/tmp/${PACKAGE_NAME}"
wget -O "/tmp/${PACKAGE_NAME}" "${INSTALLER_URL}"

wine "/tmp/${PACKAGE_NAME}"
rm -f "/tmp/${PACKAGE_NAME}"
