#!/bin/bash

cd "$(dirname "$0")/../bin"
mkdir -p ~/.local/bin

for file in ./*; do
	if [ -f "${file}" ]; then
		if [ ! -L ~/.local/bin/${file} ]; then
			ln -s $(readlink -f "$file") ~/.local/bin/$(basename $file .sh)
		fi
	fi
done

if [ -f ~/.zshrc ]; then
	if [ ! $(grep -i "~/.local/bin" ~/.zshrc) ]; then
		echo "Adding ~/.local/bin to PATH in zshrc"
		echo PATH='${PATH:+${PATH}:}~/.local/bin' >> ~/.zshrc
	fi
fi
