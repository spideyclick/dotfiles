#!/usr/bin/env bash

set -e

if [ ! -f pyproject.toml ]; then echo "python project not found in $(pwd)"; exit 1; fi
if [[ -f .zide/.setup_complete ]]; then exit 0; fi

if [ -f .env ]; then source .env; fi
if [ -f .zide/.env ]; then source .zide/.env; fi

### VENV SETUP
if [ -z $PYTHONPATH ]; then echo 'Please set $PYTHONPATH variable in .env'; exit 1; fi
if [ ! -d .venv ]; then
  set +e  # venv errors out when detecting shell type
  $PYTHONPATH -m venv .venv
  set -e
  source .venv/bin/activate
fi

### LANGUAGE SERVERS/DEBUGGER
python -m pip install basedpyright ruff python-lsp-ruff pudb
if ! command -v cspell-lsp &> /dev/null; then
  brew install npm
  git clone https://github.com/vlabo/cspell-lsp.git ~/cspell-lsp
  cd ~/cspell-lsp
  set +e # NPM Weirdness
  npm install
  npm run build
  set -e
  npm link
  cd -
fi

### PROJECT-SPECIFIC REQUIREMENTS
fd -t f -H '.*requirements\.txt' | xargs -I {} python -m pip install -r {}

### MARK SETUP COMPLETE
touch .zide/.setup_complete

