#############################################################################
# ENV
#############################################################################

#############################################################################
# PATH
#############################################################################
$env.PATH = (
	$env.PATH
	| split row (char esep)
	| append "/home/linuxbrew/.linuxbrew/bin"
	| append $"($env.HOME)/.local/bin"
	| append $"($env.HOME)/isomorphic_copy/bin"
)

#############################################################################
# HISTORY
#############################################################################
$env.config.history = {
	file_format: sqlite
	max_size: 10_000
	isolation: true
}

#############################################################################
# General Config
#############################################################################
$env.config.show_banner = false
$env.config.table.mode = 'compact'
# $env.config.table.mode = 'markdown'
# $env.config.table.mode = 'none'
# $env.config.table.mode = 'heavy'
# $env.config.table.mode = 'thin'
# $env.config.table.mode = 'reinforced'

# Direnv: Only change when CWD changes
# $env.config.hooks.env_change.PWD = [
# 	# Direnv
# 	{ ||
# 		if (which direnv | is-empty) { return }
# 		direnv export json | from json | default {} | load-env
# 		if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
# 			$env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
# 		}
# 	}
# ]

# Direnv: Run on every prompt (may be slow!)
$env.config = {
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }
      direnv export json | from json | default {} | load-env
      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }]
  }
}

#############################################################################
# Completions & Program Initializers
#############################################################################
source ~/.config/nushell/.zoxide.nu
source ~/.config/nushell/pueue_completions.nu

#############################################################################
# Aliases
#############################################################################
alias lg = lazygit
alias c = z
def rd [] { to json | jless }
def cb [] { $in | ~/isomorphic_copy/bin/c }
def p [] { ~/isomorphic_copy/bin/p }
alias x = yazi
alias tf = terraform
def l [] { ls --all }
def dps [] { docker ps -a --format json | jq -r '.Names, .RunningFor, .Status' | paste - - - | column -ts $'\t' | sort }
alias diff = delta
alias scp = scp -O
alias sftp = with-readline sftp
def turl [] { curl -s "http://tinyurl.com/api-create.php?url=$1" }
# alias ptgo="pytest -x --last-failed --tb=line --disable-warnings | rg -U 'FAILURES' -A 1 | tail -n 1 | choose 0 | cb"
alias zj = zellij attach --create main
alias zt = zellij_tabs
def hl [] {
	history
	| where cwd == (pwd)
	| where exit_status == 0
	| get command
	| to text
	| fzf
	| ~/isomorphic_copy/bin/c
}

# Compare two or more lists.
def dift [
	--boolean (-b) # Use boolean values instead of icons
	l1: list
	l2: list
	...rest: list
]: nothing -> table {
	let true_value = if $boolean { true } else { "✅" }
	let false_value = if $boolean { false } else { "❌" }
	[$l1 $l2] ++ $rest
	| each { wrap value }
	| enumerate
	| each {|list|
		$list.item | insert $"L($list.index + 1)" { $true_value }
	} | reduce {|it, acc|
		$acc | join -o $it value
	} | update cells {
		if ($in | is-empty) { $false_value } else { $in }
	}
}

def difd [
	d1: string
	d2: string
]: nothing -> table {
	(
		comm
			(ls --short-names $d1 | get name)
			(ls --short-names $d2 | get name)
	)
}

#############################################################################
# Completer Setup
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
#		 z => $zoxide_completer
#		 c => $zoxide_completer
#		 zi => $zoxide_completer
# }

# # if the current command is an alias, get it's expansion
# let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)
# # overwrite
# let spans = (if $expanded_alias != null	{
#		 # put the first word of the expanded alias first in the span
#		 $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
# } else { $spans })
# let carapace_completer = {|spans: list<string>|
#		 carapace $spans.0 nushell ...$spans
#		 | from json
#		 | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
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
				# git => $fish_completer
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

use ~/dotfiles/nu_modules/main.nu *
source $"($nu.home-path)/.cargo/env.nu"
