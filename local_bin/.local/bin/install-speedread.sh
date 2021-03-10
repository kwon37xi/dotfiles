#!/bin/sh
# https://github.com/pasky/speedread.git
APPLICATION_NAME=speedread
GITHUB_REPO=pasky/speedread
rm -rf /tmp/$APPLICATION_NAME
git clone "https://github.com/${GITHUB_REPO}.git" /tmp/$APPLICATION_NAME

sudo rm -rf /opt/$APPLICATION_NAME
sudo mkdir -p /opt/$APPLICATION_NAME
sudo cp -R /tmp/$APPLICATION_NAME/* /opt/$APPLICATION_NAME

sudo rm -f /usr/local/bin/speedread
sudo ln -s /tmp/$APPLICATION_NAME/speedread /usr/local/bin/speedread
