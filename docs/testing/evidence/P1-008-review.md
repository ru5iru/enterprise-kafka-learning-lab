# P1-008 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-007: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `cde347ef8e8a88d228808baf05b9b1cf2be00485`

## Scope and acceptance review

Reviewed recognized Markdown template front matter, corrected the existing description key to about, and separated planned roadmap work from observed defects. Chose simple editable Markdown and a config.yml chooser. Self-review corrected repository-relative body links to explicit main URLs because copied issue text has a different rendering context; the earlier static link gate alone was insufficient. Synthetic walkthrough: a task needs dependency/acceptance/evidence; a bug needs expected versus actual; a sensitive finding must follow policy. No issues were submitted.

## Executed check

Command: `python P1-008-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import re
folder=Path('.github/ISSUE_TEMPLATE');names=[]
for name in ['task.md','bug.md']:
    text=(folder/name).read_text(encoding='utf-8');parts=text.split('---',2)
    assert len(parts)==3 and parts[0]==''
    pairs=dict(line.split(':',1) for line in parts[1].strip().splitlines())
    assert set(pairs)=={'name','about','title','labels','assignees'}
    assert len(pairs['name'].strip())>3 and pairs['about'].strip()
    assert pairs['labels'].strip()==pairs['assignees'].strip()=='[]'
    assert 'description' not in pairs and 'SECURITY.md' in text
    for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)',text):assert target.startswith('https://github.com/ru5iru/enterprise-kafka-learning-lab/'),target
    names.append(pairs['name'].strip())
assert len(set(names))==2
config=(folder/'config.yml').read_text(encoding='utf-8')
assert config.startswith('blank_issues_enabled: false\ncontact_links:\n')
assert 'https://github.com/ru5iru/enterprise-kafka-learning-lab/security/policy' in config
assert '\t' not in config and 'assignees:' not in config
for phrase in ['Dependencies and current CSV status','Exact acceptance criteria','Negative/failure case','rollback']:
    assert phrase in (folder/'task.md').read_text(encoding='utf-8')
for phrase in ['Expected result','Actual result','unknown (do not invent one)','synthetic data']:
    assert phrase in (folder/'bug.md').read_text(encoding='utf-8')
print('PASS: 2 distinct Markdown template metadata blocks, empty automatic labels/assignees, chooser shape/security route and safe task/defect prompts')
```

Exit code: 0. Observed output:

```text
PASS: 2 distinct Markdown template metadata blocks, empty automatic labels/assignees, chooser shape/security route and safe task/defect prompts
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Static checks validate the deliberately simple metadata/config shape, not a general YAML schema or GitHub UI. Templates/chooser become active after merge to the default branch. Blank-issue disabling is chooser guidance; maintainers/API can still bypass it. Markdown does not enforce completed fields and no labels, assignees or notifications are created.

Revert the template/config commit or restore the previous chooser in a new commit if GitHub does not discover them. Keep the private-reporting warning and do not create public trial vulnerability issues.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-008.md).
