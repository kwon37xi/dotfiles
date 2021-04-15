#!/bin/sh
# https://github.com/go-jira/jira
APPLICATION_NAME=go-jira
GITHUB_REPO=go-jira/jira
PLATFORM_GREP='linux-amd64'
LATEST_PACKAGE_URL=$(curl -sL "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r '.assets[].browser_download_url' | grep -e $PLATFORM_GREP)
PACKAGE_NAME=$(basename "$LATEST_PACKAGE_URL")

rm -f /tmp/$PACKAGE_NAME
wget -O "/tmp/$PACKAGE_NAME" "$LATEST_PACKAGE_URL"

sudo mv /tmp/$PACKAGE_NAME /usr/local/bin/jira
sudo chown root:root /usr/local/bin/jira
sudo chmod 755 /usr/local/bin/jira

rm -f /tmp/$PACKAGE_NAME
