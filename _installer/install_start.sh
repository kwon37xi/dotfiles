#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob
sudo apt-get -y install git
git clone https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

cd ~/.dotfiles/_installer
/bin/bash ~/.dotfiles/_installer/kubuntu_package_install.sh
/bin/bash ~/.dotfiles/_installer/local_apps_install.sh
/bin/bash ~/.dotfiles/_installer/dotfiles_install.sh

echo "==========================================="
echo "      installation finished. REBOOT! "
echo "==========================================="
