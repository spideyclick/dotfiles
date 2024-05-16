#!/usr/bin/env bash

set -e

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "bak.sh: quickly create & restore single-file backups"
   echo
   echo "Syntax: bak [-r]"
   echo "options:"
   echo "r     Restore a file backup"
   echo "h     Print this Help."
   echo
}

############################################################
# Parse Arguments                                          #
############################################################

while getopts "r" opt; do
    case $opt in
        r) # Restore
           RESTORE=true;;
        \?) # Invalid option
           Help
           exit 1;;
    esac
done

shift $((OPTIND -1))

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

############################################################
# Main Program                                             #
############################################################

backup() {
	local file="$1"
	if [ ! -f "$file" ]; then
		echo "Error: File '$file' not found."
		exit 1
	fi
	local dir;
	dir=$(dirname "$file")
	local filename;
	filename=$(basename -- "$file")
	local extension;
	extension="${filename##*.}"
	local filename;
	filename="${filename%.*}"
	local backup_filename;
	backup_filename="${dir}/backup_$(date +"%Y-%m-%d-%H-%M-%S")_${filename}.${extension}"
	cp "$file" "$backup_filename"
	echo "Backup created: $backup_filename"
}

restore() {
	local backup_file="$1"
	local dir;
	dir=$(dirname "$backup_file")
	local filename;
	filename=$(basename -- "$backup_file")
	if [[ $filename =~ ^backup_[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}_.+$ ]]; then
		local orig_filename;
		orig_filename=$(echo "$filename" | sed 's/^backup_[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}_//')
		cp "$backup_file" "${dir}/${orig_filename}"
		echo "File restored: ${dir}/${orig_filename}"
	else
		echo "Error: Invalid backup file name format."
		exit 1
	fi
}

if [[ "$RESTORE" == "true" ]];
then restore "$1";
else backup "$1";
fi

