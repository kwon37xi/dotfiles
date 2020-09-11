#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

LOCAL_BASHRCS_DIR=~/.local/bashrcs

mkdir -p $LOCAL_BASHRCS_DIR
mkdir -p ~/.local/tmp/vim/{swap,backup,undos}

# sdkman https://sdkman.io
curl -s "https://get.sdkman.io" | bash

# jenv https://www.jenv.be
git clone https://github.com/jenv/jenv.git ~/.jenv

echo 'export PATH="$HOME/.jenv/bin:$PATH"' > $LOCAL_BASHRCS_DIR/jenvrc
echo 'eval "$(jenv init -)"' >> $LOCAL_BASHRCS_DIR/jenvrc

# todo add JDKs to jenv

# todo read rcfiles

# fusuma, 
# kde 단축키
# KDE font config...
# git default config, credential helper
# kwallet git
# ssh passphrase
# sdkman, jenv
# vpn, wifi
# vivaldi 자동 설정
# keepassxc 혹은 unix pass
# intellij auto config
