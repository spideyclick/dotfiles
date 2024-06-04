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
	# Manually install rgr to local bin
	wget -qO- https://github.com/acheronfail/repgrep/releases/download/0.15.0/repgrep-0.15.0-x86_64-unknown-linux-gnu.tar.gz \
		| tar --strip-components=1 -xzf - -C ~/.local/bin repgrep-0.15.0-x86_64-unknown-linux-gnu/rgr
	./scripts/install_local_bin.sh
	./scripts/install_configs.sh
else
	echo "No handler for current OS found - exiting"
fi
