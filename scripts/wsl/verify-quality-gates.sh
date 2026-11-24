#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/environment.sh"
cd -- "$script_dir/../.."
fixture='tools/build-verification/src/main/java/io/github/ru5iru/kafkalab/buildverification/InspectionFailureProbe.java'
[[ ! -e "$fixture" ]] || { echo 'Probe fixture already exists; refusing to overwrite.' >&2; exit 1; }
work=$(mktemp -d /tmp/kafka-lab-quality.XXXXXXXX)
created=false
cleanup() {
  if [[ "$created" == true ]]; then rm -f -- "$fixture"; fi
  rm -f -- "$work/layout.log" "$work/style.log" "$work/positive.log"
  rmdir -- "$work"
}
trap cleanup EXIT
printf 'package io.github.ru5iru.kafkalab.buildverification; final class InspectionFailureProbe{void run(){try{System.getProperty("synthetic");}catch(Exception failure){throw failure;}}}\n' > "$fixture"
created=true
if mvn -f tools/build-verification/pom.xml spotless:check > "$work/layout.log" 2>&1; then echo 'Formatting drift was not rejected.' >&2; exit 1; fi
python3 -c 'import sys; assert "format violations" in open(sys.argv[1]).read()' "$work/layout.log"
bash scripts/wsl/format-java.sh --write "$fixture"
if mvn -f tools/build-verification/pom.xml checkstyle:check > "$work/style.log" 2>&1; then echo 'Broad catch was not rejected.' >&2; exit 1; fi
python3 -c 'import sys; assert "IllegalCatch" in open(sys.argv[1]).read()' "$work/style.log"
rm -f -- "$fixture"
created=false
bash scripts/wsl/format-java.sh --check \
  tools/build-verification/src/main/java/io/github/ru5iru/kafkalab/buildverification/ToolchainProbe.java \
  tools/build-verification/src/test/java/io/github/ru5iru/kafkalab/buildverification/ToolchainProbeTest.java \
  tools/build-verification/src/test/java/io/github/ru5iru/kafkalab/buildverification/ToolchainProbeIT.java
mvn clean verify > "$work/positive.log" 2>&1 || { tail -n 25 "$work/positive.log" >&2; exit 1; }
if python3 -c 'import sys; s=open(sys.argv[1]).read(); sys.exit(0 if "Could not transfer metadata" in s else 1)' "$work/positive.log"; then
  echo 'Unexpected repository metadata failure remains.' >&2; exit 1
fi
printf 'PASS: formatting drift and IllegalCatch rejected; CLI/build AOSP agree; restored full verify and repository mirror checks\n'
