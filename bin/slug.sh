#!/usr/bin/env bash

# Slugify
  # Transliterate everything to ASCII
  # Strip out apostrophes
  # Anything that's not a letter or number to a dash
  # Strip leading & trailing dashes
  # Everything to lowercase
function slugify() {
  iconv -t ascii//TRANSLIT \
  | tr -d "'" \
  | sed -E 's/[^a-zA-Z0-9]+/-/g' \
  | sed -E 's/^-+|-+$//g' \
  | tr "[:upper:]" "[:lower:]"
}

# TODO: This isn't going to stdout for some reason
# echo $1 | slugify | tr -d '\n'
# echo $1 | slugify

