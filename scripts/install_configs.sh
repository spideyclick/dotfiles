#!/usr/bin/env bash

cd "$(dirname $0)/../config" || exit

mkdir -p ~/.config
user_home_dir=$(getent passwd "$(whoami)" | cut -d: -f6)
config_dir="${user_home_dir}/.config"
dotfiles_config_dir="${user_home_dir}/dotfiles/config"

ln -s "${dotfiles_config_dir}/.bash_aliases" "${user_home_dir}/.bash_aliases"
ln -s "${dotfiles_config_dir}/starship.toml" "${config_dir}/starship.toml"
ln -s "${dotfiles_config_dir}/helix" "${config_dir}/helix"
ln -s "${dotfiles_config_dir}/joshuto" "${config_dir}/joshuto"
ln -s "${dotfiles_config_dir}/lazygit" "${config_dir}/lazygit"
ln -s "${dotfiles_config_dir}/ranger" "${config_dir}/ranger"

../scripts/push_managed_config_block.sh .bash_profile "${user_home_dir}/.bash_profile"
../scripts/push_managed_config_block.sh .bashrc "${user_home_dir}/.bashrc"
