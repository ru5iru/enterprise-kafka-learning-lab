# P1-003 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-002: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `ffe2f240220f3448caf3a220d76b265959a0f393`

## Scope and acceptance review

Existing rules were retained, documented and extended for sanitized environment variants and local lab/database state. Nonexistent-path CLI probes avoid creating real secrets or generated outputs. Negative probes prove legitimate source, wrapper assets, migration SQL and evidence stay eligible for tracking.

## Executed check

Command: `python P1-003-verify.py` from the repository root, using this exact script:

```python
import subprocess
ignored=['.env','.env.local','applications/order/.env.dev','applications/order/target/a.class','applications/order/build/output.txt','.idea/workspace.xml','.vscode/settings.json','local.key','local.pem','local.p12','local.jks','secrets/demo.txt','infrastructure/security/private/demo.txt','terraform.tfstate','local.tfvars','.local/cache.bin','runtime/broker/data','backup.dump','backup.sql.gz','__pycache__/check.pyc']
visible=['.env.example','.env.dev.example','applications/order/.env.example','applications/order/src/main/java/Lab.java','applications/order/pom.xml','.mvn/wrapper/maven-wrapper.jar','mvnw','mvnw.cmd','applications/order/src/main/resources/db/migration/V1__init.sql','docs/testing/evidence/check.md','docs/security/public-cert-policy.md','.github/workflows/ci.yml']
for paths,expected in [(ignored,0),(visible,1)]:
    for path in paths:
        r=subprocess.run(['git','check-ignore','--no-index','-q','--',path])
        assert r.returncode==expected,(path,r.returncode)
tracked=subprocess.check_output(['git','ls-files','-ci','--exclude-standard'],text=True)
assert not tracked.strip(),'Tracked paths match ignore rules; inspect without printing possible sensitive names'
print(f'PASS: {len(ignored)} ignored-path probes; {len(visible)} visible-path probes; no tracked paths match ignore rules')
```

Exit code: 0. Observed output:

```text
PASS: 20 ignored-path probes; 12 visible-path probes; no tracked paths match ignore rules
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Pattern probes do not prove files are secret-free and cannot remove already committed content. No historical secret scanner or data recovery drill ran. The policy deliberately ignores all PEM/ASC, including public material, until a narrow future fixture exception is reviewed.

Revert only the ignore-rule change if a legitimate path is hidden, diagnose with git check-ignore -v, and add a narrow reviewed exception. If a secret is exposed, revoke/rotate it; changing ignore rules alone cannot repair the exposure.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-003.md).
