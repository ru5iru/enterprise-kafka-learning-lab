#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/environment.sh"
[[ $# -ge 2 ]] || { echo 'Usage: format-java.sh --check|--write file.java [...]' >&2; exit 64; }
mode=$1
shift
case "$mode" in
  --check) options=(--dry-run --set-exit-if-changed) ;;
  --write) options=(--replace) ;;
  *) echo 'Unknown formatter mode.' >&2; exit 64 ;;
esac
files=()
for file in "$@"; do
  [[ -f "$file" && "$file" == *.java ]] || { echo 'Expected an existing Java source file.' >&2; exit 1; }
  files+=("$(realpath -- "$file")")
done
exec java -jar /opt/kafka-lab/google-java-format-2.0.0-all-deps.jar --aosp "${options[@]}" "${files[@]}"
