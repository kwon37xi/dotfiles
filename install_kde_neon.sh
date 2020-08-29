#!/bin/bash
# error 발생시 즉각 중단.
set -e
VAGRANT_VERSION="2.2.10"
VAGRANT_DEB_FILENAME="vagrant_${VAGRANT_VERSION}_x86_64.deb"
VAGRANT_PACKAGE_DOWNLOAD_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/${VAGRANT_DEB_FILENAME}"
PACKER_VERSION="1.6.1"
PACKER_ZIP_DOWNLOAD_URL="https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"
VIRTUALBOX_VERSION="6.1"

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

echo "### Install base packages ###"
sudo apt-get install -y apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common \
	software-properties-gtk \
	unzip unrar p7zip-full

# 저장소 미러를 빠른 곳으로 변경하고, 독점 드라이버 등을 설정하기 위해 먼저 실행
echo "### software-properties-gtk ###"
echo "  - change mirror, install proprietary drivers "
sudo software-properties-gtk

echo "### 저장소 추가 ###"
# prepare repositories
# vivaldi browser
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add
sudo add-apt-repository -y --no-update 'deb https://repo.vivaldi.com/archive/deb/ stable main'

# docker - ubuntu 기본 제공 docker 를 사용한다.
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

# node.js LTS
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# virtualbox  https://www.virtualbox.org/wiki/Linux_Downloads
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo add-apt-repository -y --no-update "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

sudo add-apt-repository -y --no-update ppa:git-core/ppa
sudo add-apt-repository -y --no-update ppa:libreoffice/ppa
sudo add-apt-repository -y --no-update ppa:graphics-drivers/ppa
sudo add-apt-repository -y --no-update ppa:pinta-maintainers/pinta-stable
sudo add-apt-repository -y --no-update ppa:linrunner/tlp
# for tlpui
sudo add-apt-repository -y --no-update ppa:linuxuprising/apps
sudo apt-add-repository -y --no-update multiverse
sudo apt-add-repository -y --no-update universe

# update all
sudo apt-get update
sudo apt-get -y upgrade

echo "### 필수 소프트웨어 자동 설치"
# plasma-discover-backend-fwupd 는 설치 불필요
sudo apt-get install -y inxi \
	kubuntu-restricted-addons kubuntu-restricted-extras \
	git \
	muon aptitude qapt-deb-installer \
	yakuake \
	dolphin-plugins dolphin-owncloud kio-gdrive \
	plasma-browser-integration \
	flatpak \
	plasma-discover-backend-flatpak plasma-discover-backend-snap plasma-discover-backend-fwupd \
	vim-gtk \
	copyq copyq-plugins \
	grub-customizer \
	vivaldi-stable \
	libreoffice libreoffice-help-ko libreoffice-l10n-ko \
	meld \
	tlp tlp-rdw tlpui \
	pinta \
    krita krita-l10n \
	gimp gimp-gmic \
	vlc smplayer \
	ufw gufw \
	docker-ce docker-ce-cli containerd.io docker-compose \
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
	fonts-noto* \
	plasma-wallpapers-addons \
    build-essential \
	java-common  \
	adoptopenjdk-11-hotspot adoptopenjdk-8-hotspot \
	java-11-amazon-corretto-jdk \
    nodejs \
	virtualbox-${VIRTUALBOX_VERSION} \
	direnv \
	autojump \
	stow

# flatpak 설치
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "### install wine-stable ###"
sudo apt-get install --install-recommends winehq-stable winetricks

echo "### install google chrome ###"
if ! [ -f "/usr/bin/google-chrome" ]; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Downloads/google-chrome-stable_current_amd64.deb
	sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
fi

echo "### install naver whale ###"
if ! [ -f "/usr/bin/naver-whale" ]; then
	wget http://update.whale.naver.net/downloads/installers/naver-whale-stable_amd64.deb  -O ~/Downloads/naver-whale-stable_amd64.deb
	sudo dpkg -i ~/Downloads/naver-whale-stable_amd64.deb
fi


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

# change input method to fcitx - no need
im-config -n fcitx

echo "### install custom fonts ###"
if ! [ -d ~/.fonts/free-korean-fonts ]; then
	mkdir -p ~/.fonts
	cd ~/.fonts
	git clone https://github.com/kwon37xi/free-korean-fonts.git
	fc-cache -v
fi

if ! [ -f "/usr/bin/zoom" ]; then
    wget https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom_amd64.deb
    sudo dpkg -i /tmp/zoom_amd64.deb
fi

# todo - , 개발환경..,  fusuma, 
# kde 단축키
# KDE font config...
# git default config,
# ntfs
# kwallet git
# dbeaver
# intellij
# vscode
# sdkman, jenv, zulu
