echo "Running .bashrc (this must be an interactive shell)"

# Always source .bash_profile
# This means that interactive shells get the base plus extras below
if [ -f "$HOME/.bash_profile" ]; then source "$HOME/.bash_profile"; fi

# This saves every command to history file immediately
# However PROMPT_COMMAND can be used for much more!
export PROMPT_COMMAND='history -a'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# GPG TTY for Lazygit
export GPG_TTY=$(tty)

# Init
[[ -f ~/.bash-preexec.sh ]] && source "$HOME/.bash-preexec.sh"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
if [[ -d /home/linuxbrew ]]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi
if command -v starship &> /dev/null; then eval "$(starship init bash)"; fi
if command -v zoxide &> /dev/null; then eval "$(zoxide init bash)"; fi
if command -v aws &> /dev/null; then complete -C "$(which aws_completer)" aws; fi
if command -v broot &> /dev/null; then source /home/zhubbell/.config/broot/launcher/bash/br; fi
if command -v fzf &> /dev/null; then source <(fzf --bash); fi


# SSH Agent
eval `ssh-agent -s`
ssh-add -t 0 ~/.ssh/id_rsa

# Zellij
ZELLIJ_AUTO_ATTACH=true
ZELLIJ_AUTO_EXIT=true
# eval "$(zellij setup --generate-auto-start zsh)"
if \
	command -v 'zellij' &> /dev/null && \
	[[ "$ZELLIJ_AUTO_ATTACH" == "true" ]] && \
	[[ -z $( pgrep zellij ) ]]\
; then
  zellij attach --create main
  if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
    exit 0
  fi
fi

# Etc
# source /home/zhubbell/.config/broot/launcher/bash/br
# if [ -e /home/zhubbell/.nix-profile/etc/profile.d/nix.sh ]; then . /home/zhubbell/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Disabled because it's not working well on my system
# source ~/.local/share/blesh/ble.sh
# eval "$(atuin init bash)"
