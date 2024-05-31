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
   echo "bak.sh: quickly create & restore single-file backups"
   echo
   echo "Syntax: bak [-r]"
   echo "options:"
   echo "r     Restore a file backup"
   echo "h     Print this Help."
   echo
}

############################################################
# Parse Arguments                                          #
############################################################
# while getopts "r" opt; do
#     case $opt in
#         r) # Restore
#            RESTORE=true;;
#         \?) # Invalid option
#            Help
#            exit 1;;
#     esac
# done
# shift $((OPTIND -1))
# if [ "$#" -ne 1 ]; then
#     echo "Usage: $0 <file_path>"
#     exit 1
# fi

autossh -f $1; psql "service=$1 dbname=$2" -tA -c "select to_json(r) from ($3)r;" | jq -s .
