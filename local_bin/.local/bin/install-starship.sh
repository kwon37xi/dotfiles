#!/bin/sh
mkdir -p $HOME/.local/bin
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --force --platform=unknown-linux-gnu --bin-dir=$HOME/.local/bin

