#!/usr/bin/env nu

let main_branch = (
    git symbolic-ref refs/remotes/origin/HEAD
    | str replace 'refs/remotes/origin/' ''
    | str trim
)

let cutoff = ((date now) - 90day)

git branch -r --no-merged $"origin/($main_branch)"
| lines
| filter {|line| not ($line | str contains "origin/HEAD") }
| each {|line|
    let branch = ($line | str trim)
    let raw_info = (git log -1 --format="%ci|||%cn" $branch | str trim)
    let split_info = ($raw_info | split row "|||")
    let commit_date = ($split_info.0 | into datetime --format "%Y-%m-%d %H:%M:%S %z")
    if $commit_date > $cutoff {
        {
          branch: ($branch | str substring 0..40),
          last_commit: ($split_info.0 | date humanize),
          comitter: $split_info.1,
        }
    } else {
        null
    }
}
| compact
| sort-by last_commit
