# P1-038 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-037: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `39b38854168df54067a6379f8ff9c4d1443cbd25`

## Scope and acceptance review

Resolved official checkout v7.0.1 to full commit 3d3c42e5aac5ba805825da76410c181273ba90b1; reviewed publisher README Node24, fetch depth and credential inputs. Source identity and absence of local auth extraheader are asserted by the runner without printing credentials.

Actual hosted candidate: `39b38854168df54067a6379f8ff9c4d1443cbd25`; [GitHub Actions run](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45356989233), conclusion success. Jobs and step conclusions:

```json
[
  {
    "name": "Verify lab tooling",
    "conclusion": "success",
    "steps": [
      {
        "name": "Set up job",
        "conclusion": "success"
      },
      {
        "name": "Checkout source",
        "conclusion": "success"
      },
      {
        "name": "Verify source identity",
        "conclusion": "success"
      },
      {
        "name": "Verify runner",
        "conclusion": "success"
      },
      {
        "name": "Post Checkout source",
        "conclusion": "success"
      },
      {
        "name": "Complete job",
        "conclusion": "success"
      }
    ]
  }
]
```

## Executed check

Command: `python P1-038-verify.py` from the repository root, using this exact script:

```python
import json,os,subprocess
from pathlib import Path
r=json.loads(Path(os.environ['TEMP'],'p1-ci-latest.json').read_text(encoding='utf-8'))
sha=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip()
a=next(x for x in r if x['head_sha']==sha and x['conclusion']=='success')
assert a['status']=='completed' and all(j['conclusion']=='success' for j in a['jobs'])
print('PASS: actual hosted candidate '+sha+' completed successfully: '+a['html_url'])
```

Exit code: 0. Observed output:

```text
PASS: actual hosted candidate 39b38854168df54067a6379f8ff9c4d1443cbd25 completed successfully: https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45356989233
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Checkout is shallow; history-dependent tooling must explicitly request history later. Pull requests use GitHub synthetic merge SHA by default, not necessarily the contributor head. Action pin controls source revision, not all runner software. Java setup remains next task.

Revert this checkout increment; do not replace the pin with a floating tag to bypass a failure.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-038.md).
