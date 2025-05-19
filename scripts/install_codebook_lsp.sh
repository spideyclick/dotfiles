#!/usr/bin/env bash

wget https://github.com/blopker/codebook/releases/latest/download/codebook-lsp-x86_64-unknown-linux-musl.tar.gz
tar -xvf codebook-lsp-x86_64-unknown-linux-musl.tar.gz 
mv codebook-lsp ~/.local/bin/
rm codebook-lsp-x86_64-unknown-linux-musl.tar.gz
