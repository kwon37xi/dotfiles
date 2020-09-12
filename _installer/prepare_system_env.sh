# first change sudo
echo "### add sudo without password permission to current user ###"
echo "$USER    ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-self
sudo chmod 0440 /etc/sudoers.d/99-self

echo "### change swappiness ###"
echo "vm.swappiness=5" | sudo tee /etc/sysctl.d/99-vm_swappiness.conf

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
