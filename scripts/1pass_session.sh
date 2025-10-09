#!/usr/bin/env bash

set -e

SESSION_FILE="$HOME/.1password/session"
SESSION_TTL_MINUTES=30
SESSION_AGE=$(( $(date +%s) - $(stat -c "%Y" ~/.1password/session 2>/dev/null || echo 0) ))
SESSION_EXPIRES_IN=$(( $SESSION_AGE - $(($SESSION_TTL_MINUTES * 60)) ))
SESSION_EXPIRES_IN_MINUTES=$(( $SESSION_EXPIRES_IN / -60 ))

if [ ! -f "$SESSION_FILE" ] || [ $SESSION_EXPIRES_IN -gt 0 ]; then
  mkdir -p "$(dirname "$SESSION_FILE")"
  if command -v pass &>/dev/null
  then
    echo "🔐 Refreshing 1Password session using pass..."
    pass op | op signin --raw > "$SESSION_FILE"
  else
    echo "🔐 Refreshing 1Password session..."
    op signin --raw > "$SESSION_FILE"
  fi
  chmod 600 "$SESSION_FILE"
else
  echo "🔓 1Password session still valid for $SESSION_EXPIRES_IN_MINUTES minutes"
fi

