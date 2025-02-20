#!/usr/bin/env bash

cd "$(dirname $0)/../config" || exit

config_dir="${HOME}/.config"
dotfiles_config_dir="${HOME}/dotfiles/config"

mkdir -p "$config_dir"

# Symlinked Directories
if [ ! -e "${config_dir}/bat" ]; then ln -s "${dotfiles_config_dir}/bat" "${config_dir}/bat"; fi
if [ ! -e "${config_dir}/helix" ]; then ln -s "${dotfiles_config_dir}/helix" "${config_dir}/helix"; fi
if [ ! -e "${config_dir}/joshuto" ]; then ln -s "${dotfiles_config_dir}/joshuto" "${config_dir}/joshuto"; fi
if [ ! -e "${config_dir}/pet" ]; then ln -s "${dotfiles_config_dir}/pet" "${config_dir}/pet"; fi
if [ ! -e "${config_dir}/posting" ]; then ln -s "${dotfiles_config_dir}/posting" "${config_dir}/posting"; fi
if [ ! -e "${config_dir}/ranger" ]; then ln -s "${dotfiles_config_dir}/ranger" "${config_dir}/ranger"; fi
if [ ! -e "${config_dir}/zellij" ]; then ln -s "${dotfiles_config_dir}/zellij" "${config_dir}/zellij"; fi
if [ ! -e "${config_dir}/lazygit" ]; then ln -s "${dotfiles_config_dir}/lazygit" "${config_dir}/lazygit"; fi

# Symlinked Files
if [ ! -e "${HOME}/.bash_aliases" ]; then ln -s "${dotfiles_config_dir}/.bash_aliases" "${HOME}/.bash_aliases"; fi
if [ ! -e "${HOME}/.inputrc" ]; then ln -s "${dotfiles_config_dir}/.inputrc" "${HOME}/.inputrc"; fi
if [ ! -e "${config_dir}/starship.toml" ]; then ln -s "${dotfiles_config_dir}/starship.toml" "${config_dir}/starship.toml"; fi
mkdir -p "${config_dir}/nushell"
if [ ! -e "${config_dir}/nushell/config.nu" ]; then ln -s "${dotfiles_config_dir}/nushell/config.nu" "${config_dir}/nushell/config.nu"; fi

# PUDB can't read symlinks, so I need to copy/overwrite instead
mkdir -p "${config_dir}/pudb"
cp "${dotfiles_config_dir}/pudb/pudb.cfg" "${config_dir}/pudb/pudb.cfg"

# WSL Configurations
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
	# Neither can Windows
	cp "${dotfiles_config_dir}/windows_terminal/settings.json" "/mnt/c/Users/${USER}/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
	cp "${dotfiles_config_dir}/windows_terminal/settings.json" "/mnt/c/Users/${USER}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
fi


# Managed Blocks
../scripts/push_managed_config_block.sh .bash_profile "${HOME}/.bash_profile"
../scripts/push_managed_config_block.sh .bashrc "${HOME}/.bashrc"
../scripts/push_managed_config_block.sh .gitconfig "${HOME}/.gitconfig"
