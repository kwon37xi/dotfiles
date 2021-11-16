#!/bin/bash
mkdir -p ~/.local/bin
wget https://github.com/srevinsaju/zap/releases/download/continuous/zap-amd64 -O ~/.local/bin/zap
chmod +x ~/.local/bin/zap
~/.local/bin/zap --help
