#!/bin/sh
# fzf latest release download and install

sudo rm -f /tmp/fzf-latest.tar.gz
curl -sL https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r '.assets[].browser_download_url' | grep -e '.*-linux_amd64.tar.gz' | wget -O /tmp/fzf-latest.tar.gz -i -

sudo tar xvzf /tmp/fzf-latest.tar.gz --directory=/usr/local/bin

sudo chmod 755 /usr/local/bin/fzf

# bash completion and keybindings
sudo mkdir -p /usr/local/share/fzf

wget -O /usr/local/share/fzf/completion.bash https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash
wget -O /usr/local/share/fzf/key-bindings.bash https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash
