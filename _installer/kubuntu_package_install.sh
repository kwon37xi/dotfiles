echo "### 저장소 추가 ###"
# prepare repositories
# vivaldi browser
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add
sudo add-apt-repository -y --no-update 'deb https://repo.vivaldi.com/archive/deb/ stable main'

# docker - ubuntu 기본 제공 docker 를 사용한다. docker 에서 제공하는 Ubuntu Repository 는 LTS만 지원한다.
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository -y --no-update "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# adopt-openjdk https://adoptopenjdk.net/installation.html#linux-pkg
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository -y --no-update "https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/"

# correto jdk https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/generic-linux-install.html
wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add -
sudo add-apt-repository -y --no-update 'deb https://apt.corretto.aws stable main'

# virtualbox  https://www.virtualbox.org/wiki/Linux_Downloads
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo add-apt-repository -y --no-update "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

# vscode
sudo sh -c 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg'
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# asbru-cm
curl -s https://packagecloud.io/install/repositories/asbru-cm/asbru-cm/script.deb.sh | sudo bash

# typora markdown editor
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository -y --no-update 'deb https://typora.io/linux ./'

sudo add-apt-repository -y --no-update ppa:gezakovacs/ppa
sudo add-apt-repository -y --no-update ppa:git-core/ppa
sudo add-apt-repository -y --no-update ppa:graphics-drivers/ppa
sudo add-apt-repository -y --no-update ppa:pinta-maintainers/pinta-stable
sudo add-apt-repository -y --no-update ppa:linrunner/tlp
# for tlpui
sudo add-apt-repository -y --no-update ppa:linuxuprising/apps
sudo add-apt-repository -y --no-update ppa:kdenlive/kdenlive-stable
sudo apt-add-repository -y --no-update multiverse
sudo apt-add-repository -y --no-update universe

# update all
sudo apt-get update

echo "### 필수 소프트웨어 자동 설치"
# plasma-discover-backend-fwupd 는 설치 불필요
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
    pinta krita krita-l10n \
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
