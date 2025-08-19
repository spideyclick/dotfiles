#!/usr/bin/env nu

### WARNING: This script needs to be called like:
# echo "- My Task ABC" | nu --stdin this_script.nu

const TIME_REGEX = '^- (?<time_block>\[(?<start_time>\d{1,2}(:\d{1,2})?)(-\d{1,2}(:\d{1,2})?)?\])?(?<line_content>.*)'

def main [] {
	let input = $in
	let match = $input | parse --regex $TIME_REGEX
	if (($match | length) == 0) { return $input }
	let match = $match | first
	let now = (date now)
	mut current_hour = ($now | format date '%H' | into int)
	if ($current_hour > 12) {$current_hour -= 12}
	mut current_minute = (($now | format date '%M' | into int) / 15 | math round) * 15
	if ($current_minute == 60) {
		$current_hour += 1
		$current_minute -= 60
	}
	mut current_time = $"($current_hour)"
	if ($current_minute != 0) { $current_time += $":($current_minute)" }
	$current_time
	if ($match | get -o time_block) == null {
		return $"- [($current_time)] ($match | get line_content)"
	}
	return $"- [($match | get start_time)-($current_time)]($match | get line_content)"
}
