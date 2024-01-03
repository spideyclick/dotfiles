#!/usr/bin/env bash

cd $(dirname $0)

cp -ra ../config/. ~/.config/
cp ~/.config/.tmux.conf ~
cp ~/.config/.zshrc ~

mkdir -p ~/.config/zellij/plugins
if [ ! -f ~/.config/zellij/plugins/room.wasm ]; then
  curl -L "https://github.com/rvcas/room/releases/latest/download/room.wasm" -o ~/.config/zellij/plugins/room.wasm
fi
