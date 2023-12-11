#!/bin/bash

cd "$(dirname "$0")"

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
  ./install_nix_on_debian.sh
else
  echo "OS unknown: ${OS_ID}"
fi

./install_dotfiles.sh
