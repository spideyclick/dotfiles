#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    exit 1
fi

dir=$(dirname "$1")
filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"
backup_filename="${dir}/backup_$(date +"%Y-%m-%d-%H-%M-%S")_${filename}.${extension}"

cp "$1" "$backup_filename"

echo "Backup created: $backup_filename"
