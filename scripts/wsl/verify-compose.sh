#!/usr/bin/env bash
set -euo pipefail
work=$(mktemp -d /tmp/kafka-lab-compose.XXXXXXXX)
trap 'rm -f -- "$work/compose.yaml" "$work/invalid.yaml" "$work/error.log"; rmdir -- "$work"' EXIT
cat > "$work/compose.yaml" <<'YAML'
name: kafka-lab-config-probe
services:
  probe:
    image: example.invalid/compose-probe:config-only
    environment:
      CHECK: ${LAB_REQUIRED:?Set LAB_REQUIRED for this configuration probe}
YAML
docker compose version
for attempt in 1 2; do
  LAB_REQUIRED=synthetic docker compose --env-file /dev/null -f "$work/compose.yaml" config --quiet
done
if env -u LAB_REQUIRED docker compose --env-file /dev/null -f "$work/compose.yaml" config --quiet > "$work/error.log" 2>&1; then
  echo 'Missing required variable unexpectedly accepted.' >&2; exit 1
fi
printf 'unexpected-key: true\n' > "$work/invalid.yaml"
if docker compose --env-file /dev/null -f "$work/invalid.yaml" config --quiet > "$work/error.log" 2>&1; then
  echo 'Invalid Compose schema unexpectedly accepted.' >&2; exit 1
fi
docker compose ls --format json > /dev/null
printf 'PASS: repeated Compose config, required-variable/schema rejection and daemon project-list API; no stack started\n'
