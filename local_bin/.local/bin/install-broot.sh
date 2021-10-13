#!/bin/sh
# https://dystroy.org/broot/

sudo rm -f /usr/local/bin/broot
sudo wget -O /usr/local/bin/broot "https://dystroy.org/broot/download/x86_64-linux/broot"
sudo chmod 755 /usr/local/bin/broot

# need to install bash shell br function
broot --print-shell-function bash > $HOME/.config/bashrc.d/broot-br.bashrc
broot --set-install-state installed
