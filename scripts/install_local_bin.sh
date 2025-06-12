#!/usr/bin/env bash

cd "$(dirname "$0")/../bin" || exit 1
mkdir -p ~/.local/bin

for file in ./*; do
	if [ -f "${file}" ]; then
		if [ ! -e "$HOME/.local/bin/$(basename "${file%.*}")" ]; then
			ln -s "$(readlink -f "$file")" "$HOME/.local/bin/$(basename "${file%.*}")"
		fi
	fi
done

# To install next-line:
# cd ~/tmp/
# wget https://github.com/spideyclick/next-line/releases/download/v0.1.0/next-line-x86_64-unknown-linux-gnu.tar.xz
# wget https://github.com/spideyclick/next-line/releases/download/v0.1.0/next-line-x86_64-unknown-linux-gnu.tar.xz.sha256
# checksum next-line-x86_64-unknown-linux-gnu.tar.xz next-line-x86_64-unknown-linux-gnu.tar.xz.sha256
# tar -xvf next-line-x86_64-unknown-linux-gnu.tar.xz
# cp next-line-x86_64-unknown-linux-gnu/next-line ~/.local/bin/
