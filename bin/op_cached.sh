#!/usr/bin/env bash

set -e
set -o pipefail

OP_REFERENCE=$1
PASS_PATH="op_cache/${OP_REFERENCE#op://}"
FULL_PASS_PATH="$PASSWORD_STORE_DIR/$PASS_PATH.gpg"

if [[ ! -f "$FULL_PASS_PATH" ]]; then {
	"$HOME/dotfiles/scripts/1pass_session.sh" 1> /dev/null
	OP_SESSION_2LCBJG3RHJGEZOFJAGER6PHSFA="$(<"$HOME/.1password/session")"
	export OP_SESSION_2LCBJG3RHJGEZOFJAGER6PHSFA
	secret=$(op read "$OP_REFERENCE")
	echo "$secret" | pass insert -m "$PASS_PATH" 1> /dev/null
	pass git pull 1> /dev/null
	pass git push &> /dev/null
} fi
pass show "$PASS_PATH"
