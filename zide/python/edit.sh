#!/usr/bin/env bash

if [ ! -f pyproject.toml ]; then echo "python project now found in $(pwd)"; exit 1; fi
.zide/setup.sh

source .venv/bin/activate
source .env

$EDITOR .
