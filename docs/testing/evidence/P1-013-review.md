# P1-013 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-012: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `67d051047d3d6d3904c20f3c5b99338ef84c989a`

## Scope and acceptance review

Official Oracle download page confirmed 25.0.5.1. Publisher SHA-256 3d40d69461200594380ac84c17be6224539022028730cffe043ac70c41ffd1d5 was retrieved over verified TLS and the installer required it to match before extraction. The first nobody-user probe returned This account is currently not available rather than reaching the installer. The verifier was corrected to use WSL --exec and rerun. Actual installation returned Java 25.0.5.1+4-LTS-20. Terms page was reviewed. Installation ran only in Ubuntu WSL at /opt/kafka-lab; no environment configuration or compiler experiment was performed ahead of its task.

## Executed check

Command: `python P1-013-verify.py` from the repository root, using this exact script:

```python
import subprocess
root='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab'
r=subprocess.run(['wsl','-d','Ubuntu','--','bash','-s'],input=b'set -eu\n/opt/kafka-lab/jdk-25.0.5.1/bin/java --version\ntest -x /opt/kafka-lab/jdk-25.0.5.1/bin/javac\n',capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0 and '25.0.5.1+4' in out,out
bad=subprocess.run(['wsl','-d','Ubuntu','-u','nobody','--exec','/bin/bash',root+'/scripts/wsl/install-jdk.sh'],capture_output=True)
assert bad.returncode!=0 and b'Run this installer as root' in bad.stderr
print(out.strip())
print('PASS: Linux JDK runtime/build and compiler binary; non-root installation rejected without changing Windows/global environment')
```

Exit code: 0. Observed output:

```text
java 25.0.5.1 2026-11-17 LTS
Java(TM) SE Runtime Environment (build 25.0.5.1+4-LTS-20)
Java HotSpot(TM) 64-Bit Server VM (build 25.0.5.1+4-LTS-20, mixed mode, sharing)
PASS: Linux JDK runtime/build and compiler binary; non-root installation rejected without changing Windows/global environment
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Publisher checksum is not an independent signature audit. Mutable latest URL is hash-pinned and fails closed after an artifact change. Spring requirements reread hit a certificate-chain error; no TLS verification was disabled and no new Boot compatibility result is claimed. Full compiler/build verification remains P1-015 and later. ADR-0011 records the owner-directed WSL setup.

No pre-existing JDK or alternatives were changed. Retire only this new versioned Linux directory after checking dependent work; correct the installer pin with reviewed sources if the publisher artifact changes.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-013.md).
