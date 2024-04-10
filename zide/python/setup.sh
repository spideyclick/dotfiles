#!/usr/bin/env bash

# CWD=$(dirname $(realpath "$0"))
# cd $CWD

if [ ! -f pyproject.toml ]; then echo "python project not found in $(pwd)"; exit 1; fi
if [[ -f .zide/.setup_complete ]]; then exit 0; fi

if ! command -v python &> /dev/null; then
  python3 -m venv .venv
  source .venv/bin/activate
  source .env
fi

python -m pip install ruff python-lsp-ruff pudb
python -m pip install -r setup/requirements.txt
python -m pip install -r .devcontainer/dev-requirements.txt

touch .zide/.setup_complete
