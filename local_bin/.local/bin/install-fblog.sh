#!/bin/sh
# fzf latest release download and install

sudo rm -f /tmp/fblog.deb
curl -sL https://api.github.com/repos/brocode/fblog/releases/latest | jq -r '.assets[].browser_download_url' | grep  '.*.deb' | wget -O /tmp/fblog.deb -i -

sudo dpkg -i /tmp/fblog.deb

sudo rm -f /tmp/fblog.deb
