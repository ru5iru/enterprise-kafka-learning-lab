# P1-006 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-005: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `3f8dde4bb0337b5cde795fb4ff37efcf59af19c7`

## Scope and acceptance review

Self-review aligned examples with Conventional Commits 1.0.0 while labeling imperative wording, subject length and task footers as local policy. Checked actual published predecessor commits and sample footer IDs. The breaking-change example is explicitly hypothetical; no event contract or application is implemented.

## Executed check

Command: `python P1-006-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import re,subprocess,csv
text=Path('docs/git/CONTRIBUTION_WORKFLOW.md').read_text(encoding='utf-8')
for item in ['Conventional Commits 1.0.0','BREAKING CHANGE:','Refs: P1-006','Reverts:','no structured type','missing local traceability','not a limit imposed by the specification','No automated version bump']:assert item in text,item
with Path('docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv').open(encoding='utf-8-sig',newline='') as f:ids={r['Task_ID'] for r in csv.DictReader(f)}
for task in re.findall(r'^Refs: (P[0-9]+-[0-9]{3})$',text,re.M):assert task in ids,task
messages=subprocess.check_output(['git','log','-5','--format=%B%x00'],text=True).split('\x00')
for message in messages:
    message=message.strip()
    if not message:continue
    assert re.match(r'^(docs|chore)\([a-z]+\): \S',message)
    assert re.search(r'^Refs: P1-00[1-5]$',message,re.M)
assert 'Update stuff' in text and 'docs(git): ' in text and 'without a task footer' in text
print('PASS: specification/local-policy distinctions, breaking/revert examples, actual task references and 5 published predecessor messages')
```

Exit code: 0. Observed output:

```text
PASS: specification/local-policy distinctions, breaking/revert examples, actual task references and 5 published predecessor messages
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No commitlint, release automation or complete semantic parser is installed. Static checks plus self-review validate the document and five recent task messages; they do not retroactively rewrite historical merge commits or prove all future messages compliant.

Correct policy with a new commit; preserve published history. Revert functional changes with a traceable revert message instead of force-pushing a cosmetic amendment.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-006.md).
