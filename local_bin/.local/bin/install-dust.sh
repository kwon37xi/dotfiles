#!/bin/sh
# https://github.com/bootandy/dust
sudo rm -f /tmp/dust.tar.gz
curl -sL https://api.github.com/repos/bootandy/dust/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*.-x86_64-unknown-linux-gnu.tar.gz' | sudo wget -O /tmp/dust.tar.gz -i -

sudo mkdir -p /usr/local/share/dust
sudo rm -f /usr/local/share/dust/*

sudo tar xvzf /tmp/dust.tar.gz --strip=1 --directory=/usr/local/share/dust
sudo chown -R root:root /usr/local/share/dust
sudo chmod 755 /usr/local/share/dust/dust
sudo ln -sf /usr/local/share/dust/dust /usr/local/bin/dust
