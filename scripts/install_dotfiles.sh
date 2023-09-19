#!/usr/bin/env bash

cd $(dirname $0)

cp -ra ../config/. ~/.config/
cp ~/.config/.tmux.conf ~

