#!/usr/bin/env bash

cd "$(dirname $0)/../config" || exit

mkdir -p ~/.config
user_home_dir=$(getent passwd "$(whoami)" | cut -d: -f6)
config_dir="${user_home_dir}/.config"

ln -s .zshrc "${user_home_dir}/.zshrc"
ln -s starship.toml "${config_dir}/starship.toml"
ln -s helix "${config_dir}/helix"
ln -s joshuto "${config_dir}/joshuto"
ln -s lazygit "${config_dir}/lazygit"
ln -s ranger "${config_dir}/ranger"

