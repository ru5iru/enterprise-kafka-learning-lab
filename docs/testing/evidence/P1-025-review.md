# P1-025 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-024: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `e0610d136c12ea36f234ba439a0ae38e15322ead`

## Scope and acceptance review

Apache current release links selected 4.4.0. The 128-hex publisher SHA-512 was retrieved over verified Windows TLS, concatenated from Apache grouped checksum formatting and pinned in the Linux installer. The official archive was acquired via the same certificate-validating transport, hash-checked in WSL, and extracted into the versioned directory. Actual admin/consumer CLI versions and parser rejection were verified without broker startup.

## Executed check

Command: `python P1-025-verify.py` from the repository root, using this exact script:

```python
import subprocess
root='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab'
for tool in ['kafka-topics.sh','kafka-console-consumer.sh']:
 r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',root+'/scripts/wsl/lab.sh',tool,'--version'],capture_output=True)
 out=(r.stdout+r.stderr).decode();assert r.returncode==0 and '4.4.0' in out,out
 print(tool+': '+out.strip())
bad=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',root+'/scripts/wsl/lab.sh','kafka-topics.sh','--not-a-valid-kafka-option'],capture_output=True)
out=(bad.stdout+bad.stderr).decode();assert bad.returncode!=0 and ('not a recognized option' in out or 'unrecognized' in out.lower()),out
print('PASS: Linux admin/consumer CLI startup and invalid-option rejection; no broker command executed')
```

Exit code: 0. Observed output:

```text
kafka-topics.sh: 4.4.0
kafka-console-consumer.sh: 4.4.0
PASS: Linux admin/consumer CLI startup and invalid-option rejection; no broker command executed
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

This is the full binary distribution used as a CLI tool install, not an active Kafka server. No broker configuration, topic, record, port, TLS/ACL or client/broker compatibility experiment exists yet. PGP signature verification was not performed; checksum verification is not independent authenticity proof.

Retire the new CLI directory only after checking consumers; do not remove unrelated tools or any later broker data. Update version/hash through reviewed source evidence and repeat CLI tests.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-025.md).
