alias l='lsd -lAgF --tree --depth 2 --permission rwx --date +%Y-%m-%d --group-dirs last --truncate-owner-after 3 --color always'
alias lg='lazygit'
alias x='yazi'
alias c='z'
alias cb='~/isomorphic_copy/bin/c'
alias p='~/isomorphic_copy/bin/p'
alias td='todo.sh'
alias dps="docker ps -a --format json | jq -r '.Names, .RunningFor, .Status' | paste - - - | column -ts $'\t' | sort"
# alias ai='clear;tgpt --provider duckduckgo -m'
alias ai='aichat'
alias lm='aichat'
alias llm='aichat'
alias web='sr google'
alias diff='delta'
alias scp='scp -O'
alias sftp="with-readline sftp"
# alias web='sr google -browser=w3m'
function turl() {
	curl -s "http://tinyurl.com/api-create.php?url=$1"
}
alias ptgo="pytest -x --last-failed --tb=line --disable-warnings | rg -U 'FAILURES' -A 1 | tail -n 1 | choose 0 | cb"
