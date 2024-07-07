#!/usr/bin/env bash

cd "$(dirname "$0")/../bin"
mkdir -p ~/.local/bin

for file in ./*; do
	if [ -f "${file}" ]; then
		if [ ! -L ~/.local/bin/${file} ]; then
			ln -s $(readlink -f "$file") ~/.local/bin/$(basename ${file%.*})
		fi
	fi
done
