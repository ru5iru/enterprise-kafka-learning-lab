# P1-021 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-020: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `42e32146488269161fe3178fc1b967a1b577fac7`

## Scope and acceptance review

Read-only package inspection found /usr/bin/git, version 2.43.0, installed/candidate Ubuntu revision 1:2.43.0-1ubuntu7.4. The actual Linux probe read the shared checkout, created a throwaway repo, staged/committed synthetic text, observed clean/dirty state correctly and rejected an invalid ref. No installation or real global identity/credential change was performed.

## Executed check

Command: `python P1-021-verify.py` from the repository root, using this exact script:

```python
import subprocess
root='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab'
r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',root+'/scripts/wsl/verify-git.sh'],capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
assert 'git version 2.43.0' in out and 'invalid-ref rejection' in out
print(out.strip())
```

Exit code: 0. Observed output:

```text
git version 2.43.0
PASS: existing Linux Git, mounted-checkout read, isolated init/stage/commit, dirty-diff detection and invalid-ref rejection
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

The synthetic commit is local to a removed temp repository, not project history or a fabricated contributor identity. Linux push/authentication and complete upstream feature/security coverage were not tested. Windows Git remains the publisher; no concurrent mutations are allowed.

No Git package/global setting was changed. Correct/remove the probe in a normal commit; it removes only its own prefix-checked temporary repository and never resets the shared checkout.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-021.md).
