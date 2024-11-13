#!/usr/bin/env bash

set -e

[ ! -d ~/downloads/cspell-lsp ] && git clone https://github.com/vlabo/cspell-lsp.git ~/downloads/cspell-lsp
cd ~/downloads/cspell-lsp
git pull
sudo apt-get install -y npm
npm install
npm run build
npm link

