#!/usr/bin/env bash
set -euo pipefail
readonly destination='/opt/kafka-lab/apache-maven-3.10.2'
readonly url='https://dlcdn.apache.org/maven/maven-3/3.10.2/binaries/apache-maven-3.10.2-bin.tar.gz'
readonly checksum='57d2db6b37e7582119137ade544557bba741b29e62109ef81539a2bdfd6d0e641fdd5d8edb014af1816d0510deac6fac8f347433b3a1aa36316ba85aa77b8119'
[[ $(id -u) == 0 ]] || { echo 'Run this installer as root inside Ubuntu WSL.' >&2; exit 1; }
[[ $# -le 1 ]] || { echo 'Usage: install-maven.sh [local-archive]' >&2; exit 64; }
if [[ ! -d "$destination" ]]; then
  if [[ $# == 1 ]]; then
    archive=$1
    [[ -f "$archive" ]] || { echo 'Local Maven archive not found.' >&2; exit 1; }
  else
    download_dir=$(mktemp -d /tmp/kafka-lab-maven.XXXXXXXX)
    archive="$download_dir/maven.tar.gz"
    trap 'rm -f -- "$download_dir/maven.tar.gz"; rmdir -- "$download_dir"' EXIT
    curl --fail --silent --show-error --location --retry 2 --max-time 180 "$url" -o "$archive"
  fi
  printf '%s  %s\n' "$checksum" "$archive" | sha512sum --check --status
  install -d -m 0755 /opt/kafka-lab
  tar --extract --gzip --file "$archive" --directory /opt/kafka-lab --no-same-owner
fi
JAVA_HOME=/opt/kafka-lab/jdk-25.0.5.1 "$destination/bin/mvn" --version
