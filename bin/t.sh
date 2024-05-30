#!/usr/bin/env bash

if [ -p /dev/stdin ]; then
	xargs -I {} date -d '{}' | tr -d '\n'
	exit 0
fi

date +'%_I:%_M%P' | awk '{$1=$1};1' | tr -d '\n'
