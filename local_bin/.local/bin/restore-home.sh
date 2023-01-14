#!/bin/sh
# todo quit kwallet
rm -rf ~/.local/backup
rm -rf ~/.local/shareDBeaverData
#rm -rf ~/.config/asbru
#rm -rf ~/.local/share/kwalletd
#rm -rf ~/.config/vivaldi/Default
rm -rf ~/.var/app/com.jetbrains.IntelliJ-IDEA-Ultimate
#rm -rf ~/.config/copyq
rm -rf ~/.local/share/keyrings

tar xvzf home-backups.tar.gz -C ~/

~/.dotfiles/local_bin/.local/bin/restore-networkmanager.sh

# todo restart kwallet
