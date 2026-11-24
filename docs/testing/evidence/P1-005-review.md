# P1-005 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-004: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `0410cbc5c8767913b56d7cba07162bc3429035b5`

## Scope and acceptance review

Self-review confirms a stable task-ID naming rule, concrete accepted/rejected examples, actual CSV membership checks, a clear Git-syntax versus repository-policy distinction and safe handling of explicitly authorized dependent sequences. Existing GitHub Flow is retained rather than introducing GitFlow or branch-per-service isolation.

## Executed check

Command: `python P1-005-verify.py` from the repository root, using this exact script:

```python
import csv,re,subprocess
from pathlib import Path
text=Path('docs/git/CONTRIBUTION_WORKFLOW.md').read_text(encoding='utf-8')
with Path('docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv').open(encoding='utf-8-sig',newline='') as f:ids={r['Task_ID'] for r in csv.DictReader(f)}
pattern=r'(feat|fix|docs|test|refactor|perf|build|ci|chore|revert)/(P(?:[0-9]|1[0-4])-[0-9]{3})-[a-z0-9]+(?:-[a-z0-9]+)*'
valid=['docs/P1-005-branch-naming','chore/P1-003-gitignore','test/P6-017-consumer-crash']
invalid=['feature/P1-005-branch-naming','docs/p1-005-branch-naming','docs/P1-005-Branch_Naming','docs/P1-999-branch-naming']
for name,expected in [(n,True) for n in valid]+[(n,False) for n in invalid]:
    assert name in text
    match=re.fullmatch(pattern,name);assert bool(match and match.group(2) in ids)==expected
for name in valid:subprocess.run(['git','check-ref-format','--branch',name],check=True,capture_output=True)
for name in ['docs/P1-005-bad..name','docs/P1-005-bad name','docs/P1-005-bad.lock']:
    assert subprocess.run(['git','check-ref-format','--branch',name],capture_output=True).returncode!=0
assert 'No hook or CI naming enforcement' in text and 'stacked on that predecessor' in text
print('PASS: 3 valid names, 4 policy rejections, 3 Git ref rejections; current stacked-base workflow documented')
```

Exit code: 0. Observed output:

```text
PASS: 3 valid names, 4 policy rejections, 3 Git ref rejections; current stacked-base workflow documented
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

The verifier checks documented examples and Git syntax; it is not a deployed naming validator. No GitHub ruleset or CI hook was installed. Existing published branch names were not renamed and main was not modified.

Correct the policy in a new commit if unsuitable. Do not rewrite published task history or rename/delete shared refs merely to retrofit documentation.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-005.md).
