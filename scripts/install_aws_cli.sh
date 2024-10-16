#!/usr/bin/env bash

set -e

mkdir -p ~/downloads
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o ~/downloads/awscliv2.zip
unzip ~/downloads/awscliv2.zip -d ~/downloads
~/downloads/aws/install --bin-dir ~/.local/bin --install-dir ~/.local/aws-cli --update
rm ~/downloads/awscliv2.zip
rm -rf ~/downloads/aws
