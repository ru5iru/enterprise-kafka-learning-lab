# P1-037 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-036: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `7768af3cd4812eca8a2c1e4aee092e86ac0b9e19`

## Scope and acceptance review

Reviewed official workflow event, permissions, concurrency and timeout semantics. Minimal runner-only job intentionally precedes checkout/JDK/Maven tasks; no application CI claimed.

Actual hosted candidate: `7768af3cd4812eca8a2c1e4aee092e86ac0b9e19`; [GitHub Actions run](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45356685600), conclusion success. Jobs and step conclusions:

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
        "name": "Verify runner",
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

Command: `python P1-037-verify.py` from the repository root, using this exact script:

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
PASS: actual hosted candidate 7768af3cd4812eca8a2c1e4aee092e86ac0b9e19 completed successfully: https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45356685600
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Runner smoke check only at this task. GitHub-hosted Ubuntu image is maintained externally, not immutable. No checkout, build or tests exist in this initial increment. Push paths deliberately omit documentation-only completion changes; PR trigger is unfiltered. Checks are not configured as branch protection.

Disable/revert this workflow in a normal reviewed commit; preserve task evidence. No infrastructure or secrets provisioned.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-037.md).
