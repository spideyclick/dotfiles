#!/usr/bin/env bash

diff <( shasum -a 256 "$1" | choose 0 ) <( cat "$2" | choose 0 )
