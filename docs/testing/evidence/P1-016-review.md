# P1-016 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-015: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `90b44b1beb1ab32d0cccc6b5a4f59b93a042d35b`

## Scope and acceptance review

Official Apache page identified current Maven 3.10.2 and artifact/checksum URLs. WSL curl rejected the Apache TLS chain; Windows curl verified the HTTPS connection and fetched the publisher checksum and archive. The Linux installer checked the pinned SHA-512 before extraction. Actual mvn --version reports 3.10.2, Oracle Java 25.0.5.1 and Linux/amd64. The first documentation writer failed with a Windows default-codepage decode error before updating tracking. Explicit UTF-8 was applied and the previously mojibaked P1-013 setup heading was restored from its original commit; verification was rerun. No POM or dependency build is introduced.

## Executed check

Command: `python P1-016-verify.py` from the repository root, using this exact script:

```python
import subprocess
root='/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab'
r=subprocess.run(['wsl','-d','Ubuntu','--exec','/bin/bash',root+'/scripts/wsl/lab.sh','mvn','--version'],capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
for value in ['Apache Maven 3.10.2','/opt/kafka-lab/apache-maven-3.10.2','Java version: 25.0.5.1','OS name: "linux"']:assert value in out,value
bad=subprocess.run(['wsl','-d','Ubuntu','-u','root','--exec','/bin/bash',root+'/scripts/wsl/install-maven.sh','one','two'],capture_output=True)
assert bad.returncode==64 and b'Usage:' in bad.stderr
print(out.strip())
print('PASS: Linux Maven/JDK selection and excessive-argument rejection; publisher SHA-512 enforced by executed installer')
```

Exit code: 0. Observed output:

```text
Apache Maven 3.10.2 (61b8bc355f4c4325463c22aa9afe4e7811a290f8)
Maven home: /opt/kafka-lab/apache-maven-3.10.2
Java version: 25.0.5.1, vendor: Oracle Corporation, runtime: /opt/kafka-lab/jdk-25.0.5.1
Default locale: en, platform encoding: UTF-8, time zone: Asia/Colombo
OS name: "linux", version: "5.15.167.4-microsoft-standard-wsl2", arch: "amd64", family: "unix"
PASS: Linux Maven/JDK selection and excessive-argument rejection; publisher SHA-512 enforced by executed installer
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

The WSL Apache TLS-chain issue remains unresolved; no trust root or insecure flag was added. Windows-verified transport plus Linux hash verification is the documented fallback. Plugin/dependency download behavior is deliberately verified next in P1-017. GPG signature verification was not performed.

Retire only this new Linux Maven version after inspecting dependent tasks, and update the project PATH deliberately. Do not modify existing Windows Maven or hide TLS failures.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-016.md).
