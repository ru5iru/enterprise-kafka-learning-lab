# P1-032 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-031: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `b5799b42de94368c865d5b31558d91acdf5a81b4`

## Scope and acceptance review

Rechecked Boot official requirements using verified Windows TLS: Boot 4.2.0 documents Java 17-27. Read actual Central BOM 4.2.0 and JUnit 6.1.3 property plus stable metadata for compiler/test/enforcer/lifecycle/diagnostic/format/style tools. Compiler selection deliberately stays on stable Maven-3 plugin line. Documentary scenarios distinguish management from activation, project snapshots from remote mutable dependencies and a tooling probe from a service. No POM/build was generated in this documentation task.

## Executed check

Command: `python P1-032-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
text=Path('docs/development/dependency-management.md').read_text(encoding='utf-8')
adr=Path('docs/architecture/decisions/0013-p1-build-verification.md').read_text(encoding='utf-8')
for phrase in ['BOM does not add libraries','pluginManagement does not execute','independent future service builds','strict checksums','zero-test green build','P2 still owns','not a completed dependency scan']:assert phrase in text,phrase
for pin in ['4.2.0','6.1.3','3.16.0','3.6.1','3.7.0','3.12.0','14.4.0']:assert pin in adr,pin
assert not Path('pom.xml').exists() and not Path('applications').exists()
print('PASS: BOM/plugin/library scope, source-reviewed exact pins, independent build and no-premature-application decisions reviewed')
```

Exit code: 0. Observed output:

```text
PASS: BOM/plugin/library scope, source-reviewed exact pins, independent build and no-premature-application decisions reviewed
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Pins are source-reviewed; joint execution compatibility is not yet proven. No application dependency graph, SCA/SBOM/signature scan or Maven wrapper is claimed. P1-033 through P1-035 and CI verify actual behavior. ADR-0013 records the significant build-scope decision.

Update/revert policy/ADR through explicit follow-up. Once build files exist, restore reviewed pins and rerun affected checks; never clear user caches or silently substitute versions to make a build green.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-032.md).
