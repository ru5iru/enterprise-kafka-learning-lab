# P1-027 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-026: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `5cf4988dd42e80635b406b124929e4fc7708279e`

## Scope and acceptance review

Reviewed Java package specification guidance on qualified names/collision avoidance, repository owner/remote identity, service boundaries and ADR-0002. Accepted examples map to planned owner services or native-client experiments. Negative documentary cases reject invalid identifiers, unrelated shared business namespace and environment-specific packages. No runtime/compile evidence is fabricated.

## Executed check

Command: `python P1-027-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import re
p=Path('docs/development/package-naming.md');text=p.read_text(encoding='utf-8')
for name in ['io.github.ru5iru.kafkalab.order.api','io.github.ru5iru.kafkalab.payment.messaging','io.github.ru5iru.kafkalab.experiments.nativeclient']:
 assert name in text and re.fullmatch(r'[a-z][a-z0-9]*(?:\.[a-z][a-z0-9]*)+',name)
for phrase in ['Reject: case/hyphen','Reject: unrelated placeholder','deployment environment is configuration','not an authentication','does not establish Maven Central publishing rights','No Java packages/services were generated']:assert phrase in text
assert not Path('applications').exists()
print('PASS: three qualified-name/ownership examples, three documented rejection scenarios and no generated service/layer structure')
```

Exit code: 0. Observed output:

```text
PASS: three qualified-name/ownership examples, three documented rejection scenarios and no generated service/layer structure
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

This is a reviewed convention, not an installed architecture validator or actual Java package tree. Publishing rights, Spring scanning and compiled cross-service isolation are not established. No significant architecture change beyond existing ownership is made; no new ADR is required.

Correct the convention through a new focused commit. If packages later exist, review imports/scanning/build/contract consumers before a rename; do not mass-move shared history or generated contracts.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-027.md).
