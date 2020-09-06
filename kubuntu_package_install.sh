#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

source ./config.sh

# first change sudo
echo "### add sudo without password permission to current user ###"
echo "$USER    ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-self
sudo chmod 0440 /etc/sudoers.d/99-self

echo "### change swappiness ###"
echo "vm.swappiness=5" | sudo tee /etc/sysctl.d/99-vm_swappiness.conf

# change default directory names to english (Downloads, Desktop, ...)
echo "### 사용자 디렉토리 변경 ###"
xdg-user-dirs-update --set DESKTOP $HOME/Desktop
if [ -d ~/바탕화면 ]; then
    mv ~/바탕화면 ~/Desktop
fi

xdg-user-dirs-update --set DOWNLOAD $HOME/Downloads
if [ -d ~/다운로드 ]; then
    mv ~/다운로드 ~/Downloads
fi

xdg-user-dirs-update --set TEMPLATES $HOME/Templates
if [ -d ~/템플릿 ]; then
    mv ~/템플릿 ~/Templates
fi

xdg-user-dirs-update --set PUBLICSHARE $HOME/Public
if [ -d ~/공개 ]; then
    mv ~/공개 ~/Public
fi

xdg-user-dirs-update --set DOCUMENTS $HOME/Documents
if [ -d ~/문서 ]; then
    mv ~/문서 ~/Documents
fi

xdg-user-dirs-update --set MUSIC $HOME/Music
if [ -d ~/음악 ]; then
    mv ~/음악 ~/Music
fi

xdg-user-dirs-update --set PICTURES $HOME/Pictures
if [ -d ~/사진 ]; then
    mv ~/사진 ~/Pictures
fi

xdg-user-dirs-update --set VIDEOS $HOME/Videos
if [ -d ~/비디오 ]; then
    mv ~/비디오 ~/Videos
fi

echo "### change Ubuntu mirror to Kakao ###"
sudo sed -i.bak -e 's/http:\/\/kr.archive.ubuntu.com/http:\/\/mirror.kakao.com/g' /etc/apt/sources.list
sudo apt-get update

echo "### Install base packages ###"
sudo apt-get install -y apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    software-properties-qt \
    unzip unrar p7zip-full \
    curl

sudo apt-get clean

echo "### 저장소 추가 ###"
# prepare repositories
# vivaldi browser
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add
sudo add-apt-repository -y --no-update 'deb https://repo.vivaldi.com/archive/deb/ stable main'

# docker - ubuntu 기본 제공 docker 를 사용한다. docker 에서 제공하는 Ubuntu Repository 는 LTS만 지원한다.
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository -y --no-update "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# wine 
sudo dpkg --add-architecture i386
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository -y --no-update "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs)  main"

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

sudo add-apt-repository -y --no-update ppa:gezakovacs/ppa
sudo add-apt-repository -y --no-update ppa:git-core/ppa
sudo add-apt-repository -y --no-update ppa:graphics-drivers/ppa
sudo add-apt-repository -y --no-update ppa:pinta-maintainers/pinta-stable
sudo add-apt-repository -y --no-update ppa:linrunner/tlp
# for tlpui
sudo add-apt-repository -y --no-update ppa:linuxuprising/apps
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
    build-essential \
    code \
    java-common  \
    openjdk-11-jdk \
    adoptopenjdk-11-hotspot adoptopenjdk-8-hotspot \
    java-11-amazon-corretto-jdk \
    virtualbox-${VIRTUALBOX_VERSION} \
    freerdp2-x11 \
    direnv \
    autojump \
    unetbootin \
    asbru-cm  \
    openssh-server openssh-sftp-server \
    stow

sudo apt-get clean

# flatpak 설치
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


echo "### install wine-stable ###"
sudo apt-get install -y --install-recommends winehq-stable winetricks
sudo apt-get clean

echo "### install google chrome ###"
if ! [ -f "/usr/bin/google-chrome" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Downloads/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
fi

#echo "### install naver whale ###"
#if ! [ -f "/usr/bin/naver-whale" ]; then
#    wget http://update.whale.naver.net/downloads/installers/naver-whale-stable_amd64.deb  -O ~/Downloads/naver-whale-stable_amd64.deb
#    sudo dpkg -i ~/Downloads/naver-whale-stable_amd64.deb
#fi

echo "### install vagrant ###"
if ! [ -f "/usr/bin/vagrant" ]; then
    wget "$VAGRANT_PACKAGE_DOWNLOAD_URL" -O "/tmp/${VAGRANT_DEB_FILENAME}"
    sudo dpkg -i "/tmp/${VAGRANT_DEB_FILENAME}"
fi

echo "### install packer ###"
if ! [ -f "/opt/packer/packer" ]; then
    wget "${PACKER_ZIP_DOWNLOAD_URL}" -O /tmp/packer_linux_amd64.zip
    sudo mkdir -p /opt/packer
    sudo unzip /tmp/packer_linux_amd64.zip -d /opt/packer
    sudo chmod 0755 /opt/packer/packer
    sudo ln -s /opt/packer/packer /usr/local/bin/packer
fi

echo "### install hugo ###"
if ! [ -f "/usr/local/bin/hugo" ]; then
    wget -q --show-progress -O /tmp/hugo_${HUGO_VERSION}_Linux-64bit.deb "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.deb"
    sudo dpkg -i /tmp/hugo_${HUGO_VERSION}_Linux-64bit.deb
fi

sudo apt-get -y autoremove

# autostarts
echo "### autostarts ###"
mkdir -p ~/.config/autostart
cd ~/.config/autostart
cp /usr/share/applications/com.github.hluk.copyq.desktop .
cp /usr/share/applications/org.kde.yakuake.desktop .

# docker
echo "### configure docker ###"
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo service docker restart
# newgrp 는 그 아래의 모든 셸 스크립트를 중단시켜버림.
# newgrp docker


echo "### install custom fonts ###"
if ! [ -d ~/.fonts/free-korean-fonts ]; then
    mkdir -p ~/.fonts
    cd ~/.fonts
    git clone https://github.com/kwon37xi/free-korean-fonts.git
    fc-cache -v
fi

if ! [ -f "/usr/bin/zoom" ]; then
    sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxcb-xtest
    wget https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom_amd64.deb
    sudo dpkg -i /tmp/zoom_amd64.deb
fi

echo "### install slack ###"
if ! [ -f "/usr/bin/slack" ]; then
    wget "https://downloads.slack-edge.com/linux_releases/slack-desktop-${SLACK_VERSION}-amd64.deb" -O /tmp/slack-desktop-${SLACK_VERSION}-amd64.deb
    sudo dpkg -i /tmp/slack-desktop-${SLACK_VERSION}-amd64.deb
fi

echo "### install dbeaver ###"
if ! [ -f "/usr/bin/dbeaver" ]; then
    wget "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -O /tmp/dbeaver-ce_latest_amd64.deb
    sudo dpkg -i /tmp/dbeaver-ce_latest_amd64.deb
fi

echo "### install bitwarden ###"
sudo flatpak install -y flathub com.bitwarden.desktop

echo "### uim-toolbar config ###"
# change input method to fcitx - no need
im-config -n uim

sudo update-alternatives --install /usr/bin/uim-toolbar uim-toolbar  /usr/bin/uim-toolbar-qt5 100
sudo update-alternatives --set uim-toolbar /usr/bin/uim-toolbar-qt5
#sudo update-alternatives --install /usr/bin/uim-toolbar uim-toolbar  /usr/bin/uim-toolbar-gtk3-systray 100
#sudo update-alternatives --set uim-toolbar /usr/bin/uim-toolbar-gtk3-systray
! [ -f /usr/bin/uim-im-switcher-qt4 ] && sudo ln -s /usr/bin/uim-im-switcher-qt5 /usr/bin/uim-im-switcher-qt4
! [ -f /usr/bin/uim-pref-qt4 ] && sudo ln -s /usr/bin/uim-pref-qt5 /usr/bin/uim-pref-qt4

echo "### install JetBrains Toolbox ###"
if ! [ -f "$HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox" ]; then
    wget "https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-${JETBRAINS_TOOLBOX_VERSION}.tar.gz" -O /tmp/jetbrains-toolbox.tar.gz
    cd /tmp
    tar xvzf  jetbrains-toolbox.tar.gz
    cd "jetbrains-toolbox-${JETBRAINS_TOOLBOX_VERSION}"
    ./jetbrains-toolbox 
fi

echo "### install Lotion notion client ###"
if ! [ -d "$HOME/.local/share/lotion-${LOTION_VERSION}" ]; then
    wget -O /tmp/lotion-${LOTION_VERSION}.tar.gz "https://github.com/puneetsl/lotion/archive/V-${LOTION_VERSION}.tar.gz"
    mkdir -p ~/.local/share/lotion-${LOTION_VERSION}
    tar xvzf /tmp/lotion-${LOTION_VERSION}.tar.gz -C ~/.local/share/lotion-${LOTION_VERSION} --strip=1
    cd ~/.local/share/lotion-${LOTION_VERSION}
    ./install.sh
    cd ~
fi

sudo apt-get -y upgrade
sudo apt-get -y autoremove

echo "finished...."

# todo - , fusuma, 
# kde 단축키
# KDE font config...
# git default config, credential helper
# kwallet git
# ssh passphrase
# sdkman, jenv
# debcoker
# vpn, wifi
# vivaldi 자동 설정
# keepassxc 혹은 unix pass
# ntfs
# grub theme, grub font
# tusk, markdown tool
