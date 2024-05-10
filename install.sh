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
if [[ ${OS_ID} == "debian" || ${OS_ID} == "ubuntu" || ${OS_ID} == "linuxmint" ]]; then
	echo "This OS should be able to work with the homebrew strategy"
	if ! command -v brew &> /dev/null; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	fi
	brew bundle
	./scripts/install_local_bin.sh
	./scripts/install_configs.sh
else
	echo "No handler for current OS found - exiting"
fi
