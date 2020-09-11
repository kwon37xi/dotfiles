#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob
DOTFILES_DIR=~/.dotfiles

stow -d $DOTFILES_DIR -t ~/ -S vim
stow -d $DOTFILES_DIR -t ~/ -S uim
stow -d $DOTFILES_DIR -t ~/ -S local_bin
stow -d $DOTFILES_DIR -t ~/ -S htop
stow -d $DOTFILES_DIR -t ~/ -S git
