# Path Additions
PATH=${PATH:+${PATH}:}~/.local/bin

# HOSTS Additions
export HOSTALIASES=~/.hosts
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Alias definitions
if [ -f ~/.bash_aliases ]; then . "$HOME/.bash_aliases"; fi

# Init
[[ -f ~/.bash-preexec.sh ]] && source "$HOME/.bash-preexec.sh"
if [[ -d /home/linuxbrew ]]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi
if command -v starship &> /dev/null; then eval "$(starship init bash)"; fi
if command -v zoxide &> /dev/null; then eval "$(zoxide init bash)"; fi
if command -v aws &> /dev/null; then complete -C "$(which aws_completer)" aws; fi
if command -v broot &> /dev/null; then source /home/zhubbell/.config/broot/launcher/bash/br; fi
if command -v fzf &> /dev/null; then source <(fzf --bash); fi
if command -v cargo &> /dev/null; then . "$HOME/.cargo/env"; fi

# Disabled because it's not working well on my system
# source ~/.local/share/blesh/ble.sh
# eval "$(atuin init bash)"
