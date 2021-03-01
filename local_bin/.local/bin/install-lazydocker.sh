#!/bin/sh
# https://github.com/jesseduffield/lazydocker
sudo rm -f /tmp/lazydocker.tar.gz
curl -sL https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*.Linux_x86_64.tar.gz' | sudo wget -O /tmp/lazydocker.tar.gz -i -

sudo mkdir -p /usr/local/share/lazydocker
sudo rm -rf /usr/local/share/lazydocker/*

sudo tar xvzf /tmp/lazydocker.tar.gz --directory=/usr/local/share/lazydocker
sudo chown -R root:root /usr/local/share/lazydocker
sudo chmod 755 /usr/local/share/lazydocker/lazydocker
sudo ln -sf /usr/local/share/lazydocker/lazydocker /usr/local/bin/lazydocker
