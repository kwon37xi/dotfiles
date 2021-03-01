#!/bin/sh
# https://github.com/chmln/sd
sudo rm -f /usr/local/bin/sd
curl -sL https://api.github.com/repos/chmln/sd/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*.x86_64-unknown-linux-gnu' | sudo wget -O /usr/local/bin/sd -i -
sudo chmod 755 /usr/local/bin/sd
