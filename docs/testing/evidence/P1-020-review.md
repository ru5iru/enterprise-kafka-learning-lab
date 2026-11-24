# P1-020 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-019: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `3d43642ea11f9c9a67e1f4b992cfbca434f2c30e`

## Scope and acceptance review

Pulled official hello-world:linux, observed digest 5e22040d441e5fb3aed38368acbe8486b575d7018df38dbdfbc7311fbb2ef3a9, and executed only the pinned digest afterward. Two bounded/networkless/non-root/read-only runs produced the expected greeting. Invalid executable and missing local image were rejected; the missing-image check returned 125 without pulling. All probe cidfiles were checked absent from the daemon after --rm cleanup.

## Executed check

Command: `python P1-020-verify.py` from the repository root, using this exact script:

```python
import subprocess
path='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab/scripts/wsl/verify-container.sh'
r=subprocess.run(['wsl','-d','Ubuntu','-u','root','--exec','/bin/bash',path],capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
assert 'two digest-pinned restricted container runs' in out and 'automatic container cleanup' in out
print(out.strip())
```

Exit code: 0. Observed output:

```text
PASS: two digest-pinned restricted container runs, invalid-entrypoint/missing-image rejection and automatic container cleanup
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

The official test image remains cached. This proves basic Linux container execution and expected failure/cleanup, not application readiness, Kafka networking, vulnerability absence or production confinement. No port or persistent volume was published and no global prune was used.

Cleanup targets only IDs captured in this probe unique cidfiles. Never prune unrelated containers, images or volumes. Remove the cached image only deliberately after checking other consumers.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-020.md).
