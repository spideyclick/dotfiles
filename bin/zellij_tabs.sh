#!/usr/bin/env bash

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
