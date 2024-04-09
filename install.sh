#!/usr/bin/env bash

echo "Setting up dotfiles"
cd $(dirname $0)

### Detect OS
echo $PREFIX | grep termux
if [ $? -eq 0 ]; then
  echo "Termux detected"
  ./setup_termux.sh
  exit 0
fi
OS_ID=$(grep -ioP '^ID=\K\S+$' /etc/os-release)
echo "Current OS appears to be: ${OS_ID}"
if [[ ${OS_ID} == "debian" ]]; then
  echo "Debian detected"
else
  echo "OS unknown: ${OS_ID}"
fi


# cp -ra ../config/. ~/.config/
# cp ~/.config/.tmux.conf ~
# cp ~/.config/.zshrc ~

# mkdir -p ~/.config/zellij/plugins
# if [ ! -f ~/.config/zellij/plugins/room.wasm ]; then
#   curl -L "https://github.com/rvcas/room/releases/latest/download/room.wasm" -o ~/.config/zellij/plugins/room.wasm
# fi

