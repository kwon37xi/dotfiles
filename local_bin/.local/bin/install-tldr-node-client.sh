#!/bin/bash
mkdir -p ~/.local/share/tldr
cd ~/.local/share/tldr
npm install tldr

mkdir -p ~/.local/bin
rm -f ~/.local/bin/tldr
ln -s ~/.local/share/tldr/node_modules/tldr/bin/tldr ~/.local/bin/tldr
