#!/usr/bin/env nu

let branches_to_remove = (
	git branch -r --merged
	| lines
	| where $it !~ '\*'
	| str trim
	| where $it !~ '.*main|master|HEAD.*'
)
print $branches_to_remove
input 'Remove these branches? (Ctrl-C to stop)'
$branches_to_remove | each { |it| git branch -d $it }
