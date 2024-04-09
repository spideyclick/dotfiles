#!/usr/bin/env bash

cd "$(dirname $0)/../config" || exit

ln -s .zshrc ~/.zshrc
ln -s .helix ~/.config/helix
ln -s .joshuto ~/.config/joshuto
ln -s .lazygit ~/.config/lazygit
ln -s .ranger ~/.config/ranger

