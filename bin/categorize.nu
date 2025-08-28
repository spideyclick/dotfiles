#!/usr/bin/env nu

### WARNING: This script needs to be called like:
# echo "- My Task ABC" | nu --stdin this_script.nu

const TIME_REGEX = '^- (?<time_block>\[[\d:-]+\] )?(?<emoji>[\U0001F300-\U0001FAFF])?\s*(?<category_name>\[[\w-]+\] )?(?<main_content>.*)'

def main [category: string] {
	let input = $in
	let data = $input | parse --regex $TIME_REGEX
	if (($data | length) == 0) { return $input }
	let data = $data | first
	let icon = match $category {
		"m" => "📅",
		"l" => "🥪",
		"t" => "💬",
		"i" => "💬",
		"c" => "💻",
		"d" => "🚀",
		"r" => "🚀",
		"p" => "🔍",
		"j" => "📋",
		"w" => "📖",
		"o" => "🏗️",
		"y" => "🔧",
		"b" => "🌴",
		"h" => "🚨",
	}
	let category_name = match $category {
		"m" => "[MEETING]",
		"l" => "[LUNCH]",
		"t" => "[TALK]",
		"i" => "[IM]",
		"c" => $"($data | get category_name | default '[CODE]')"
		"d" => "[DEPLOY]"
		"r" => "[RELEASE]"
		"p" => "[PR]",
		"j" => "[JIRA]",
		"w" => "[DOC]",
		"o" => "[OPS]",
		"y" => "[TOOLS]",
		"b" => "[BREAK]",
		"h" => "[HOTFIX]",
	}
	return $"- ($data | get time_block | default '')($icon) ($category_name) ($data | get main_content)"
}
