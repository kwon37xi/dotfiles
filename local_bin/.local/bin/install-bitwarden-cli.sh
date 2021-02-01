#!/bin/sh
# fzf latest release download and install

sudo rm -f /tmp/bitwarden-cli.zip
curl -sL https://api.github.com/repos/bitwarden/cli/releases/latest | jq -r '.assets[].browser_download_url' | grep -e 'bw-linux.*' | wget -O /tmp/bitwarden-cli.zip -i -

sudo unzip /tmp/bitwarden-cli.zip -d /usr/local/bin

sudo chmod 755 /usr/local/bin/bw
