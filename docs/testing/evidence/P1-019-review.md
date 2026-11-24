# P1-019 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-018: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `2b76ce83b7199ee7ff0de36e2d0e9dcf6bba671d`

## Scope and acceptance review

Installed the exact Ubuntu Compose plugin, then executed the config probe twice, missing-required-variable and invalid-schema rejection, and project-list API call. All passed with Compose 2.40.3. Docker documentation confirms required-value interpolation exits on unset/empty input. No image was pulled, environment values printed, or stack started.

## Executed check

Command: `python P1-019-verify.py` from the repository root, using this exact script:

```python
import subprocess
path='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab/scripts/wsl/verify-compose.sh'
r=subprocess.run(['wsl','-d','Ubuntu','-u','root','--exec','/bin/bash',path],capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
assert '2.40.3' in out and 'no stack started' in out
print(out.strip())
```

Exit code: 0. Observed output:

```text
Docker Compose version 2.40.3+ds1-0ubuntu1~24.04.1
PASS: repeated Compose config, required-variable/schema rejection and daemon project-list API; no stack started
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

The parser/API experiment is not a running Compose application. Host packages were not generally upgraded; apt reported 92 unrelated packages not upgraded, so host patch completeness is not claimed. Root access is explicit under ADR-0012; no group grant or TCP endpoint was added.

Correct/remove the config probe through normal Git review and assess package consumers before removing the newly installed plugin. No containers/volumes/ports exist from this task to tear down.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-019.md).
