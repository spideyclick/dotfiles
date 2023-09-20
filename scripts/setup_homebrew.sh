#/usr/bin/env bash

cd "$(dirname $0)"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install \
  lazygit \
  helix \
  black \
  pyright \
  tmux \
  zsh \
  zsh-autosuggestions \
  ;

### Additional ZSH Setup

which zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Deploy Dotfiles
./install_dotfiles.sh
