#!/bin/bash

cd "$(dirname "$0")"

echo $PREFIX | grep termux
if [ $? -eq 0 ]; then
  echo "Termux detected; installing binutils"
	pkg install binutils
fi

if [[ $(command -v apt) ]]; then
  sudo apt install build-essential pkg-config libssl-dev
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
cargo install bacon
cargo install-update bacon
cargo install irust
cargo install-update irust
cargo install cargo-info
cargo install-update cargo-info
cargo install dioxus-cli
cargo install-update dioxus-cli

