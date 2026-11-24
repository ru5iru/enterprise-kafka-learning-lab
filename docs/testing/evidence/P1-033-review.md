# P1-033 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-032: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `e8390a153ce3428a10b1f5fe702ff9867a78eb3e`

## Scope and acceptance review

An actual root reactor clean compile succeeded: Enforcer 3.7.0 Java/Maven/release-dependency rules passed; Resources 3.5.0 and Compiler 3.16.0 executed; one fixture compiled with parameters/release 25. The final verifier builds the module independently, rejects unsupported release 99 with the expected compiler diagnostic, restores a successful compile, observes class major 69 and inspects the effective compiler configuration.

## Executed check

Command: `python P1-033-verify.py` from the repository root, using this exact script:

```python
import subprocess
script=r"""set -euo pipefail
root=/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab
cd "$root"
source scripts/wsl/environment.sh
work=$(mktemp -d /tmp/kafka-lab-build-check.XXXXXXXX)
trap 'rm -f -- "$work/build.log" "$work/negative.log" "$work/effective.xml"; rmdir -- "$work"' EXIT
mvn -f tools/build-verification/pom.xml clean compile > "$work/build.log" 2>&1 || { tail -n 20 "$work/build.log"; exit 1; }
if mvn -f tools/build-verification/pom.xml -Dmaven.compiler.release=99 clean compile > "$work/negative.log" 2>&1; then exit 1; fi
python3 -c 'import sys; assert "release version 99 not supported" in open(sys.argv[1]).read()' "$work/negative.log"
mvn -f tools/build-verification/pom.xml clean compile > "$work/build.log" 2>&1 || { tail -n 20 "$work/build.log"; exit 1; }
major=$(javap -verbose tools/build-verification/target/classes/io/github/ru5iru/kafkalab/buildverification/ToolchainProbe.class | awk '/major version:/ {print $3}')
test "$major" = 69
mvn -f tools/build-verification/pom.xml help:effective-pom -Doutput="$work/effective.xml" > "$work/build.log" 2>&1
python3 - "$work/effective.xml" <<'PY'
import sys,xml.etree.ElementTree as ET
r=ET.parse(sys.argv[1]);ns={'m':'http://maven.apache.org/POM/4.0.0'}
p=[p for p in r.findall('.//m:plugin',ns) if p.findtext('m:artifactId',namespaces=ns)=='maven-compiler-plugin']
assert any(v.findtext('m:version',namespaces=ns)=='3.16.0' and v.findtext('m:configuration/m:release',namespaces=ns)=='25' for v in p)
PY
printf 'PASS: standalone compile, exact unsupported-release rejection, restored compile, class major 69 and effective compiler version/release\n'
"""
r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash','-s'],input=script.encode(),capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
print(out.strip())
```

Exit code: 0. Observed output:

```text
PASS: standalone compile, exact unsupported-release rejection, restored compile, class major 69 and effective compiler version/release
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Only compiler/toolchain/BOM/lifecycle prerequisites are executed here. No unit/integration tests, formatter/build static gate, hosted CI, Spring service, Kafka or database behavior is claimed. Parent relativePath proves this tool module builds independently, not every future service. Source-scoped unreleased snapshot is distinct from remote mutable dependency.

Review dependent test/quality tasks before changing parent/module structure or compiler flags. Correct/revert the focused build changes without deleting user caches, installing a different Windows toolchain or silently weakening release/lint checks.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-033.md).
