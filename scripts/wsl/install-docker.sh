#!/usr/bin/env bash
set -euo pipefail
[[ $(id -u) == 0 ]] || { echo 'Run inside Ubuntu WSL as root.' >&2; exit 1; }
# Use a private signed index so another apt-get update can finish undisturbed.
work=$(mktemp -d /var/tmp/kafka-lab-apt.XXXXXXXX)
chmod 0755 "$work"
cleanup() {
  case "$work" in /var/tmp/kafka-lab-apt.*) rm -rf -- "$work" ;; *) return 1 ;; esac
}
trap cleanup EXIT
install -d -m 0755 "$work/lists/partial"
options=(-o "Dir::State::lists=$work/lists" -o Acquire::Retries=1 -o Acquire::http::Timeout=20 -o Acquire::https::Timeout=20 -o DPkg::Lock::Timeout=60)
apt-get "${options[@]}" update > "$work/update.log" 2>&1 || { tail -n 25 "$work/update.log" >&2; exit 1; }
DEBIAN_FRONTEND=noninteractive apt-get "${options[@]}" install --yes --no-install-recommends \
  'docker.io=29.1.3-0ubuntu3~24.04.2' \
  'containerd=2.2.1-0ubuntu1~24.04.4' \
  'runc=1.3.4-0ubuntu1~24.04.1' > "$work/install.log" 2>&1 || { tail -n 25 "$work/install.log" >&2; exit 1; }
systemctl enable --now docker
docker version --format 'Client {{.Client.Version}}; Server {{.Server.Version}}'
dpkg-query -W -f='${Package} ${Version}\n' docker.io containerd runc
