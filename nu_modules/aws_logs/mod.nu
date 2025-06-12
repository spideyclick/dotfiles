#!/usr/bin/env nu

# def main [] {
#   let log_groups = (
#     aws logs describe-log-groups |
#     from yaml |
#     get LogGroups
#   )
#   let target_log_group_name = (
#     $log_groups |
#     select logGroupName |
#     values |
#     to text |
#     fzf
#   )
#   let target_log_stream_name = (
#     aws --profile $profile logs describe-log-streams
#     --log-group-name $target_log_group_name
#     --max-items 1
#     --order-by LastEventTime
#     --descending |
#     from yaml |
#     get logStreams |
#     get 0.logStreamName
#   )
#   awslogs get --profile $profile -G -S --timestamp $target_log_group_name $target_log_stream_name
# }


def log_groups [] {
  aws logs describe-log-groups |
  from yaml |
  get LogGroups |
  select logGroupName |
  values | flatten
}

export def main [
  # TODO: Add duration as an optional parameter with default of 1 day
  log_group: string@log_groups
] {
  let log_stream = (
    aws logs describe-log-streams
    --log-group-name $log_group
    --max-items 1
    --order-by LastEventTime
    --descending |
    from yaml |
    get logStreams |
    get 0.logStreamName
  )
  print $"Fetching logs from stream ($log_stream)"
  # --limit 1000
  (
    aws logs filter-log-events
    --log-group-name $log_group
    --log-stream-names $log_stream
    --query "events[].{timestamp: timestamp, message: message}"
    --output json
    --start-time (((date now) - 24hr | into int) // 1_000_000)
  ) | from json | each { |line|
    $line.timestamp
    | into string
    | str substring 0..-4
    | into datetime -f '%s'
    | date to-timezone local
    | format date '%F %H:%M:%S%Z'
    | $"($in) ($line.message)"
  } | to text
}
