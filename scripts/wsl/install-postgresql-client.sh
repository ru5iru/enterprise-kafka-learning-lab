#!/usr/bin/env bash
set -euo pipefail
[[ $(id -u) == 0 ]] || { echo 'Run inside Ubuntu WSL as root.' >&2; exit 1; }
DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::Lock::Timeout=60 install --yes --no-install-recommends \
  'postgresql-client-16=16.15-0ubuntu0.24.04.1' 'libpq5=16.15-0ubuntu0.24.04.1'
psql --version
