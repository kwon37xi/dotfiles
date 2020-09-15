DOTFILES_DIR=~/.dotfiles

stow -d $DOTFILES_DIR -t ~/ -S vim
stow -d $DOTFILES_DIR -t ~/ -S uim
stow -d $DOTFILES_DIR -t ~/ -S local_bin
stow -d $DOTFILES_DIR -t ~/ -S htop
stow -d $DOTFILES_DIR -t ~/ -S git
stow -d $DOTFILES_DIR -t ~/ -S bashrc.d
stow -d $DOTFILES_DIR -t ~/ -S copyq

# 겹치는 KDE 설정을 미리 삭제해둬야한다.
# restart kde global shortcut manager
kquitapp5 kglobalaccel
rm ~/.config/kglobalshortcutsrc
stow -d $DOTFILES_DIR -t ~/ -S kde
kglobalaccel5 &

# todo separate personal / work git config
