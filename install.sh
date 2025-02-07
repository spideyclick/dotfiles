#!/usr/bin/env bash

echo "Setting up dotfiles"
cd "$(dirname "$0")" || exit

# Install Configs
echo "Installing local configs"
./scripts/install_configs.sh

# Symlink Bin
echo "Installing local bin"
./scripts/install_local_bin.sh

### Handle Termux
if echo "$PREFIX" | grep termux; then
	echo "Termux detected"
	./setup_termux.sh
	exit 0
fi

### Detect OS
OS_ID=$(grep -ioP '^ID=\K\S+$' /etc/os-release)
echo "Current OS appears to be: ${OS_ID}"
if [ ! -d ~/isomorphic_copy ]; then
	echo "Downloading isomorphic_copy"
	git clone https://github.com/ms-jpq/isomorphic_copy.git ~/isomorphic_copy
fi

echo "Installing HomeBrew Packages"
if ! command -v brew &> /dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
brew bundle

echo "Installing WSL Extras"
./scripts/wsl_additions.sh

if [[ ! -f ~/.local/bin/rgr ]]; then
	echo "Installing rgr"
	wget -qO- https://github.com/acheronfail/repgrep/releases/download/0.15.0/repgrep-0.15.0-x86_64-unknown-linux-gnu.tar.gz \
	| tar --strip-components=1 -xzf - -C ~/.local/bin repgrep-0.15.0-x86_64-unknown-linux-gnu/rgr
fi

### Auto zide setup
# Disabling for now since I'm using uv for depencies
# if [ -f /usr/src/app/pyproject.toml ]; then
# 	cd /usr/src/app || exit 1
# 	~/dotfiles/zide/link.sh
# fi
