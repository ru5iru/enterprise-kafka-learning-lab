# P1-009 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-008: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `f4869c2be9734c9c5cbb436222828b40ac211430`

## Scope and acceptance review

Reviewed the template against P1-007 policy and GitHub discovery location. A documentation walkthrough can report static review and N/A runtime tests without checking imaginary success; an implementation with missing applicable evidence exposes a gap. Explicit base/head prompts support the authorized stack. No live PR was created or modified.

## Executed check

Command: `python P1-009-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import re,subprocess
p=Path('.github/pull_request_template.md');text=p.read_text(encoding='utf-8')
headings=re.findall(r'^## (.+)$',text,re.M)
assert headings==['Task and scope','Problem and resulting behavior','Design and trade-offs','Verification and evidence','Documentation and tracker','Risks and rollback','Commit and merge review']
assert '- [x]' not in text and len(re.findall(r'^- \[ \]',text,re.M))==9
for item in ['Head branch/commit','base branch/commit','Not run / N/A','not configured','self-review or independent review','Negative/failure','unrelated CSV rows preserved','required checks/protection respected','Merge action is authorized','Refs: P#-###']:assert item in text,item
for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)',text):assert target.startswith('https://github.com/ru5iru/enterprise-kafka-learning-lab/blob/main/'),target
tracked=subprocess.check_output(['git','ls-files'],text=True).splitlines()
assert [n for n in tracked if n.lower().endswith('pull_request_template.md')]==[p.as_posix()]
assert not text.startswith('---')
print('PASS: one supported default PR template, 7 review sections, 9 unchecked confirmations, explicit skipped/no-CI states and safe repository URLs')
```

Exit code: 0. Observed output:

```text
PASS: one supported default PR template, 7 review sections, 9 unchecked confirmations, explicit skipped/no-CI states and safe repository URLs
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Static shape/content checks and self-review do not prove GitHub autofill or enforce completed fields. The updated default takes effect after merge to main. URL targets use explicit main context; their content may precede this unmerged task sequence.

Restore the prior template with a normal revert/corrective commit if discovery or completion guidance regresses; do not alter existing PR descriptions or fabricate check results.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-009.md).
