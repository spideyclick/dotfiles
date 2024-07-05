#!/usr/bin/env bash

set -e

if [ -p /dev/stdin ]; then
	while IFS= read -r line; do
		local_date=$(echo $line | choose 0 | xargs date +"%Y %m %d %a %r" -d | tr ' ' '-')
		rest_of_line=$(echo $line | choose 1:)
		echo "${local_date} ${rest_of_line}"
	done
fi
