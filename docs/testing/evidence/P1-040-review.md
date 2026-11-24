# P1-040 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-039: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `81c9983ced3d639d3e5f23d14b50180ac3d60b0d`

## Scope and acceptance review

Reviewed existing SHA512-pinned Maven installer and root/child lifecycle, Central mirror and strict checksum config. CI runs native Linux scripts via lab.sh from repository root; package compiles test sources but explicitly skips JUnit execution for the next task. No dependency cache added, so hosted resolution verifies clean inputs.

Actual hosted candidate: `81c9983ced3d639d3e5f23d14b50180ac3d60b0d`; [GitHub Actions run](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45357494055), conclusion success. Jobs and step conclusions:

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
        "name": "Install pinned JDK",
        "conclusion": "success"
      },
      {
        "name": "Verify Java compiler and rejection paths",
        "conclusion": "success"
      },
      {
        "name": "Install pinned Maven",
        "conclusion": "success"
      },
      {
        "name": "Build tooling module",
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

Command: `python P1-040-verify.py` from the repository root, using this exact script:

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
PASS: actual hosted candidate 81c9983ced3d639d3e5f23d14b50180ac3d60b0d completed successfully: https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45357494055
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

JUnit deliberately skipped by -DskipTests in this increment; package success is not unit/integration test success. Network availability and pinned download URL remain dependencies. No broker/database or application packaged. No SCA or reproducible binary guarantee.

Revert Maven workflow steps; existing local WSL tools/build stay available. Resolve download problems without disabling checksum/TLS.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-040.md).
