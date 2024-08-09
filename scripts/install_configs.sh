#!/usr/bin/env bash

cd "$(dirname $0)/../config" || exit

user_home_dir=$(getent passwd "$(whoami)" | cut -d: -f6)
config_dir="${user_home_dir}/.config"
dotfiles_config_dir="${user_home_dir}/dotfiles/config"

mkdir -p "$config_dir"

# Symlinked Directories
ln -s "${dotfiles_config_dir}/bat" "${config_dir}/bat"
ln -s "${dotfiles_config_dir}/helix" "${config_dir}/helix"
ln -s "${dotfiles_config_dir}/joshuto" "${config_dir}/joshuto"
ln -s "${dotfiles_config_dir}/pet" "${config_dir}/pet"
ln -s "${dotfiles_config_dir}/ranger" "${config_dir}/ranger"
ln -s "${dotfiles_config_dir}/zellij" "${config_dir}/zellij"

# Symlinked Files
ln -s "${dotfiles_config_dir}/.bash_aliases" "${user_home_dir}/.bash_aliases"
ln -s "${dotfiles_config_dir}/.inputrc" "${user_home_dir}/.inputrc"
ln -s "${dotfiles_config_dir}/lazygit/config.yml" "${config_dir}/lazygit/config.yml"
ln -s "${dotfiles_config_dir}/starship.toml" "${config_dir}/starship.toml"

# PUDB can't read symlinks, so I need to copy/overwrite instead
mkdir -p ~/.config/pudb
cp "${dotfiles_config_dir}/pudb/custom.theme" "${config_dir}/pudb/custom.theme"
cp "${dotfiles_config_dir}/pudb/pudb.cfg" "${config_dir}/pudb/pudb.cfg"

# Managed Blocks
../scripts/push_managed_config_block.sh .bash_profile "${user_home_dir}/.bash_profile"
../scripts/push_managed_config_block.sh .bashrc "${user_home_dir}/.bashrc"
