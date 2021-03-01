#!/bin/sh
# https://github.com/dalance/procs

sudo rm -f /tmp/procs.zip
curl -sL https://api.github.com/repos/dalance/procs/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*x86_64-lnx.zip' | sudo wget -O /tmp/procs.zip -i -

sudo mkdir -p /usr/local/share/procs
sudo rm -rf /usr/local/share/procs/*

sudo unzip /tmp/procs.zip -d /usr/local/share/procs
sudo chown -R root:root /usr/local/share/procs
sudo chmod 755 /usr/local/share/procs/procs
sudo ln -sf /usr/local/share/procs/procs /usr/local/bin/procs
