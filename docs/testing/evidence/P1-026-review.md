# P1-026 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-025: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `95d43648a9c9ca53d45e3e59c71e611da11ebefa`

## Scope and acceptance review

APT installed only libpq5, postgresql-client-common and postgresql-client-16. Actual psql reports 16.15. Help was executed twice and the isolated fake connection produced documented noninteractive bad-connection exit 2 plus Connection refused. PostgreSQL 16 server executable is absent. Official psql exit/options documentation was read before the experiment.

## Executed check

Command: `python P1-026-verify.py` from the repository root, using this exact script:

```python
import subprocess
path='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab/scripts/wsl/verify-postgresql-client.sh'
r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',path],capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
assert '16.15' in out and 'connection rejection exit 2' in out
server=subprocess.run(['wsl','-d','Ubuntu','--exec','/usr/bin/test','-x','/usr/lib/postgresql/16/bin/postgres'])
assert server.returncode==1
print(out.strip())
print('PASS: client installed without PostgreSQL 16 server binary')
```

Exit code: 0. Observed output:

```text
psql (PostgreSQL) 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
PASS: PostgreSQL client version/help twice; bounded loopback connection rejection exit 2; no server installed by this probe
PASS: client installed without PostgreSQL 16 server binary
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No database was deployed or query successfully executed. No authentication, JDBC, schema, TLS or backup behavior is established. The client version does not select the later server/image version. Host-wide patch completeness and all psql features were not tested.

Assess client/library consumers before removing newly installed packages; no server/data directory exists from this task to delete. Correct the bounded probe without pointing it at a real database or adding credentials.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-026.md).
