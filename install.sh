#!/usr/bin/env bash

echo "Setting up dotfiles"
cd "$(dirname $0)" || exit

### Detect OS
echo "$PREFIX" | grep termux
if [ $? -eq 0 ]; then
  echo "Termux detected"
  ./setup_termux.sh
  exit 0
fi
OS_ID=$(grep -ioP '^ID=\K\S+$' /etc/os-release)
echo "Current OS appears to be: ${OS_ID}"
if [[ ${OS_ID} == "debian" ]]; then
  echo "Debian detected"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew bundle install ./Brewfile
  ./scripts/install_local_bin.sh
  ./scripts/install_configs.sh
else
  echo "OS unknown: ${OS_ID}"
fi
