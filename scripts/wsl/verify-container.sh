#!/usr/bin/env bash
set -euo pipefail
readonly image='hello-world@sha256:5e22040d441e5fb3aed38368acbe8486b575d7018df38dbdfbc7311fbb2ef3a9'
work=$(mktemp -d /tmp/kafka-lab-container.XXXXXXXX)
cleanup() {
  for file in "$work"/*.cid; do
    if [[ -f "$file" ]]; then
      id=$(cat -- "$file")
      if docker container inspect "$id" > /dev/null 2>&1; then docker container rm --force "$id" > /dev/null; fi
    fi
  done
  rm -f -- "$work"/*.cid "$work"/*.log
  rmdir -- "$work"
}
trap cleanup EXIT
docker image inspect "$image" > /dev/null
limits=(--pull never --rm --network none --read-only --cap-drop ALL --security-opt no-new-privileges --user 65534:65534 --memory 32m --cpus 0.5 --pids-limit 32)
for attempt in 1 2; do
  docker run "${limits[@]}" --cidfile "$work/success-$attempt.cid" "$image" > "$work/success-$attempt.log" 2>&1
  [[ $(cat "$work/success-$attempt.log") == *'Hello from Docker!'* ]]
done
if docker run "${limits[@]}" --cidfile "$work/failure.cid" --entrypoint /not-present "$image" > "$work/failure.log" 2>&1; then
  echo 'Missing executable unexpectedly ran.' >&2; exit 1
fi
set +e
docker run --pull never --rm example.invalid/lab/absent:config-only > "$work/missing.log" 2>&1
status=$?
set -e
[[ "$status" == 125 ]]
[[ $(cat "$work/missing.log") == *'No such image'* ]]
for file in "$work"/*.cid; do
  id=$(cat "$file")
  if docker container inspect "$id" > /dev/null 2>&1; then echo 'Probe container was not removed.' >&2; exit 1; fi
done
printf 'PASS: two digest-pinned restricted container runs, invalid-entrypoint/missing-image rejection and automatic container cleanup\n'
