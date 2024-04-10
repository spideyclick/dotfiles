#!/usr/bin/env bash

############################################################
# Directory + Environment Setup                            #
############################################################
# CWD=$(dirname $(realpath "$0"))
# cd ${CWD}

if [ ! -f pyproject.toml ]; then echo "python project now found in $(pwd)"; exit 1; fi
.zide/setup.sh

# cd $(dirname ${CWD})
source .venv/bin/activate
source .env

############################################################
# Network Setup                                            #
############################################################
if [[ $(hostname) != 'Fermi.midwestholding.com' ]]
then
  # SSH Forwarding for database
  if nc -z localhost 27017
  then
    ssh \
      -L 27017:fermi:27017 \
      -L 25829:fermi:25829 \
      fermi \
      ;
  fi
  # HTTP Forwarding (required for Chorus)
  HTTP_PROXY=http://localhost:25829
  export HTTP_PROXY
  HTTPS_PROXY=http://localhost:25829
  export HTTPS_PROXY
  # NO_PROXY=hostname.example.com,127.0.0.1
  # export NO_PROXY
fi

############################################################
# Program Start                                            #
############################################################
./docker-entrypoint.sh

