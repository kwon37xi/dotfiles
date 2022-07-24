#!/bin/sh
# https://jdk.java.net/jmc/

rm -f /tmp/jmc.tar.gz

curl "https://download.java.net/java/GA/jmc8/03/binaries/jmc-8.2.1_linux-x64.tar.gz" -o /tmp/jmc.tar.gz

rm -rf ~/.local/opt/jmc
mkdir -p ~/.local/opt/jmc
tar xvzf /tmp/jmc.tar.gz --strip=2 --directory="$HOME/.local/opt/jmc"

# vm 옵션지정 : OpenJDK 11
sed -i.bak 's/-vmargs/-vm\n\/usr\/lib\/jvm\/java-11-openjdk-amd64\/bin\n-vmargs/' ~/.local/opt/jmc/jmc.ini
