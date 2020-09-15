#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

# 최소 필요사항 설치
sudo apt-get -y install git ansible xz-utils unzip
git clone --depth=1 https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

cd ~/.dotfiles/_installer
source ~/.dotfiles/_installer/config_envs

ansible-playbook -vv --ask-become-pass ~/.dotfiles/_installer/prepare_system_env_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/package_repos_playbook.yml

source ~/.dotfiles/_installer/prepare_user_dirs.sh
source ~/.dotfiles/_installer/kubuntu_package_install.sh
ansible-playbook -vv ~/.dotfiles/_installer/extra_package_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/package_full_upgrade.yml

source ~/.dotfiles/_installer/free_korean_fonts_install.sh
source ~/.dotfiles/_installer/local_apps_install.sh
source ~/.dotfiles/_installer/dotfiles_install.sh

echo "==========================================="
echo "      installation finished. REBOOT! "
echo "==========================================="
