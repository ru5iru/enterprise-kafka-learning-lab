# P1-014 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-013: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `492db37a85eead80c8c3e3475fe5e3216c6f0cad`

## Scope and acceptance review

Verified project launcher selects the installed Linux JDK, rejects an invalid override before command execution, and returns usage exit 64 without a command. No shell login/global profile was changed. The source directory is resolved by Bash and command arguments are passed using exec "$@" rather than eval.

## Executed check

Command: `python P1-014-verify.py` from the repository root, using this exact script:

```python
import subprocess
root='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab'
script=f"set -eu\ncd '{root}'\nsource scripts/wsl/environment.sh\ntest \"$JAVA_HOME\" = /opt/kafka-lab/jdk-25.0.5.1\ncommand -v java\nbash scripts/wsl/lab.sh java --version\n"
r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash','-s'],input=script.encode(),capture_output=True)
assert r.returncode==0,(r.stdout+r.stderr).decode()
assert b'/opt/kafka-lab/jdk-25.0.5.1/bin/java' in r.stdout
bad=subprocess.run(['wsl','-d','Ubuntu','--exec','/usr/bin/env','LAB_JAVA_HOME=/does-not-exist','/bin/bash',root+'/scripts/wsl/lab.sh','java','--version'],capture_output=True)
assert bad.returncode!=0 and b'Invalid Linux JDK' in bad.stderr
empty=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',root+'/scripts/wsl/lab.sh'],capture_output=True)
assert empty.returncode==64 and b'Usage:' in empty.stderr
print('PASS: explicit Linux JAVA_HOME/executable, launcher version, invalid-home rejection and missing-command exit 64')
```

Exit code: 0. Observed output:

```text
PASS: explicit Linux JAVA_HOME/executable, launcher version, invalid-home rejection and missing-command exit 64
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Only explicit project/interactive sourcing selects these settings; arbitrary WSL shells may still inherit Windows paths. Other Linux dependencies are added only by their assigned tasks. No application build or compiler exercise ran.

Stop using the project launcher or source a clean shell; no persistent Windows or shell-profile setting needs reversal. Review any explicit alternate LAB_JAVA_HOME as a tool-version change.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-014.md).
