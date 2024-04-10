#!/usr/bin/env bash

############################################################
# Directory + Environment Setup                            #
############################################################
set -e
if [ ! -f pyproject.toml ]; then echo "python project not found in $(pwd)"; exit 1; fi
.zide/setup.sh
WORKSPACE=.zide/workspace.yaml

source .venv/bin/activate
source .env

############################################################
# Parse Arguments                                          #
############################################################
while getopts "b" opt; do
	 case $opt in
			b) # Basic
				 BASIC=true;;
			\?) # Invalid option
				 Help
				 exit 1;;
	 esac
done
shift $((OPTIND -1))

############################################################
# Select Test to run                                       #
############################################################
if [[ $1 == 'all' ]]; then
	echo "Running all tests"
elif [[ $1 == 'last' ]]; then
	TARGET_TEST=$(cat .zide/.last_test)
	echo "Run test for ${TARGET_TEST}"
else
	echo "Fetching available tests"
	if TESTS=$( pytest --collect-only --color=yes 2>&1 ); then
		echo "test collection succeeded"
		TARGET_TEST=$(echo $TESTS | grep -oP '(?<=<)(Function|Coroutine)\s+\K\w+' | fzf)
		echo "$TARGET_TEST" > .zide/.last_test
		echo "Run test for ${TARGET_TEST}"
	else
		echo "test collection failed"
		# This means the pytest collection failed; echo output & exit
		echo -e "$TESTS"
		exit 1
	fi
fi

############################################################
# SSH Tunnels                                              #
############################################################
if [ -f $WORKSPACE ]; then
	tunnel_hosts=$(yq ".tunnels | .[]" .zide/workspace.yaml)
	while IFS=" " read -r tunnel_host; do
		target_socket=.zide/ssh_tunnels_${tunnel_host}.sock
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
			-S ".zide/ssh_tunnels_${tunnel_host}.sock" \
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
if [[ -v BASIC && -z "$TARGET_TEST" ]]; then
	echo "Running all tests"
	pytest .
elif [[ -z "$TARGET_TEST" ]]; then
	echo "Running all tests with PUDB"
	pytest \
		--pdbcls pudb.debugger:Debugger \
		--pdb \
		;
elif [[ -v BASIC ]]; then
	echo "Running test $TARGET_TEST"
	pytest -k "$TARGET_TEST"
else
	echo "Running test $TARGET_TEST with PUDB"
	pytest \
		--pdbcls pudb.debugger:Debugger \
		-k "$TARGET_TEST" \
		--pdb \
		;
fi
