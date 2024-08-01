#!/usr/bin/env bash

[ -p /dev/stdin ] && read -r PIPEIN
match=${PIPEIN#*$1}
echo $(( ${#PIPEIN} - ${#match} - 1 ))
