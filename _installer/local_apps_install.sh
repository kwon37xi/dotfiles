LOCAL_BASHRCS_DIR=~/.config/bashrc.d
mkdir -p $LOCAL_BASHRCS_DIR
chmod 700 $LOCAL_BASHRCS_DIR

mkdir -p ~/.local/tmp/vim/{swap,backup,undos}

# initialize bashrc.d load
echo "for bashrc in $LOCAL_BASHRCS_DIR/*.bashrc; do source \"\$bashrc\"; done;" >> ~/.bashrc

# sdkman https://sdkman.io
curl -s "https://get.sdkman.io" | bash

# jenv https://www.jenv.be
git clone https://github.com/jenv/jenv.git ~/.jenv

echo 'export PATH="$HOME/.jenv/bin:$PATH"' > $LOCAL_BASHRCS_DIR/jenv.bashrc
echo 'eval "$(jenv init -)"' >> $LOCAL_BASHRCS_DIR/jenv.bashrc

# autostarts
echo "### autostarts ###"
mkdir -p ~/.config/autostart
cd ~/.config/autostart
cp /usr/share/applications/com.github.hluk.copyq.desktop .
cp /usr/share/applications/org.kde.yakuake.desktop .

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
