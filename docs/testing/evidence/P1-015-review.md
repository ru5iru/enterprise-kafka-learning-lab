# P1-015 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-014: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `d6cd3c46672da56157c2a8f92a1bcb58309bf176`

## Scope and acceptance review

Executed the same compiler experiment twice using the installed Linux JDK. Each compiled and ran synthetic Java successfully, observed class major 69, rejected invalid source with no Broken.class, and rejected unsupported release 99. Source and bytecode stayed in a unique Linux temporary directory; no service or future business feature was introduced.

## Executed check

Command: `python P1-015-verify.py` from the repository root, using this exact script:

```python
import subprocess
path='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab/scripts/wsl/verify-java.sh'
for attempt in range(1,3):
 r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',path],capture_output=True)
 out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
 assert 'class major 69' in out and 'javac 25.0.5.1' in out
 print(f'Run {attempt}: '+out.strip())
```

Exit code: 0. Observed output:

```text
Run 1: javac 25.0.5.1
PASS: compile/run release 25, class major 69, malformed source and unsupported release rejected
Run 2: javac 25.0.5.1
PASS: compile/run release 25, class major 69, malformed source and unsupported release rejected
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

This is basic JDK functionality, not Maven dependency resolution, Spring compatibility, application testing or a Kafka experiment. Compiler diagnostics are captured only for bounded synthetic failures and removed after the assertion; no sensitive logs are involved.

Remove/correct the probe through a normal commit if needed; it has no persistent runtime state and does not uninstall the JDK. Recheck both positive and negative paths after changing compiler flags.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-015.md).
