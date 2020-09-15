LOCAL_BASHRCS_DIR=~/.config/bashrc.d
mkdir -p $LOCAL_BASHRCS_DIR
chmod 700 $LOCAL_BASHRCS_DIR

mkdir -p ~/.local/tmp/vim/{swap,backup,undos}
mkdir -p ~/.local/opt
mkdir -p ~/.local/share/applications

# initialize bashrc.d load
echo "for bashrc in $LOCAL_BASHRCS_DIR/*.bashrc; do source \"\$bashrc\"; done;" >> ~/.bashrc

# sdkman https://sdkman.io
curl -s "https://get.sdkman.io" | bash

# jenv https://www.jenv.be
git clone https://github.com/jenv/jenv.git ~/.jenv

# bash_it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent --no-modify-config

# autostarts
echo "### autostarts ###"
mkdir -p ~/.config/autostart
cd ~/.config/autostart
cp /usr/share/applications/com.github.hluk.copyq.desktop .
cp /usr/share/applications/org.kde.yakuake.desktop . # yakuake buggy use guake
#cp /usr/share/applications/guake.desktop .

# configure guake - dconf/gsettings

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
