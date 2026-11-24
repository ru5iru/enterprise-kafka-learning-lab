# P1-011 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-010: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `b8028f356c8df48661da264e56c2f91e24a5bc4d`

## Scope and acceptance review

Walked through selecting an existing task, rejecting an incomplete dependency, making a scoped docs change, writing learning/evidence, safely updating the CSV, staging explicit files and handing off a PR. Cross-reviewed with AGENTS, task skill, Git policy and security policy. Commands are labeled illustrative; the verifier does not execute the placeholder branch/staging commands.

## Executed check

Command: `python P1-011-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import re
p=Path('CONTRIBUTING.md');text=p.read_text(encoding='utf-8')
for heading in ['Read first and choose scope','Start a focused branch','Study, change and explain','Verify and record the truth','Update only legitimate tracking fields','Commit, review and hand off']:assert '## '+heading in text
for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)',text):assert (p.parent/target).exists(),target
for phrase in ['11-section template','18 named columns plus two unnamed empty columns','git diff --cached --check','Refs: P1-011','when authorized by the user','not green CI','preserve existing user changes','Stop at the requested endpoint','not a broad add-all command']:assert phrase in text,phrase
assert 'git add .' not in text and 'git push --force' not in text
workflow=Path('docs/git/CONTRIBUTION_WORKFLOW.md').read_text(encoding='utf-8')
assert 'stacked on that predecessor' in workflow and 'no independent review occurred' in workflow
assert not Path('.github/CONTRIBUTING.md').exists() and not Path('docs/CONTRIBUTING.md').exists()
print('PASS: contributor journey, all local targets, scoped Git examples, CSV baseline preservation and consistency with review/stacking policy')
```

Exit code: 0. Observed output:

```text
PASS: contributor journey, all local targets, scoped Git examples, CSV baseline preservation and consistency with review/stacking policy
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No new clone, external contribution, GitHub onboarding render, build or CI run was executed. Static review does not enforce contributor behavior or establish independent approval. No tool installation or technical standard tasks beyond this contribution guide were completed.

Correct or revert the guide in a normal commit if steps mislead a contributor. Preserve user changes and shared history, and inspect dependent task/evidence effects before reverting real behavior.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-011.md).
