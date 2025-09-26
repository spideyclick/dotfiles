#!/usr/bin/env nu

let target = (
	psql -t -A -c "
		SELECT table_schema || '.' || table_name
		FROM information_schema.tables
		WHERE table_type='BASE TABLE'
		ORDER BY 1;
	"
	| fzf --prompt="Select table whose ID needs fixing"
	| str trim
)
let target_schema = $target | split row '.' | get 0
let target_table = $target | split row '.' | get 1

let id_column = (
	psql -t -P tuples_only=off -A --csv
	-c $'\d ($target)'
	| from csv
	| where Default like 'identity'
	| first
	| get Column
)

let query = "
SELECT pg_get_serial_sequence(
	quote_ident(:'schema') || '.' || quote_ident(:'tbl'), :'col'
);"
let target_sequence = (
	$query
	| psql -t -P tuples_only=off -A --csv
		-v $"schema=($target_schema)"
		-v $"tbl=($target_table)"
		-v $"col=($id_column)"
	| from csv
	| get pg_get_serial_sequence.0
	| str trim
)
let target_sequence_schema = $target_sequence | split row '.' | get 0
let target_sequence_table = $target_sequence | split row '.' | get 1

let current_id = (
	$"SELECT * FROM ($target_sequence);"
	| psql -t -P tuples_only=off -A --csv
	| from csv
	| get last_value.0
)

let new_id = (
	$"SELECT MAX\(($id_column)\) FROM ($target);"
	| psql -t -P tuples_only=off -A --csv
	| from csv
	| get max.0
) + 1

let confirmation = input $"Set sequence for table ($target) from ($current_id) to ($new_id)? [y/N] "
if ($confirmation | str downcase) != 'y' { print 'Cancelling'; exit 0 }

let query = "
SELECT setval(
	quote_ident(:'schema') || '.' || quote_ident(:'tbl'), :'id_num'
);"
let result = (
	$query
	| psql -t -P tuples_only=off -A --csv
		-v $"schema=($target_sequence_schema)"
		-v $"tbl=($target_sequence_table)"
		-v $"id_num=($new_id)"
	| from csv
)

print $result
