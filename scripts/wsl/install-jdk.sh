#!/usr/bin/env bash
set -euo pipefail

# Run inside Ubuntu WSL as root. Keep the Windows workstation unchanged.
readonly version='25.0.5.1'
readonly destination="/opt/kafka-lab/jdk-${version}"
readonly url='https://download.oracle.com/java/25/latest/jdk-25_linux-x64_bin.tar.gz'
readonly checksum='3d40d69461200594380ac84c17be6224539022028730cffe043ac70c41ffd1d5'

[[ $(id -u) == 0 ]] || { echo 'Run this installer as root inside Ubuntu WSL.' >&2; exit 1; }
[[ $(uname -m) == x86_64 ]] || { echo 'This pinned artifact requires x86_64.' >&2; exit 1; }

if [[ ! -d "$destination" ]]; then
  download_dir=$(mktemp -d /tmp/kafka-lab-jdk.XXXXXXXX)
  trap 'rm -f -- "$download_dir/jdk.tar.gz"; rmdir -- "$download_dir"' EXIT
  curl --fail --silent --show-error --location --retry 2 --max-time 180 "$url" -o "$download_dir/jdk.tar.gz"
  printf '%s  %s\n' "$checksum" "$download_dir/jdk.tar.gz" | sha256sum --check --status
  install -d -m 0755 /opt/kafka-lab
  tar --extract --gzip --file "$download_dir/jdk.tar.gz" --directory /opt/kafka-lab --no-same-owner
fi

[[ -x "$destination/bin/java" && -x "$destination/bin/javac" ]]
"$destination/bin/java" --version
