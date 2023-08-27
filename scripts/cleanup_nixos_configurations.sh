#!/usr/bin/env bash

nix-collect-garbage
nix-collect-garbage -d

if [[ $EUID -ne 0 ]]; then
  echo "This script needs root priveleges to clean up GRUB configurations"
  exit 1
fi

nix-env --delete-generations old --profile /nix/var/nix/profiles/system
/nix/var/nix/profiles/system/bin/switch-to-configuration switch
