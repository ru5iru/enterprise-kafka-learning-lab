#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/environment.sh"
[[ $# -gt 0 ]] || { echo 'Usage: inspect-java.sh file.java [...]' >&2; exit 64; }
files=()
for file in "$@"; do
  [[ -f "$file" && "$file" == *.java ]] || { echo 'Expected an existing Java source file.' >&2; exit 1; }
  files+=("$(realpath -- "$file")")
done
work=$(mktemp -d /tmp/kafka-lab-lint.XXXXXXXX)
cleanup() { case "$work" in /tmp/kafka-lab-lint.*) rm -rf -- "$work" ;; *) return 1 ;; esac; }
trap cleanup EXIT
javac --release 25 -proc:none -Xlint:all -Werror -d "$work" "${files[@]}"
