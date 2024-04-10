#!/usr/bin/env bash

mkdir -p ~/.config
cd "$(dirname $0)/../config" || exit

ln -s .zshrc ~/.zshrc
ln -s starship.toml ~/.config/starship.toml
ln -s helix ~/.config/helix
ln -s joshuto ~/.config/joshuto
ln -s lazygit ~/.config/lazygit
ln -s ranger ~/.config/ranger

