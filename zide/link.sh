#!/usr/bin/env bash

set -e

ZWD=$(dirname $(realpath "$0"))

if [ -f 'pyproject.toml' ]; then
  echo 'python project detected'
  mkdir .zide
  cd .zide
  ln -s "${ZWD}/python/setup.sh" .
  ln -s "${ZWD}/python/edit.sh" .
  ln -s "${ZWD}/python/run.sh" .
  ln -s "${ZWD}/python/test.sh" .
  cp "${ZWD}/workspace_template.yaml" ./workspace.yaml
  cd ../
  mkdir .helix
  cd .helix
  ln -s "${ZWD}/python/.helix/languages.toml" .
  cd ../
else
  echo 'project type unknown'
fi


