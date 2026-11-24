# P1-039 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-038: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `b3192020a537a7134c4168e7a733bd08c857fda1`

## Scope and acceptance review

Reviewed previously verified Oracle installer, exact SHA256 and environment launcher; same Linux artifact now installs into ephemeral hosted Ubuntu. GITHUB_ENV/PATH publish values for subsequent steps; no Windows runtime installed. Reused Java compiler positive/negative probe rather than fabricate a new service.

Actual hosted candidate: `b3192020a537a7134c4168e7a733bd08c857fda1`; [GitHub Actions run](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45357244641), conclusion success. Jobs and step conclusions:

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

Command: `python P1-039-verify.py` from the repository root, using this exact script:

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
PASS: actual hosted candidate b3192020a537a7134c4168e7a733bd08c857fda1 completed successfully: https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45357244641
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Oracle latest URL is mutable: checksum mismatch fails closed and requires reviewed update. Hosted sudo installs tools, subsequent tests run as runner user; local Ubuntu default remains root. No Maven or application tests yet. Binary checksum is integrity, not publisher-signature or vulnerability assurance.

Revert CI JDK steps; ephemeral runner disappears. Do not loosen checksum/TLS or change local default Linux user to make CI pass.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-039.md).
