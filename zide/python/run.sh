#!/usr/bin/env bash

set -e

############################################################
# Directory + Environment Setup                            #
############################################################
if [ ! -f pyproject.toml ]; then echo "python project not found in $(pwd)"; exit 1; fi
.zide/setup.sh
WORKSPACE=.zide/workspace.yaml
PROJECT_NAME=$(basename "$(pwd)")

if [ -f .venv ]; then
	source .venv/bin/activate
fi

source .env

############################################################
# SSH Tunnels                                              #
############################################################
if [ -f $WORKSPACE ]; then
	tunnel_hosts=$(yq ".tunnels | .[]" .zide/workspace.yaml)
	while IFS=" " read -r tunnel_host; do
		if [ -z "${tunnel_host}" ]; then continue; fi
		target_socket=/dev/shm/ssh_tunnel_${PROJECT_NAME}_${tunnel_host}.sock
		if [ -S "$target_socket" ]; then
			echo "Detected socket $target_socket; Closing existing SSH session to $tunnel_host"
			ssh -n -S "$target_socket" -O exit "$tunnel_host"
		fi
		# -f means go to the background before program execution
		# -N means don't execute a command; used for port forwarding
		# -Y Don't allocate a TTY
		# -M Master mode
		echo "Setting up SSH tunnels to Host: ${tunnel_host}"
		ssh -fNnTM \
			-o ExitOnForwardFailure=yes \
			-S "${target_socket}" \
			-F ".zide/ssh_client.conf" \
			"${tunnel_host}"
	done <<< "$tunnel_hosts"
fi

############################################################
# Environment                                              #
############################################################
if [ -f .zide/.env ]; then
	source .zide/.env
fi

############################################################
# Program Start                                            #
############################################################
if [ -f ./docker-entrypoint.sh ]; then
	./docker-entrypoint.sh
else
	python -m main
fi

