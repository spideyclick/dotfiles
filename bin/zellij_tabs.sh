#!/usr/bin/env bash

# Doesn't seem to fix the direnv lazygit issue
# Zellij just freezes when running "direnv exec . lazygit"
# zellij action new-tab --layout ~/.config/zellij/layouts/zide.kdl

zellij action new-tab \
	--cwd "$(pwd)" \
	--name hx \
	--layout compact \
	;

zellij action new-tab \
	--cwd "$(pwd)" \
	--name sh \
	--layout compact \
	;

zellij action new-tab \
	--cwd "$(pwd)" \
	--name git \
	--layout compact \
	;
