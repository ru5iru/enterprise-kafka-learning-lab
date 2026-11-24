#!/usr/bin/env bash
set -euo pipefail
unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
git -C "$script_dir/../.." rev-parse --is-inside-work-tree > /dev/null
work=$(mktemp -d /tmp/kafka-lab-git.XXXXXXXX)
cleanup() { case "$work" in /tmp/kafka-lab-git.*) rm -rf -- "$work" ;; *) return 1 ;; esac; }
trap cleanup EXIT
git --version
git -c init.templateDir= init --quiet --initial-branch=main "$work"
printf 'synthetic probe\n' > "$work/probe.txt"
git -C "$work" add -- probe.txt
git -C "$work" -c core.hooksPath=/dev/null -c user.name=LabProbe -c user.email=lab@example.invalid -c commit.gpgsign=false commit --quiet -m 'test(probe): verify Linux Git' -m 'Refs: P1-021'
[[ -z $(git -C "$work" status --porcelain) ]]
printf 'changed synthetic probe\n' > "$work/probe.txt"
if git -C "$work" diff --quiet; then echo 'Git missed a modified file.' >&2; exit 1; fi
if git check-ref-format --branch 'bad..branch' > /dev/null 2>&1; then echo 'Invalid ref unexpectedly accepted.' >&2; exit 1; fi
printf 'PASS: existing Linux Git, mounted-checkout read, isolated init/stage/commit, dirty-diff detection and invalid-ref rejection\n'
