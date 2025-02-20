yes | pkg upgrade

git clone https://github.com/notflawffles/termux-nerd-installer.git ~
cd ~/termux-nerd-installer
make install
termux-nerd-installer install jetbrains-mono-ligatures
termux-nerd-installer set jetbrains-mono-ligatures
cd -

pkg install helix
pkg install ranger
pkg install curl
pkg install rust
pkg install rust-bindgen
pkg install rust-analyzer
pkg install python
pkg install lazygit
pkg install helix-grammars
pkg install zellij
cargo install bacon
python -m pip install --upgrade pip
python -m pip install pdb
