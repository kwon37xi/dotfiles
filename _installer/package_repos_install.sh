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

sudo add-apt-repository -y --no-update ppa:jonathonf/vim
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

