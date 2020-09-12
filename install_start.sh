#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob
sudo apt-get -y install git
git clone https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

cd ~/.dotfiles/_installer
source ~/.dotfiles/_installer/config_envs

source ~/.dotfiles/_installer/prepare_system_env.sh
source ~/.dotfiles/_installer/package_repos_isntall.sh
source ~/.dotfiles/_installer/prepare_user_dirs.sh
source ~/.dotfiles/_installer/kubuntu_package_install.sh
source ~/.dotfiles/_installer/extra_package_install.sh
source ~/.dotfiles/_installer/free_korean_fonts_install.sh
source ~/.dotfiles/_installer/local_apps_install.sh
source ~/.dotfiles/_installer/dotfiles_install.sh

echo "==========================================="
echo "      installation finished. REBOOT! "
echo "==========================================="
