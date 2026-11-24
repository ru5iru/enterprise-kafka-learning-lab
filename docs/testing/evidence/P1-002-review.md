# P1-002 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-001: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `c18d8a3fe6c9b11ce4a7864bf78095d9adf7d97c`

## Scope and acceptance review

README self-review covers purpose, current state, clone/read onboarding, source-of-truth tracking, learning path, decisions, navigation and safe support routes. Existing P0 facts were cross-checked; obsolete scaffold-only claims were removed. Clone command syntax and origin match P1-001; a fresh clone was not executed.

## Executed check

Command: `python P1-002-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import re,csv
p=Path('README.md');text=p.read_text(encoding='utf-8')
for heading in ['Current state','Start learning','Learning path and decisions','Find the documentation','Safety and help']:assert '## '+heading in text
for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)',text):
    if not target.startswith('https://'):assert (p.parent/target).exists(),target
assert 'No Java application' in text and 'workload hypothesis' in text and 'P0 planning is complete' in text
assert 'initial status is' not in text and 'Begin with **P0-001**' not in text
assert not Path('pom.xml').exists() and not Path('applications').exists()
with Path('docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv').open(encoding='utf-8-sig',newline='') as f:rows=list(csv.DictReader(f))
assert sum(r['Phase']=='P0' and r['Status']=='Done' for r in rows)==45
print('PASS: README onboarding/navigation, local targets, 45-task P0 status and explicit no-runtime boundary')
```

Exit code: 0. Observed output:

```text
PASS: README onboarding/navigation, local targets, 45-task P0 status and explicit no-runtime boundary
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No browser rendering, fresh clone, external uptime, build or runtime verification was performed. Local links are checked as file/directory targets, not heading fragments. Version installation and CI remain later tasks.

Revert this documentation commit if navigation regresses; preserve the task ledger and correct it deliberately rather than inventing implementation status.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-002.md).
