#!/bin/sh
# grub 의 경우 4k 일 때 화면 전환속도가 너무 느려서 
# grub 화면 자체를 FHD 로 변경하고 1k 테마를 적용하는게 낫다.
ansible-playbook -vv ~/.dotfiles/_installer/grub_4k_playbook.yml
