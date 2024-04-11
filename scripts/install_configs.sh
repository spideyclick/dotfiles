#!/usr/bin/env bash

cd "$(dirname $0)/../config" || exit

mkdir -p ~/.config
user_home_dir=$(getent passwd "$(whoami)" | cut -d: -f6)
config_dir="${user_home_dir}/.config"
dotfiles_config_dir="${user_home_dir}/dotfiles/config"

# TODO: Need to configure more fine-tuned handling of bash profile, aliases, etc.
# This shouldn't be a problem for now, since it won't overwrite the existing profile
# Don't add -f to this section!
ln -s "${dotfiles_config_dir}/.bash_profile" "${user_home_dir}/.bash_profile"
ln -s "${dotfiles_config_dir}/.zshrc" "${user_home_dir}/.zshrc"

# These are more normal configs that can be symlinked fearlessly
ln -s "${dotfiles_config_dir}/starship.toml" "${config_dir}/starship.toml"
ln -s "${dotfiles_config_dir}/helix" "${config_dir}/helix"
ln -s "${dotfiles_config_dir}/joshuto" "${config_dir}/joshuto"
ln -s "${dotfiles_config_dir}/lazygit" "${config_dir}/lazygit"
ln -s "${dotfiles_config_dir}/ranger" "${config_dir}/ranger"

