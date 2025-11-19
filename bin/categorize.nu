#!/usr/bin/env nu

### WARNING: This script needs to be called like:
# echo "- My Task ABC" | nu --stdin this_script.nu

const TIME_REGEX = '^- (?<time_block>\[[\d:-]+\] )?(?<emoji>[\U0001F300-\U0001FAFF])?\s*(?<category_name>\[[\w\s-]+\] )?(?<main_content>.*)'

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
		"s" => "🚨",
		"p" => "🔍",
		"j" => "📋",
		"w" => "📖",
		"o" => "🏗️",
		"y" => "🔧",
		"b" => "🌴",
		"h" => "🚨",
		"f" => "🏁",
	}
	let category_name = match $category {
		"m" => "[MEETING]",
		"l" => "[LUNCH  ]",
		"t" => "[TALK   ]",
		"i" => "[IM     ]",
		"c" => "[CODE   ]"
		"d" => "[DEPLOY ]"
		"r" => "[RELEASE]"
		"s" => "[SUPPORT]"
		"p" => "[PR     ]",
		"j" => "[JIRA   ]",
		"w" => "[DOC    ]",
		"o" => "[OPS    ]",
		"y" => "[TOOLS  ]",
		"b" => "[BREAK  ]",
		"h" => "[HOTFIX ]",
		"f" => "[FINISH ]",
	}
	return $"- ($data | get time_block | default '')($icon) ($category_name) ($data | get main_content)"
}
