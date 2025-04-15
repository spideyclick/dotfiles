#!/usr/bin/env bash

set -e

cd $(dirname $0)

function is_newer() {
	(( $(stat --terse "$1" "$2" | choose 11 | paste -d">" - -) ))
}
function safe_copy() {
	if ! is_newer "$1" "$2"; then
		echo "File $1 is not newer than $2"
		echo "Skipping copy"
		return 1;
	fi
	echo "File $1 is newer than $2"
	echo "Copying"
	cp -p "$1" "$2"
}

# safe_copy ../config/windows_terminal/settings.json /mnt/c/Users/ZacharyHubbell/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
# safe_copy ../config/windows_terminal/settings.json /mnt/c/Users/ZacharyHubbell/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json
cp ../config/windows_terminal/settings.json /mnt/c/Users/ZacharyHubbell/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
cp ../config/windows_terminal/settings.json /mnt/c/Users/ZacharyHubbell/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json

