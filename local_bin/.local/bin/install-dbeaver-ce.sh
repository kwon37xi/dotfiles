#!/bin/sh
wget -O /tmp/dbeaver-ce_latest_amd64.deb "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
sudo apt install /tmp/dbeaver-ce_latest_amd64.deb
rm /tmp/dbeaver-ce_latest_amd64.deb
