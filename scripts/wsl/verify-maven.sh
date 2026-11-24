#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/environment.sh"
work=$(mktemp -d /tmp/kafka-lab-mvn.XXXXXXXX)
cleanup() {
  case "$work" in /tmp/kafka-lab-mvn.*) rm -rf -- "$work" ;; *) return 1 ;; esac
}
trap cleanup EXIT
cat > "$work/pom.xml" <<'XML'
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <groupId>lab.toolchain</groupId><artifactId>probe</artifactId><version>1</version>
  <packaging>pom</packaging>
</project>
XML
args=(-B -ntp -C "-Dmaven.repo.local=$work/repository" -f "$work/pom.xml")
if ! mvn "${args[@]}" org.apache.maven.plugins:maven-help-plugin:3.6.0:effective-pom "-Doutput=$work/effective.xml" > "$work/online.log" 2>&1; then
  tail -n 25 "$work/online.log" >&2
  exit 1
fi
[[ -s "$work/effective.xml" ]]
mvn -o "${args[@]}" org.apache.maven.plugins:maven-help-plugin:3.6.0:effective-pom "-Doutput=$work/cached.xml" > "$work/offline.log" 2>&1
[[ -s "$work/cached.xml" ]]
printf '<project>' > "$work/invalid.xml"
if mvn -o -B -ntp -f "$work/invalid.xml" validate > "$work/invalid.log" 2>&1; then
  echo 'Malformed POM unexpectedly passed.' >&2; exit 1
fi
if mvn -o "${args[@]}" invalid-lifecycle-phase > "$work/phase.log" 2>&1; then
  echo 'Unknown lifecycle phase unexpectedly passed.' >&2; exit 1
fi
printf 'PASS: Maven cold-cache strict-checksum resolution, offline repeat, malformed POM and unknown phase rejection\n'
