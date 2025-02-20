#############################################################################
# Config
#############################################################################
$env.config.show_banner = false
$env.config.table.mode = 'compact'
# $env.config.table.mode = 'markdown'
# $env.config.table.mode = 'none'
# $env.config.table.mode = 'heavy'
# $env.config.table.mode = 'thin'
# $env.config.table.mode = 'reinforced'
$env.config.hooks.env_change.PWD = [
	# Direnv
	{ ||
		if (which direnv | is-empty) { return }
		direnv export json | from json | default {} | load-env
		if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
			$env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
		}
	}
]

#############################################################################
# Completions
#############################################################################
let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}
let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | from tsv --flexible --noheaders --no-infer
    | rename value description
}
let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# {
#     z => $zoxide_completer
#     c => $zoxide_completer
#     zi => $zoxide_completer
# }

# # if the current command is an alias, get it's expansion
# let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)
# # overwrite
# let spans = (if $expanded_alias != null  {
#     # put the first word of the expanded alias first in the span
#     $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
# } else { $spans })
# let carapace_completer = {|spans: list<string>|
#     carapace $spans.0 nushell ...$spans
#     | from json
#     | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
# }

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion
    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }
    match $spans.0 {
        # carapace completions are incorrect for nu
        nu => $fish_completer
        # fish completes commits and branch names in a nicer way
        git => $fish_completer
        # carapace doesn't have completions for asdf
        asdf => $fish_completer
        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config.completions = {
	external: {
		enable: true
		completer: $external_completer
	}
}

#############################################################################
# Aliases
#############################################################################
alias lg = lazygit

