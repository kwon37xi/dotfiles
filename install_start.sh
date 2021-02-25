#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

# 최소 필요사항 설치
set +x
echo -n "Password for sudo: "
read -s SUDO_PASSWORD
echo "$SUDO_PASSWORD" | sudo -S apt-get -y install git ansible xz-utils unzip
set -x

ansible-galaxy collection install community.general

git clone https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

ansible-playbook -vv ~/.dotfiles/_installer/prepare_system_env_playbook.yml --extra-vars="ansible_become_pass='{{ lookup('env', 'SUDO_PASSWORD') }}'"

ansible-playbook -vv ~/.dotfiles/_installer/package_repos_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/common_package_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/gnome_package_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/prepare_user_dirs_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/extra_package_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/meganz_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/package_full_upgrade.yml

ansible-playbook -vv ~/.dotfiles/_installer/free_korean_fonts_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/firewall_config_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/local_apps_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/homebrew_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/fusuma_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/local_dotfiles_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/local_gnome_configs_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/local_jdk_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/grub_themes_install_playbook.yml

ansible-playbook -vv ~/.dotfiles/_installer/local_develop_env_playbook.yml

echo "      installation finished. REBOOT! "
