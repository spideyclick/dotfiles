#!/bin/bash

cd "$(dirname "$0")"

echo $PREFIX | grep termux
if [ $? -eq 0 ]; then
  echo "Termux detected; installing binutils"
	pkg install binutils
fi

if [ ! $(command -v cargo) ]; then
  echo "Installing Cargo..."
	curl https://sh.rustup.rs -sSf | sh
fi

echo "Installing sccache..."
cargo install --locked sccache
export RUSTC_WRAPPER=$(which sccache)

echo "Installing cargo-update..."
cargo install cargo-update
cargo-update

echo "Installing all the good stuff"
cargo install zellij
cargo install-update zellij
cargo install helix
cargo install-update helix
cargo install jless
cargo install-update jless
cargo install exa
cargo install-update exa
cargo install bat
cargo install-update bat
cargo install mprocs
cargo install-update mprocs
cargo install ripgrep
cargo install-update ripgrep
cargo install irust
cargo install-update irust
cargo install bacon
cargo install-update bacon
cargo install cargo-info
cargo install-update cargo-info
cargo install speedtest-rs
cargo install-update speedtest-rs
cargo install rtx-cli
cargo install-update rtx-cli
gargo install joshuto
cargo install-update joshuto
# Wezterm is going to be platform specific
# cargo install wezterm
# cargo install-update wezterm

