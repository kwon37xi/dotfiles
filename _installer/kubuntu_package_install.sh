echo "### 필수 소프트웨어 자동 설치"
# ttf-mscorefonts-installer auto install : https://askubuntu.com/questions/16225/how-can-i-accept-the-microsoft-eula-agreement-for-ttf-mscorefonts-installer
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

sudo apt-get install -y inxi \
    kubuntu-restricted-addons kubuntu-restricted-extras \
    htop \
    git \
    muon aptitude qapt-deb-installer debocker \
    plasma-discover-backend-flatpak plasma-discover-backend-snap plasma-discover-backend-fwupd \
    yakuake \
    dolphin-plugins dolphin-owncloud kio-gdrive dolphin-plugins \
    plasma-browser-integration \
    flatpak \
    vim-gtk \
    copyq copyq-plugins \
    grub-customizer \
    vivaldi-stable \
    libreoffice libreoffice-help-ko libreoffice-l10n-ko \
    meld \
    tlp tlp-rdw tlpui \
    krita krita-l10n \
    gimp gimp-gmic \
    vlc smplayer youtube-dl audacious \
    ufw gufw \
    docker docker-compose \
    ctop \
    openconnect network-manager-openconnect \
    openfortivpn network-manager-fortisslvpn \
    universal-ctags fzf \
    ripgrep \
    tmux \
    fonts-alee \
    fonts-lexi-gulim \
    fonts-lexi-saebom \
    fonts-nanum \
    fonts-nanum-coding \
    fonts-nanum-eco \
    fonts-nanum-extra \
    fonts-naver-d2coding \
    fonts-unfonts-core \
    fonts-unfonts-extra \
    fonts-noto-cjk fonts-noto-cjk-extra \
    ttf-mscorefonts-installer \
    uim uim-byeoru \
    build-essential make cmake \
    openssh-server openssh-sftp-server sshpass ksshaskpass putty putty-tools openssh-client \
    java-common  \
    openjdk-11-jdk \
    freerdp2-x11 \
    direnv \
    autojump \
    stow

# flatpak 설치
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# docker
echo "### configure docker ###"
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo service docker restart
# newgrp 는 그 아래의 모든 셸 스크립트를 중단시켜버림.
# newgrp docker

echo "### uim-toolbar config ###"
# change input method to fcitx - no need
im-config -n uim

sudo update-alternatives --install /usr/bin/uim-toolbar uim-toolbar  /usr/bin/uim-toolbar-qt5 100
sudo update-alternatives --set uim-toolbar /usr/bin/uim-toolbar-qt5
#sudo update-alternatives --install /usr/bin/uim-toolbar uim-toolbar  /usr/bin/uim-toolbar-gtk3-systray 100
#sudo update-alternatives --set uim-toolbar /usr/bin/uim-toolbar-gtk3-systray
! [ -f /usr/bin/uim-im-switcher-qt4 ] && sudo ln -s /usr/bin/uim-im-switcher-qt5 /usr/bin/uim-im-switcher-qt4
! [ -f /usr/bin/uim-pref-qt4 ] && sudo ln -s /usr/bin/uim-pref-qt5 /usr/bin/uim-pref-qt4

# fusuma, 
# kde 단축키
# KDE font config...
# git default config, credential helper
# kwallet git
# ssh passphrase
# debcoker
# vpn, wifi
# vivaldi 자동 설정
# keepassxc 혹은 unix pass
# ntfs
# grub theme, grub font
# asbrucm recover
# dbeaver backup & recover
# google-drive ocamelfuse
# intellij
