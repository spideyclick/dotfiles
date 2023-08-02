#!/usr/bin/env bash

cd $(dirname $0)

cp ../nixos/configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch
