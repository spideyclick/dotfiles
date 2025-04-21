#!/usr/bin/env bash

set -e

rm -rf ~/tmp/
mkdir -p ~/tmp/op/
cd ~/tmp

echo "Downloading 1Password"
curl -SO https://downloads.1password.com/linux/tar/stable/x86_64/1password-latest.tar.gz
tar -xf 1password-latest.tar.gz
mkdir -p ~/opt/1Password
mv 1password-*/* ~/opt/1Password
ln -sf ~/opt/1Password/1password ~/.local/bin/1password
rm -rf ./1password-*

echo "Downloading 1Password CLI"
# choose between 386/amd64/arm/arm64
ARCH="amd64" && \
wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.3/op_linux_${ARCH}_v2.30.3.zip" -O op.zip && \
unzip -d op op.zip && \
sudo mv op/op /usr/local/bin/ && \
rm -rf op.zip op && \
sudo groupadd -f onepassword-cli && \
sudo chgrp onepassword-cli /usr/local/bin/op && \
sudo chmod g+s /usr/local/bin/op
