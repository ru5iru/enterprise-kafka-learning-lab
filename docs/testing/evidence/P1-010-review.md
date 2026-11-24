# P1-010 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-009: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `162415819a9ef76cccb03a8397de33f02a3fa758`

## Scope and acceptance review

GitHub API GET /repos/ru5iru/enterprise-kafka-learning-lab/private-vulnerability-reporting returned enabled=false; GET /releases?per_page=100 returned zero published releases. Both were actual read-only calls through the configured credential manager; no token or private report content was printed. Policy self-review uses those observations and GitHub recommended non-sensitive contact-request fallback. Two legacy documentation URLs failed; current official URLs were found and reviewed.

## Executed check

Command: `python P1-010-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import re
p=Path('SECURITY.md');text=p.read_text(encoding='utf-8')
for heading in ['Supported scope','Report safely','Information for the private report','Credentials or sensitive data exposed','Progressive controls and current limits']:assert '## '+heading in text
for item in ['Private vulnerability reporting was disabled','No dedicated security email/contact','no published releases','best-effort','Wait for a verified private route','Do not infer a reporting address','revoke/rotate','not implemented merely']:assert item in text,item
for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)',text):
    if not target.startswith('https://') and 'P1-010' not in target:assert (p.parent/target).exists(),target
assert not re.search(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}',text)
assert 'No application, broker, database or Kubernetes deployment exists' in text
assert 'Do not include the affected component' in text and 'Enabling private reporting' in text
print('PASS: policy scope, unavailable-channel fallback, no invented contact/SLA, exposure response, local targets and deferred-control disclosure')
```

Exit code: 0. Observed output:

```text
PASS: policy scope, unavailable-channel fallback, no invented contact/SLA, exposure response, local targets and deferred-control disclosure
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Reporting access is a dated observation, not a future guarantee. No contact request, advisory, email, incident, feature enablement or security setting change was submitted. No private reporting end-to-end test, vulnerability scan or runtime security test ran. Private reporting/contact availability remains an explicitly disclosed owner follow-up; the task creates an honest policy rather than claiming that control.

Correct/revert documentary errors with a new commit. Do not delete genuine findings, publish a trial exploit or rewrite shared history. Exposed credentials require revocation/rotation beyond any file rollback.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-010.md).
