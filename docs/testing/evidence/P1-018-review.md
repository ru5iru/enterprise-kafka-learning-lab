# P1-018 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-017: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `50bcec99af2964fbb06a51592a6edcde55f8139f`

## Scope and acceptance review

Actual signed apt installation and daemon startup succeeded with client/server 29.1.3 and the recorded package versions. Initial global apt refresh failed because another apt update held the lists lock; inspection showed it had run over a day. Private authenticated index refresh/install succeeded without interrupting it. Docker upstream documentation was reviewed: distribution docker.io and upstream CE are distinct/conflicting families. ADR-0012 records the selected family and rootful Unix-socket model.

## Executed check

Command: `python P1-018-verify.py` from the repository root, using this exact script:

```python
import subprocess
script=b"set -eu\nsystemctl is-active docker\ndocker version --format 'Client {{.Client.Version}}; Server {{.Server.Version}}'\ndocker context inspect default --format '{{(index .Endpoints \"docker\").Host}}'\ndpkg-query -W -f='${Package} ${Version}\\n' docker.io containerd runc\ntest -z \"$(ss -H -ltn '( sport = :2375 or sport = :2376 )')\"\n"
r=subprocess.run(['wsl','-d','Ubuntu','-u','root','--exec','/bin/bash','-s'],input=script,capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
assert 'Client 29.1.3; Server 29.1.3' in out and 'unix:///var/run/docker.sock' in out
bad=subprocess.run(['wsl','-d','Ubuntu','-u','nobody','--exec','/usr/bin/docker','info'],capture_output=True)
assert bad.returncode!=0 and b'permission denied' in bad.stderr.lower()
print(out.strip())
print('PASS: active Linux engine, pinned packages, Unix endpoint, no 2375/2376 listener, unprivileged denial')
```

Exit code: 0. Observed output:

```text
active
Client 29.1.3; Server 29.1.3
unix:///var/run/docker.sock
containerd 2.2.1-0ubuntu1~24.04.4
docker.io 29.1.3-0ubuntu3~24.04.2
runc 1.3.4-0ubuntu1~24.04.1
PASS: active Linux engine, pinned packages, Unix endpoint, no 2375/2376 listener, unprivileged denial
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No test container, image pull, Compose stack, rootless daemon or user docker-group grant was performed. Container behavior is P1-020. No package purge/data deletion is a rollback. Ubuntu package selection is not a claim of upstream CE support or a complete vulnerability audit.

Inspect users and persistent Docker state before stopping/disabling this new service or removing package pins. Never delete /var/lib/docker, kill unrelated apt or remove package locks to roll back setup.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-018.md).
