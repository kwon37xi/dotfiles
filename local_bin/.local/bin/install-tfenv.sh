#!/bin/sh
mkdir -p $HOME/.local/share/tfenv
rm -rf $HOME/.local/share/tfenv
git clone https://github.com/tfutils/tfenv.git $HOME/.local/share/tfenv
ln -s $HOME/.local/share/tfenv/bin/* $HOME/.local/bin

tfenv install latest
tfenv use latest
