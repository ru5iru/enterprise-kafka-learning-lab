# P1-023 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-022: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `96c03cb295837d6262d23e10084bb9a08aec0a60`

## Scope and acceptance review

Publisher metadata identified current 2.0.0; exact README documents the Java runtime minimum, AOSP/CLI modes and Apache-2.0 license. The standalone artifact SHA-256 was checked before Linux installation and again on the installed JAR. Real Java 25 formatting experiments passed drift, write, four-space, byte-idempotence, clean-check and malformed-source outcomes.

## Executed check

Command: `python P1-023-verify.py` from the repository root, using this exact script:

```python
import subprocess
script=r"""set -euo pipefail
root=/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab
work=$(mktemp -d /tmp/kafka-lab-format.XXXXXXXX)
trap 'rm -f -- "$work/Probe.java" "$work/first.txt" "$work/Broken.java" "$work/error.log"; rmdir -- "$work"' EXIT
printf 'class Probe{public static void main(String[]a){System.out.println("probe");}}\n' > "$work/Probe.java"
if bash "$root/scripts/wsl/format-java.sh" --check "$work/Probe.java" > "$work/error.log" 2>&1; then exit 1; fi
bash "$root/scripts/wsl/format-java.sh" --write "$work/Probe.java"
cp "$work/Probe.java" "$work/first.txt"
bash "$root/scripts/wsl/format-java.sh" --write "$work/Probe.java"
cmp "$work/first.txt" "$work/Probe.java"
bash "$root/scripts/wsl/format-java.sh" --check "$work/Probe.java"
python3 -c 'import sys; assert "    public static void main" in open(sys.argv[1]).read()' "$work/Probe.java"
printf 'class Broken{ invalid }\n' > "$work/Broken.java"
if bash "$root/scripts/wsl/format-java.sh" --check "$work/Broken.java" > "$work/error.log" 2>&1; then exit 1; fi
printf 'PASS: formatter drift detection, explicit write, four-space style, byte idempotence, clean check and malformed-source rejection\n'
"""
r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash','-s'],input=script.encode(),capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
print(out.strip())
```

Exit code: 0. Observed output:

```text
PASS: formatter drift detection, explicit write, four-space style, byte idempotence, clean check and malformed-source rejection
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No application source was reformatted, editor extension installed or Maven formatting gate enabled. Java formatter success does not prove program semantics, all Java syntax or future Spotless compatibility. Publisher checksum is not an independent signature audit.

Review/revert explicit source changes or wrapper/tool pin changes. Keep the versioned JAR until dependent tooling is checked; do not run an automatic mass-format or delete unrelated tools.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-023.md).
