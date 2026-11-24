#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C
unset PGPASSWORD
export PGPASSFILE=/dev/null PGSERVICEFILE=/dev/null PGCONNECT_TIMEOUT=1
work=$(mktemp -d /tmp/kafka-lab-psql.XXXXXXXX)
trap 'rm -f -- "$work/help.log" "$work/error.log"; rmdir -- "$work"' EXIT
[[ -z $(ss -H -ltn '( sport = :1 )') ]] || { echo 'Loopback test port is in use; aborting probe.' >&2; exit 1; }
psql --version
for attempt in 1 2; do psql --help > "$work/help.log"; done
set +e
psql -X -w -h 127.0.0.1 -p 1 -U lab_probe -d lab_probe -c 'SELECT 1' > "$work/error.log" 2>&1
status=$?
set -e
[[ "$status" == 2 ]]
[[ $(cat "$work/error.log") == *'Connection refused'* ]]
printf 'PASS: PostgreSQL client version/help twice; bounded loopback connection rejection exit 2; no server installed by this probe\n'
