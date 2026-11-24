# P1-042 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-041: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `5130273b031cfcb70f70e41459be9a0be61ee003`

## Scope and acceptance review

Publisher v7.0.2 reviewed and pinned to cf430e030ddbb5b0abf93d22962f4752f3646cd9. WSL prepared two actual reports; synthetic properties/output/failure payload removed while retaining failure count/type; missing reports produce zero files. Exact local driver:

```python
import importlib.util,tempfile,xml.etree.ElementTree as ET
from pathlib import Path
spec=importlib.util.spec_from_file_location('artifacts','scripts/ci/prepare-test-artifacts.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
assert m.prepare(Path('tools/build-verification/target'))==2
with tempfile.TemporaryDirectory(prefix='p1-042-') as t:
 root=Path(t);assert m.prepare(root)==0
 d=root/'surefire-reports';d.mkdir()
 (d/'TEST-probe.xml').write_text('<testsuite name="synthetic" tests="1" failures="1" errors="0" skipped="0"><properties><property name="credential" value="synthetic-sensitive-marker"/></properties><testcase name="probe" classname="Tooling"><failure type="AssertionError" message="synthetic-sensitive-marker">synthetic-sensitive-marker</failure><system-out>synthetic-sensitive-marker</system-out></testcase><system-err>synthetic-sensitive-marker</system-err></testsuite>',encoding='utf-8')
 assert m.prepare(root)==1
 p=root/'ci-reports/surefire-reports-TEST-probe.xml';text=p.read_text(encoding='utf-8')
 assert 'synthetic-sensitive-marker' not in text and 'properties' not in text and 'system-out' not in text
 r=ET.fromstring(text);assert r.attrib['failures']=='1' and r.find('testcase/failure').attrib['type']=='AssertionError'
 print('PASS: synthetic sensitive payload removed; failure count/type retained; missing reports yield zero files')

```

Actual hosted artifact download and in-memory inspection:

```json
{
  "run_id": 45358353463,
  "artifact_id": 14902584393,
  "name": "tooling-test-reports-45358353463-1",
  "size_in_bytes": 957,
  "created_at": "2026-11-24T08:42:08Z",
  "expires_at": "2026-12-01T08:42:06Z",
  "digest": "sha256:855ea0f5e053630c6dc90d31bfa2531e7e86687f9189c7e267709cd12499bd74",
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

Actual hosted candidate: `5130273b031cfcb70f70e41459be9a0be61ee003`; [GitHub Actions run](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45358353463), conclusion success. Jobs and step conclusions:

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

Command: `python P1-042-verify.py` from the repository root, using this exact script:

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
PASS: actual hosted candidate 5130273b031cfcb70f70e41459be9a0be61ee003 completed successfully: https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45358353463
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Sanitization removes JVM properties, stdout/stderr and exception text, but test names/class names and failure types still require source review; it is not a general DLP guarantee. Missing artifacts after early setup failure warn rather than obscure the original failure. Full console logs remain subject to no-sensitive-logging policy. Seven-day artifact retention is not permanent evidence.

Revert upload/preparation steps; expiring hosted artifacts follow repository retention. Do not broaden upload path to workspace or Maven cache to debug failures.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-042.md).
