#!/bin/sh
rm -rf /home/kwon37xi/.local/opt/JetBrains/ideaIU
ansible-playbook -vv ~/.dotfiles/_installer/main_playbook.yml --step --start-at-task "IntelliJ IDEA target dir"
