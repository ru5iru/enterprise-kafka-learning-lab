#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/environment.sh"
cd -- "$script_dir/../.."
if [[ $# == 0 ]]; then
  printf 'Usage: bash scripts/wsl/lab.sh <command> [arguments...]\n' >&2
  exit 64
fi
exec "$@"
