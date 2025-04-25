#!/usr/bin/env bash

git clone --depth=1 https://github.com/adi1090x/rofi.git /tmp/rofi-themes

cd /tmp/rofi-themes
chmod +x ./setup.sh
./setup.sh

