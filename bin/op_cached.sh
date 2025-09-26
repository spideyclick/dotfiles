#!/usr/bin/env bash

set -o pipefail

OP_REFERENCE=$1
PASS_PATH="op_cache/${OP_REFERENCE#op://}"

pass show $PASS_PATH 2> /dev/null || {
	op read $OP_REFERENCE | pass insert -m $PASS_PATH 1> /dev/null
	pass git push 1> /dev/null
	pass show $PASS_PATH
}
