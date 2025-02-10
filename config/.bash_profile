# ~/.bash_profile: executed by the command interpreter for login shells.

# Because of this file's existence, neither ~/.bash_login nor ~/.profile
# will be sourced.

# See /usr/share/doc/bash/examples/startup-files for examples.
# The files are located in the bash-doc package.

echo "Running .bash_profile"

export EDITOR=hx

# Path Additions
PATH=${PATH:+${PATH}:}~/.local/bin

# HOSTS Additions
export HOSTALIASES=~/.hosts

# HISTORY Configurations
# ignoreboth refers to ignoring duplicates & commands prefixed with a space
export HISTCONTROL=ignoreboth
export HISTIGNORE="clear:history:[bf]g:exit:date"
export HISTSIZE=2000
export HISTFILESIZE=16000

# Set umask
# 0 = all, 2 = RO, 7 = none
umask 027

# Alias definitions
if [ -f ~/.bash_aliases ]; then source "$HOME/.bash_aliases"; fi

