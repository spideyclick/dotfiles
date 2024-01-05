#!/usr/bin/env bash

# You should run this script after having updated your nix channel.
# See https://unix.stackexchange.com/a/491772
# See docs for more info: https://nixos.wiki/wiki/Nix_channels

# Example:
# sudo nix-channel --remove nixos
# sudo nix-channel --add https://nixos.org/channels/nixos-21.11 nixos

sudo nix-channel --update
# sudo nixos-rebuild switch --upgrade
sudo nixos-rebuild switch
# meow also i love you very much

