#!/usr/bin/env bash

START_DELIMITER="### MANAGED BY DOTFILES SCRIPT (START)"
END_DELIMITER="### MANAGED BY DOTFILES SCRIPT (END)"
# if [ -p /dev/stdin ]; then
# 	MANAGED_CONTENT=$(cat "$1")
MANAGED_CONTENT=$(cat "$1")
if grep -q "$START_DELIMITER" "$2" && grep -q "$END_DELIMITER" "$2"; then
	echo "Found managed section in $2; updating"
	# flag codes: 1=normal, 2=in config section, 3=skipping rest of config section
	awk -v start="$START_DELIMITER" -v end="$END_DELIMITER" -v content="$MANAGED_CONTENT" '
		BEGIN { flag=1 }
		$0 == start { flag=2; print; next }
		$0 == end { flag=1; print; next }
		flag == 1 { print }
		flag == 2 { print content; flag=3 }
		flag == 3 { }
		' "$2" > "$2.tmp" && mv "$2.tmp" "$2"
else
	echo "No managed section found in $2; inserting"
	echo -e "\n$START_DELIMITER\n$MANAGED_CONTENT\n$END_DELIMITER" >> "$2"
fi

