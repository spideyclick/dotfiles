#!/usr/bin/env nu

def main [
  --profile (-p): string = "default"
] {
  let log_groups = (
    aws --profile $profile logs describe-log-groups |
    from yaml |
    get LogGroups
  )
  let target_log_group_name = (
    $log_groups |
    select logGroupName |
    values |
    to text |
    fzf
  )
  let target_log_stream_name = (
    aws --profile $profile logs describe-log-streams
    --log-group-name $target_log_group_name
    --max-items 1
    --order-by LastEventTime
    --descending |
    from yaml |
    get logStreams |
    get 0.logStreamName
  )
  awslogs get --profile $profile -G -S --timestamp $target_log_group_name $target_log_stream_name
}
