#!/usr/bin/env bash
set -euo pipefail
[[ $(id -u) == 0 ]] || { echo 'Run inside Ubuntu WSL as root.' >&2; exit 1; }
readonly destination='/opt/kafka-lab/google-java-format-2.0.0-all-deps.jar'
readonly checksum='c78feb48c549fa7114b7ea11db3b456808f7b371ffe84e6643a44dd2f9588639'
if [[ ! -f "$destination" ]]; then
  archive=$(mktemp /tmp/kafka-lab-formatter.XXXXXXXX)
  trap 'rm -f -- "$archive"' EXIT
  curl --fail --silent --show-error --location --retry 2 --max-time 120 \
    https://repo.maven.apache.org/maven2/com/google/googlejavaformat/google-java-format/2.0.0/google-java-format-2.0.0-all-deps.jar -o "$archive"
  printf '%s  %s\n' "$checksum" "$archive" | sha256sum --check --status
  install -d -m 0755 /opt/kafka-lab
  install -m 0644 "$archive" "$destination"
fi
printf '%s  %s\n' "$checksum" "$destination" | sha256sum --check --status
/opt/kafka-lab/jdk-25.0.5.1/bin/java -jar "$destination" --version
