#!/usr/bin/env bash

cd "$(dirname $0)/../config" || exit

mkdir -p ~/.config
user_home_dir=$(getent passwd "$(whoami)" | cut -d: -f6)
config_dir="${user_home_dir}/.config"
dotfiles_dir="${user_home_dir}/dotfiles"
dotfiles_config_dir="${dotfiles_dir}/config"

# These are files that can be fully linked
ln -s "${dotfiles_config_dir}/.bash_aliases"  "${user_home_dir}/.bash_aliases"
ln -s "${dotfiles_config_dir}/.inputrc"       "${user_home_dir}/.inputrc"
ln -s "${dotfiles_config_dir}/starship.toml"  "${config_dir}/starship.toml"

# These are directories that can be linked
ln -s "${dotfiles_config_dir}/helix"    "${config_dir}/helix"
ln -s "${dotfiles_config_dir}/joshuto"  "${config_dir}/joshuto"
ln -s "${dotfiles_config_dir}/ranger"   "${config_dir}/ranger"
ln -s "${dotfiles_config_dir}/zellij"   "${config_dir}/zellij"

# Some folders have both config & state; these will link only the config, not the state!
mkdir -p "${dotfiles_config_dir}/lazygit/"
ln -s "${dotfiles_config_dir}/lazygit/config.yml" "${config_dir}/lazygit/config.yml"

# These files can't be replaced entirely, so they just have a managed section
script="$dotfiles_dir/scripts/push_managed_config_block.sh"
$script "${dotfiles_config_dir}/.bash_profile"  "${user_home_dir}/.bash_profile"
$script "${dotfiles_config_dir}/.bashrc"        "${user_home_dir}/.bashrc"
$script "${dotfiles_config_dir}/.gitconfig"     "${user_home_dir}/.gitconfig"
