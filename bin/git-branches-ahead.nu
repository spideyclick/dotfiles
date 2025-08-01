#!/usr/bin/env nu

git fetch --all

let current = (git rev-parse HEAD)

let ahead_branches = (
    git for-each-ref --format='%(refname:short)' refs/remotes/
    | lines
    | each {|b|
        let ahead_count = (
            git rev-list --left-right --count $"($current)..($b)"
            | split row "\t"
            | get 1
            | into int
        )

        if $ahead_count > 0 {
            let last_commit = (git rev-list $"($current)..($b)" -n 1)
            let committer = (git show -s --format='%cn' $last_commit)
            let date = (git show -s --format='%cd' --date=iso $last_commit | split row ' ' | first)
            {
                branch: $b,
                ahead_by: $ahead_count,
                committer: $committer,
                date: $date
            }
        }
    }
    | sort-by date
    | compact
)

$ahead_branches | table

