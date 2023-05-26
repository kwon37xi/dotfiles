#!/bin/sh
# todo quit kwallet
rm -rf ~/.local/backup
rm -rf ~/.local/shareDBeaverData
#rm -rf ~/.config/asbru
#rm -rf ~/.local/share/kwalletd
#rm -rf ~/.config/vivaldi/Default
rm -rf ~/.config/JetBrains
rm -rf ~/.local/share/JetBrains
#rm -rf ~/.config/copyq
rm -rf ~/.local/share/keyrings

tar xvzf home-backups.tar.gz -C ~/

~/.dotfiles/local_bin/.local/bin/restore-networkmanager.sh

# todo restart kwallet
