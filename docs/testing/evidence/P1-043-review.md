# P1-043 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-042: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `1d9c6b50ffe49b067f8721b4e6a6111f4ee2c9ad`

## Scope and acceptance review

Reviewed GitHub failure() and GITHUB_STEP_SUMMARY semantics plus existing artifact order. Inline summary uses trusted run/revision environment values with quoted printf, fixed messages and no PR-title/payload interpolation. Probe will force existing tooling unit expectation to 99 on a separate branch; no intentional failure in normal task branch.

Observed negative [run](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45358937305), probe commit `7aa479418b7311c2ed132969f05cdbf5cffc112e`: unit step/job failed, report guard skipped, preparation/summary/upload succeeded. Downloaded artifact 14904040597 (920 bytes): failure-summary.md linked the correct run/revision and WSL reproduction command; sanitized Surefire XML reported 1 test, 1 failure, 0 errors/skips. Native check-run annotation was queried and matched title Lab CI failed, level failure, fixed diagnostic message. No failure text/properties/output exported.

```json
{
  "id": 45358937305,
  "head_sha": "7aa479418b7311c2ed132969f05cdbf5cffc112e",
  "status": "completed",
  "conclusion": "failure",
  "html_url": "https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45358937305",
  "event": "push",
  "jobs": [
    {
      "name": "Verify lab tooling",
      "conclusion": "failure",
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
          "name": "Verify tooling and tests",
          "conclusion": "failure"
        },
        {
          "name": "Verify discovered test reports",
          "conclusion": "skipped"
        },
        {
          "name": "Prepare sanitized test artifacts",
          "conclusion": "success"
        },
        {
          "name": "Report CI failure",
          "conclusion": "success"
        },
        {
          "name": "Publish test reports",
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
}
```

Final normal artifact inspection:

```json
{
  "run_id": 45359700576,
  "artifact_id": 14903777015,
  "name": "tooling-test-reports-45359700576-1",
  "size_in_bytes": 957,
  "created_at": "2026-11-24T08:51:23Z",
  "expires_at": "2026-12-01T08:51:21Z",
  "digest": "sha256:24b080c84823789f61614ac89476d17065855faa5be0884e91a87674d54a9ec1",
  "reports": [
    {
      "file": "failsafe-reports-TEST-io.github.ru5iru.kafkalab.buildverification.ToolchainProbeIT.xml",
      "tests": "1",
      "failures": "0",
      "errors": "0",
      "skipped": "0"
    },
    {
      "file": "surefire-reports-TEST-io.github.ru5iru.kafkalab.buildverification.ToolchainProbeTest.xml",
      "tests": "1",
      "failures": "0",
      "errors": "0",
      "skipped": "0"
    }
  ],
  "inspection": "Downloaded without forwarding GitHub authorization across hosts; inspected in memory without extracting files; no properties/output/exception text"
}
```

An auxiliary rerun of the initial normal candidate stayed queued and was not counted as passed. A subsequent bounded-diagnostic/source-navigation candidate received a fresh successful run, recorded below. No failure injection is in its ancestry.

Actual hosted candidate: `1d9c6b50ffe49b067f8721b4e6a6111f4ee2c9ad`; [GitHub Actions run](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45359700576), conclusion success. Jobs and step conclusions:

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
        "name": "Verify tooling and tests",
        "conclusion": "success"
      },
      {
        "name": "Verify discovered test reports",
        "conclusion": "success"
      },
      {
        "name": "Prepare sanitized test artifacts",
        "conclusion": "success"
      },
      {
        "name": "Report CI failure",
        "conclusion": "skipped"
      },
      {
        "name": "Publish test reports",
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

Command: `python P1-043-verify.py` from the repository root, using this exact script:

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
PASS: actual hosted candidate 1d9c6b50ffe49b067f8721b4e6a6111f4ee2c9ad completed successfully: https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45359700576
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Custom summary covers failures preceding its step; later upload failures retain GitHub native step errors. Cancellation/timeout or runner loss may prevent delivery. No third-party messages, repository write permission, secrets, SCA, branch protection or private vulnerability reporting configured. Current local Ubuntu default root and Spotless Unsafe warning remain disclosed. An auxiliary initial-candidate rerun remained queued during review; it is not used as passing evidence. The fresh final-source run succeeded and its reports were downloaded/inspected.

Revert summary/reporting changes in a new commit. Never merge the expectedJava=99 probe branch, erase failed-run history or force-push. Repair normal branch then rerun full verify.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-043.md).

## Phase closure

[Executed P1 phase review and full task index](P1-phase-review.md). All 43 P1 tasks Done; P2 not started.
