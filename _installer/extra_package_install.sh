sudo apt-get install -y \
    adoptopenjdk-11-hotspot adoptopenjdk-8-hotspot \
    java-11-amazon-corretto-jdk \
    code \
    virtualbox-${VIRTUALBOX_VERSION} \
    vagrant \
    asbru-cm \
    typora \
    unetbootin \
    kdenlive

# 실패가 잦아서 wine 패키지독립설치
sudo dpkg --add-architecture i386
sudo apt-get -y install wine winetricks playonlinux
sudo apt clean

echo "### install google chrome ###"
if ! [ -f "/usr/bin/google-chrome" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Downloads/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
    rm ~/Downloads/google-chrome-stable_current_amd64.deb
fi

echo "### install packer ###"
if ! [ -f "/opt/packer/packer" ]; then
    wget "${PACKER_ZIP_DOWNLOAD_URL}" -O /tmp/packer_linux_amd64.zip
    sudo mkdir -p /opt/packer
    sudo unzip /tmp/packer_linux_amd64.zip -d /opt/packer
    sudo chmod 0755 /opt/packer/packer
    sudo ln -s /opt/packer/packer /usr/local/bin/packer
    rm /tmp/packer_linux_amd64.zip
fi

echo "### install hugo ###"
if ! [ -f "/usr/local/bin/hugo" ]; then
    wget -q --show-progress -O /tmp/hugo_${HUGO_VERSION}_Linux-64bit.deb "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.deb"
    sudo dpkg -i /tmp/hugo_${HUGO_VERSION}_Linux-64bit.deb
    rm /tmp/hugo_${HUGO_VERSION}_Linux-64bit.deb
fi

sudo apt-get -y autoremove

if ! [ -f "/usr/bin/zoom" ]; then
    sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxcb-xtest0
    wget https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom_amd64.deb
    sudo dpkg -i /tmp/zoom_amd64.deb
    rm /tmp/zoom_amd64.deb
fi

echo "### install slack ###"
if ! [ -f "/usr/bin/slack" ]; then
    wget "https://downloads.slack-edge.com/linux_releases/slack-desktop-${SLACK_VERSION}-amd64.deb" -O /tmp/slack-desktop-${SLACK_VERSION}-amd64.deb
    sudo dpkg -i /tmp/slack-desktop-${SLACK_VERSION}-amd64.deb
    rm /tmp/slack-desktop-${SLACK_VERSION}-amd64.deb
fi

echo "### install dbeaver ###"
if ! [ -f "/usr/bin/dbeaver" ]; then
    wget "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -O /tmp/dbeaver-ce_latest_amd64.deb
    sudo dpkg -i /tmp/dbeaver-ce_latest_amd64.deb
    rm /tmp/dbeaver-ce_latest_amd64.deb
fi

echo "### install bitwarden ###"
sudo flatpak install -y flathub com.bitwarden.desktop

echo "### install JetBrains IntelliJ IDEA Ultimate ###"
if ! [ -f "$HOME/.local/share/JetBrains/ideaIU" ]; then
    mkdir -p $HOME/.local/share/JetBrains/ideaIU
    wget https://download.jetbrains.com/idea/ideaIU-${JETBRAINS_INTELLIJ_IDEA_VERSION}.tar.gz -O /tmp/ideaIU-${JETBRAINS_INTELLIJ_IDEA_VERSION}.tar.gz
    tar xvzf /tmp/ideaIU-${JETBRAINS_INTELLIJ_IDEA_VERSION}.tar.gz --strip=1 -C ~/.local/share/JetBrains/ideaIU
    rm /tmp/ideaIU-${JETBRAINS_INTELLIJ_IDEA_VERSION}.tar.gz
fi

echo "### install Lotion notion client ###"
if ! [ -d "$HOME/.local/share/lotion-${LOTION_VERSION}" ]; then
    wget -O /tmp/lotion-${LOTION_VERSION}.tar.gz "https://github.com/puneetsl/lotion/archive/V-${LOTION_VERSION}.tar.gz"
    mkdir -p ~/.local/share/lotion-${LOTION_VERSION}
    tar xvzf /tmp/lotion-${LOTION_VERSION}.tar.gz -C ~/.local/share/lotion-${LOTION_VERSION} --strip=1
    cd ~/.local/share/lotion-${LOTION_VERSION}
    ./install.sh
    cd ~
    rm /tmp/lotion-${LOTION_VERSION}.tar.gz
fi

sudo apt-get -y full-upgrade
# todo flatpak upgrade
sudo apt-get -y autoremove
