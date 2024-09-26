#!/usr/bin/env bash

set -e

# Note that this scripts expects you to have configured the following files:
# - ~/.ssh/config
# - ~/.pg_service.conf
# - ~/.pgpass

# Examples:

# List schema + tables in DB
# db uat mrisk 'select * from information_schema.tables' | jq -r '.[] | .table_schema + "." + .table_name' | grep -v 'information_schema' | grep -v 'pg_catalog' | sort | uniq

# Grab some info from tables
# db uat ingest 'select * from agent.onboarding'
# db uat mrisk 'select * from mw.transactions limit 100'

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Help not yet written"
   exit 1
   # echo "bak.sh: quickly create & restore single-file backups"
   # echo
   # echo "Syntax: bak [-r]"
   # echo "options:"
   # echo "r     Restore a file backup"
   # echo "h     Print this Help."
   # echo
}

############################################################
# Parse Arguments                                          #
############################################################
YAML_OUT=false
while getopts "ly" opt; do
    case $opt in
        l) # List
           yq -r ".connections | keys[]" ~/.config/usql/config.yaml | sort
           exit 0;;
        y) # Yaml
           YAML_OUT=true;;
        \?) # Invalid option
           Help
           exit 1;;
    esac
done
shift $((OPTIND -1))
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

ssh_tunnel=$(yq ".connections.$1.tunnel" ~/.config/usql/config.yaml)
if [ "$ssh_tunnel" != 'null' ]; then
   ssh -fNT "$ssh_tunnel"
fi
command="$2"
if [ "$YAML_OUT" == "true" ]; then command="select to_json(r) from ($command)r;"; fi
output=$(usql "$1" -c "$command")
if [ "$YAML_OUT" == "true" ]; then echo "$output" | yq -pj -oy -P; else echo "$output"; fi
