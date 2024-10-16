#!/usr/bin/env bash

set -e

if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
	echo "System is not WSL, exiting wsl_additions script"
fi


# Instal wslu on debian
OS_ID=$(grep -ioP '^ID=\K\S+$' /etc/os-release)
if [[ ${OS_ID} == "debian" ]]; then
	echo "Installing WSL Utilities (wslu) on Debain"
	sudo apt-get install -y gnupg2 apt-transport-https
	wget -O - https://pkg.wslutiliti.es/public.key \
		| sudo gpg -o /etc/apt/keyrings/wslu-archive-keyring.pgp --dearmor
	echo "deb [signed-by=/etc/apt/keyrings/wslu-archive-keyring.pgp] https://pkg.wslutiliti.es/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") main" | sudo tee /etc/apt/sources.list.d/wslu.list
	sudo apt-get update
	sudo apt-get install -y wslu
fi
