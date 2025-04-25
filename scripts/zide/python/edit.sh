#!/usr/bin/env bash

if [ ! -f pyproject.toml ]; then echo "python project not found in $(pwd)"; exit 1; fi
.zide/setup.sh

if [ -d .venv ]; then source .venv/bin/activate; fi
if [ -f .env ]; then source .env; fi

$EDITOR .
