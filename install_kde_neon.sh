# first change sudo
echo "### add sudo without password permission to current user ###"
echo "$USER    ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-self.conf
sudo chmod 0440 /etc/sudoers.d/99-self.conf

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
	software-properties-gtk

# 저장소 미러를 빠른 곳으로 변경하고, 독점 드라이버 등을 설정하기 위해 먼저 실행
echo "### software-properties-gtk ###"
echo "  - change mirror, install proprietary drivers "
sudo software-properties-gtk

echo "### 저장소 추가 ###"
# prepare repositories
# vivaldi browser
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add
sudo add-apt-repository -y --no-update 'deb https://repo.vivaldi.com/archive/deb/ stable main'

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y --no-update "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# wine 
sudo dpkg --add-architecture i386
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository -y --no-update "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs)  main"

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
	ubuntu-restricted-addons ubuntu-restricted-extras \
	git \
	muon aptitude qapt-deb-installer \
	yakuake \
	dolphin-plugins dolphin-owncloud kio-gdrive \
	plasma-browser-integration \
	flatpak \
	plasma-discover-backend-flatpak plasma-discover-backend-snap \
	vim-gtk \
	copyq copyq-plugins \
	grub-customizer \
	vivaldi-stable \
	libreoffice libreoffice-help-ko libreoffice-l10n-ko \
	meld \
	tlp tlp-rdw tlpui \
	pinta \
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
	ubuntu-wallpapers*

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

# flatpak 설치
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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
# im-config -n fcitx

if ! [ -d ~/.fonts/free-korean-fonts ]; then
	echo "### install custom fonts ###"
	mkdir -p ~/.fonts
	cd ~/.fonts
	git clone https://github.com/kwon37xi/free-korean-fonts.git
	fc-cache -v
fi

# todo - , openjdk,  vm.swappiness=5, backgrounds,  slack, 개발환경..,  fusuma, 
# kde 단축키
# KDE font config...
# git default config,
# default project dirs
# ntfs
# kwallet git
# direnv
# autojump
# virtualbox, vagrant
