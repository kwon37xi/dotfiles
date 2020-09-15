DOTFILES_DIR=~/.dotfiles

stow -d $DOTFILES_DIR -t ~/ -S vim
stow -d $DOTFILES_DIR -t ~/ -S uim
stow -d $DOTFILES_DIR -t ~/ -S local_bin
stow -d $DOTFILES_DIR -t ~/ -S htop
stow -d $DOTFILES_DIR -t ~/ -S git
stow -d $DOTFILES_DIR -t ~/ -S bashrc.d
stow -d $DOTFILES_DIR -t ~/ -S copyq
# todo separate personal / work git config
