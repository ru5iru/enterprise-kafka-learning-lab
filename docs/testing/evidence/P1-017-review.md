# P1-017 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-016: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `ec7866c04cf0a652923f95a89d651999ae24eba6`

## Scope and acceptance review

The first actual run completed cold-cache Central plugin/dependency resolution, effective-POM generation, offline repetition and malformed-POM/unknown-phase rejection. The final verifier repeats the full experiment with another new cache and the same explicit 3.6.0 plugin pin. Both runs passed. Maven Central TLS validated normally; no imported CA or insecure transport setting was required.

## Executed check

Command: `python P1-017-verify.py` from the repository root, using this exact script:

```python
import subprocess
path='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab/scripts/wsl/verify-maven.sh'
r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',path],capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
assert 'cold-cache strict-checksum resolution' in out and 'unknown phase rejection' in out
print(out.strip())
print('PASS: second complete experiment after the initial recorded online/offline and negative-case run')
```

Exit code: 0. Observed output:

```text
PASS: Maven cold-cache strict-checksum resolution, offline repeat, malformed POM and unknown phase rejection
PASS: second complete experiment after the initial recorded online/offline and negative-case run
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

A packaging=pom probe is not a Java application build or full dependency/plugin compatibility matrix. It does not establish every mirror/repository is reachable. Full project compiler/test/static-analysis configuration remains P1-032 onward; no permanent POM was added here.

The probe removes only its own prefix-checked temporary tree. Correct/revert the script normally if necessary; do not delete user Maven caches or suppress TLS/checksum validation.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-017.md).
