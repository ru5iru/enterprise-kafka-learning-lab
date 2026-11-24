#!/usr/bin/env bash
set -euo pipefail
readonly destination='/opt/kafka-lab/kafka_2.13-4.4.0'
readonly checksum='f5ceba8a265ab6bb2d68362b1f6859a95e15d60ef92ba83b43fdf065b557dc18e98d6383c15b9977320e25b3a2c8b6f11decb17b0fa6c0f163423793a0eb95cb'
[[ $(id -u) == 0 ]] || { echo 'Run inside Ubuntu WSL as root.' >&2; exit 1; }
[[ $# -le 1 ]] || { echo 'Usage: install-kafka-cli.sh [local-archive]' >&2; exit 64; }
if [[ ! -d "$destination" ]]; then
  if [[ $# == 1 ]]; then
    archive=$1
    [[ -f "$archive" ]] || { echo 'Local Kafka archive not found.' >&2; exit 1; }
  else
    download_dir=$(mktemp -d /tmp/kafka-lab-kafka.XXXXXXXX)
    archive="$download_dir/kafka.tgz"
    trap 'rm -f -- "$download_dir/kafka.tgz"; rmdir -- "$download_dir"' EXIT
    curl --fail --silent --show-error --location --retry 2 --max-time 180 \
      https://dlcdn.apache.org/kafka/4.4.0/kafka_2.13-4.4.0.tgz -o "$archive"
  fi
  printf '%s  %s\n' "$checksum" "$archive" | sha512sum --check --status
  install -d -m 0755 /opt/kafka-lab
  tar --extract --gzip --file "$archive" --directory /opt/kafka-lab --no-same-owner
fi
JAVA_HOME=/opt/kafka-lab/jdk-25.0.5.1 "$destination/bin/kafka-topics.sh" --version
