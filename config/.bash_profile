echo "Running .bash_profile"

# Always source .bashrc
source "$HOME/.bashrc"

# exports
export EDITOR=hx

# Zellij
ZELLIJ_AUTO_ATTACH=true
ZELLIJ_AUTO_EXIT=true
# eval "$(zellij setup --generate-auto-start zsh)"
if command -v 'zellij' &> /dev/null && [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
  zellij attach --create main
  if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
    exit 0
  fi
fi

# Etc
# source /home/zhubbell/.config/broot/launcher/bash/br
# if [ -e /home/zhubbell/.nix-profile/etc/profile.d/nix.sh ]; then . /home/zhubbell/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
# eval `ssh-agent -s`
# ssh-add -t 0 ~/.ssh/id_rsa

