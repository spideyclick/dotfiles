#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon
echo "source ~/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
source ~/.nix-profile/etc/profile.d/nix.sh
nix-channel --update
nix-env -iA nixpkgs.helix
nix-env -iA nixpkgs.lazygit
