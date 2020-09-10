#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob
sudo apt-get -y install git
git clone https://github.com/kwon37xi/dotfiles.git ~/.dotfiles

cd ~/.dotfiles/_installer
/usr/bin/bash ~/.dotfiles/_installer/kubuntu_package_install.sh