#!/usr/bin/env bash

set -e

if [ ! -f pyproject.toml ]; then echo "python project not found in $(pwd)"; exit 1; fi
if [[ -f .zide/.setup_complete ]]; then exit 0; fi

if ! command -v python &> /dev/null; then
  set +e  # venv errors out when detecting shell type
  python3 -m venv .venv
  set -e
  source .venv/bin/activate
  if [ -f .env ]; then source .env; fi
  if [ -f .zide/.env ]; then source .zide/.env; fi
fi

python -m pip install ruff python-lsp-ruff pudb
if [[ -f requirements.txt ]]; then python -m pip install -r requirements.txt; fi
if [[ -d setup && -f setup/requirements.txt ]]; then python -m pip install -r setup/requirements.txt; fi
if [[ -d .devcontainer && -f .devcontainer/dev-requirements.txt ]]; then python -m pip install -r .devcontainer/dev-requirements.txt; fi

touch .zide/.setup_complete

