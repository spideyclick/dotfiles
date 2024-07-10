#!/usr/bin/env bash

set -e

ZWD=$(dirname $(realpath "$0"))

if [ -f 'pyproject.toml' ]; then
  echo 'python project detected'

	if command -v brew &> /dev/null; then
  	echo "Installing HomeBrew Packages"
  	brew bundle --file "${ZWD}/python/Brewfile"
	fi

  python -m pip install pudb basedpyright

  mkdir -p .zide
  cd .zide
  ln -sf "${ZWD}/python/setup.sh" .
  ln -sf "${ZWD}/python/edit.sh" .
  ln -sf "${ZWD}/python/run.sh" .
  ln -sf "${ZWD}/python/test.sh" .
  if [ ! -f ./workspace.yaml ]; then
    cp "${ZWD}/workspace_template.yaml" ./workspace.yaml
  fi
  if [ ! -f ./.env ]; then
    cp "${ZWD}/template.env" ./.env
  fi
  cd ../
  mkdir -p .helix
  cd .helix
  ln -sf "${ZWD}/python/.helix/languages.toml" .
  cd ../
else
  echo 'project type unknown'
fi


