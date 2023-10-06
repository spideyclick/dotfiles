#!/bin/bash

cd "$(dirname "$0")"

### Detect OS
OS_ID=$(grep -ioP '^ID=\K\S+$' /etc/os-release)
echo "Current OS appears to be: ${OS_ID}"
if [[ ${OS_ID} == "debian" ]]; then
  echo "Debian detected"
  ./install_nix_on_debian.sh
else
  echo "OS unknown: ${OS_ID}"
fi

./install_dotfiles.sh
