# P1 phase gate — repository, WSL environment and CI

Reviewed 2026-11-24 in P1-043. Author/agent self-review; no independent approval claimed. The CSV records **43/43 P1 Done**, **45/45 P0 Done** and **638 later tasks Not Started**. P2 was not executed. Historical 15-phase Markdown checklists remain unchanged.

## Delivered and verified

Develop in the existing Windows checkout; execute Java/Maven/containers/CLI tools in Ubuntu WSL. Windows Git publishes sequential task branches. No second checkout or Windows runtime dependency installation was introduced. Existing Windows VS Code is configured with versioned WSL terminal/tasks; interactive indexing/debugging was not verified.

Actual final WSL inventory (`source scripts/wsl/environment.sh`, version commands and `systemctl is-active docker`): Oracle Java 25.0.5.1+4-LTS-20, Maven 3.10.2, Git 2.43.0, Kafka CLI 4.4.0, psql 16.15, google-java-format 2.0.0, Docker 29.1.3, Compose 2.40.3, Docker daemon active. Linux UID is **0**: local Ubuntu defaults to root, and no user/default/group setting was changed. Prior task notes contain installation checksums, package versions and positive/negative CLI/container evidence.

The tooling-only Maven module exercises compiler release/lint, dependency convergence, aligned AOSP formatting, Checkstyle, one JUnit unit test and one packaged-JAR integration test. Actual WSL `bash scripts/wsl/lab.sh mvn clean verify` plus `python3 scripts/ci/verify-test-reports.py` passed with 1+1 tests, zero failures/errors/skips. Negative compiler, formatter, broad-catch, missing/failed-test and report-sanitization experiments are recorded in their owning tasks. No Java application, broker, database server, Compose lab stack or Kubernetes deployment exists.

Hosted final normal source `1d9c6b50ffe49b067f8721b4e6a6111f4ee2c9ad` [passed full CI](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45359700576). Downloaded artifact 14903777015: exactly two sanitized XML reports with 1 test each and zero failures/errors/skips. Full-commit-pinned actions, checksum-pinned Linux tools, contents-read token, no secrets, checkout credential opt-out, strict-checksum HTTPS Central resolution, bounded job/diagnostic execution and seven-day narrow artifacts are implemented.

Isolated probe `7aa479418b7311c2ed132969f05cdbf5cffc112e` [failed as intended](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45358937305). The unit expectation 99 caused 1 unit failure; job remained failed, summary/annotation/upload succeeded. Downloaded artifact 14904040597 contained the correct run/revision/reproduction summary and sanitized failing XML. The probe is not an ancestor of the normal branch and must not be merged. A separate auxiliary rerun stayed queued and was not counted as passed; the fresh final-source run above supplies actual positive evidence.

## Integrity audit

Executed `python p1_phase_audit.py --complete` from repository root with the exact script below. It checked the completed working tree before the final documentation commit; publication subsequently checks staged scope, whitespace, credential patterns and the pushed remote tip.

```python
﻿import csv,io,re,subprocess,json,os
from pathlib import Path
from collections import Counter
base='67d051047d3d6d3904c20f3c5b99338ef84c989a';ledger='docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv'
def rows(b):return list(csv.reader(io.StringIO(b.decode('utf-8-sig'),newline='')))
a=rows(subprocess.check_output(['git','show',base+':'+ledger]));b=rows(Path(ledger).read_bytes());assert len(a)==len(b)==727 and a[0]==b[0] and len(b[0])==20
assert [r[0] for r in a]==[r[0] for r in b] and len({r[1] for r in b[1:]})==15
pending='--complete' not in __import__('sys').argv
for old,new in zip(a[1:],b[1:]):
 if new[1]=='P1' and int(new[0][-3:])>=13:
  assert all(old[j]==new[j] for j in range(20) if j not in [7,12,16,17])
 else:assert old==new
p1=[r for r in b[1:] if r[1]=='P1'];assert len(p1)==43
assert all(r[7]=='Done' for r in p1[:-1]);assert p1[-1][7]==('In Progress' if pending else 'Done')
for r in p1:
 task=r[0];n=Path('docs/learning-notes/P1/'+task+'.md');e=Path('docs/testing/evidence/'+task+'-review.md')
 assert n.exists() and e.exists();assert len(re.findall(r'^## [0-9]+[.] ',n.read_text(encoding='utf-8'),re.M))==11
 for p in [n,e]:
  s=re.sub(r'```.*?```','',p.read_text(encoding='utf-8'),flags=re.S)
  for link in re.findall(r'\[[^\]]+\]\(([^)]+)\)',s):
   if link.startswith(('https://','http://','#','mailto:')):continue
   assert(p.parent/link.split('#')[0]).exists(),(p,link)
assert not subprocess.check_output(['git','diff',base,'--name-only','--','docs/roadmap/phases','docs/roadmap/ROADMAP.md']).strip()
w=Path('.github/workflows/ci.yml').read_text(encoding='utf-8');assert '-Dprobe.expectedJava=99' not in w and 'continue-on-error' not in w
assert subprocess.run(['git','merge-base','--is-ancestor','test/P1-043-ci-failure-probe','HEAD']).returncode==1
remote=dict(line.split()[::-1] for line in subprocess.check_output(['git','ls-remote','--heads','origin'],text=True).splitlines())
branches=subprocess.check_output(['git','for-each-ref','--format=%(refname:short) %(objectname)','refs/heads'],text=True).splitlines();count=0
for line in branches:
 name,sha=line.split();m=re.search(r'/P1-(\d{3})-',name)
 if m and 13<=int(m.group(1))<=43:
  assert remote['refs/heads/'+name]==sha;count+=1
assert count==32,count
subprocess.run(['git','diff','--check'],check=True)
print('PASS: 726 stable IDs/order, 15 phases, CSV schema and all unrelated/P2+ rows preserved')
print('PASS: '+('42 P1 Done; final P1-043 pending hosted verification' if pending else '43/43 P1 Done; 45/45 P0 Done; P2 not started'))
print('PASS: all 43 P1 notes have 11 sections, evidence files and valid local links')
print('PASS: historical roadmap/phase files unchanged; no injected failure or bypass in normal workflow')
print('PASS: 31 sequential task branches plus isolated probe match remote tips; probe is not ancestor of normal branch')

```

Exit 0, observed:

```text
PASS: 726 stable IDs/order, 15 phases, CSV schema and all unrelated/P2+ rows preserved
PASS: 43/43 P1 Done; 45/45 P0 Done; P2 not started
PASS: all 43 P1 notes have 11 sections, evidence files and valid local links
PASS: historical roadmap/phase files unchanged; no injected failure or bypass in normal workflow
PASS: 31 sequential task branches plus isolated probe match remote tips; probe is not ancestor of normal branch
```

Each P1-013 through P1-042 completion was committed/pushed and tip-verified before the next task began. CI tasks required an In Progress candidate push followed by actual hosted verification and a completion commit. P1-043 has additional isolated failure and bounded-diagnostic candidates, all scoped to the same task. Main baseline for this sequence is `67d051047d3d6d3904c20f3c5b99338ef84c989a`; branches are stacked without rewriting shared history. This review authorizes no automatic merge.

## Residual limits and deferred controls

- Local WSL defaults to root. Docker is rootful with Unix socket; no Docker-group or world-writable socket grant was introduced. Use ordinary-user development when account setup is deliberately addressed.
- Spotless emits JDK Unsafe deprecation warning; gates pass, but future JDK/library upgrades need review. Kafka/PostgreSQL CLIs are installed without running their servers.
- Existing unrelated APT update/list-lock was not killed or removed; Docker installer used isolated signed lists with normal package locks. Apache download TLS issues locally used verified Windows transport plus WSL hash checking, never disabled TLS.
- Private vulnerability reporting remains disabled, with no dedicated contact; SECURITY.md fallback remains. Main branch protection, independent review, SCA/SBOM, production TLS/SASL/ACLs, service testing, scale/recovery and deployment remain outside P1 implementation.
- Hosted runner images are maintained externally. Hashes/action pins are not a blanket vulnerability guarantee. Reports omit properties/output/exception text; names/types and console logs still need review. Artifacts expire after seven days; committed summaries retain durable provenance.
- Custom failure summary precedes upload, so later upload errors use native step reporting. Cancellation/runner loss can prevent diagnostics. No external messages or production credentials were used.

## Task records

| Task | Work | Learning | Evidence |
|---|---|---|---|
| P1-001 | Create GitHub repository | [Note](../../learning-notes/P1/P1-001.md) | [Review](P1-001-review.md) |
| P1-002 | Write README | [Note](../../learning-notes/P1/P1-002.md) | [Review](P1-002-review.md) |
| P1-003 | Configure .gitignore | [Note](../../learning-notes/P1/P1-003.md) | [Review](P1-003-review.md) |
| P1-004 | Configure .editorconfig | [Note](../../learning-notes/P1/P1-004.md) | [Review](P1-004-review.md) |
| P1-005 | Define branch naming | [Note](../../learning-notes/P1/P1-005.md) | [Review](P1-005-review.md) |
| P1-006 | Define Conventional Commits | [Note](../../learning-notes/P1/P1-006.md) | [Review](P1-006-review.md) |
| P1-007 | Define PR review rules | [Note](../../learning-notes/P1/P1-007.md) | [Review](P1-007-review.md) |
| P1-008 | Create issue templates | [Note](../../learning-notes/P1/P1-008.md) | [Review](P1-008-review.md) |
| P1-009 | Create PR template | [Note](../../learning-notes/P1/P1-009.md) | [Review](P1-009-review.md) |
| P1-010 | Create SECURITY.md | [Note](../../learning-notes/P1/P1-010.md) | [Review](P1-010-review.md) |
| P1-011 | Create CONTRIBUTING.md | [Note](../../learning-notes/P1/P1-011.md) | [Review](P1-011-review.md) |
| P1-012 | Create documentation tree | [Note](../../learning-notes/P1/P1-012.md) | [Review](P1-012-review.md) |
| P1-013 | Install JDK | [Note](../../learning-notes/P1/P1-013.md) | [Review](P1-013-review.md) |
| P1-014 | Configure JAVA_HOME | [Note](../../learning-notes/P1/P1-014.md) | [Review](P1-014-review.md) |
| P1-015 | Verify Java compiler | [Note](../../learning-notes/P1/P1-015.md) | [Review](P1-015-review.md) |
| P1-016 | Install Maven | [Note](../../learning-notes/P1/P1-016.md) | [Review](P1-016-review.md) |
| P1-017 | Verify Maven | [Note](../../learning-notes/P1/P1-017.md) | [Review](P1-017-review.md) |
| P1-018 | Install Docker | [Note](../../learning-notes/P1/P1-018.md) | [Review](P1-018-review.md) |
| P1-019 | Verify Docker Compose | [Note](../../learning-notes/P1/P1-019.md) | [Review](P1-019-review.md) |
| P1-020 | Run test container | [Note](../../learning-notes/P1/P1-020.md) | [Review](P1-020-review.md) |
| P1-021 | Install Git | [Note](../../learning-notes/P1/P1-021.md) | [Review](P1-021-review.md) |
| P1-022 | Configure IDE | [Note](../../learning-notes/P1/P1-022.md) | [Review](P1-022-review.md) |
| P1-023 | Configure Java formatter | [Note](../../learning-notes/P1/P1-023.md) | [Review](P1-023-review.md) |
| P1-024 | Configure static inspections | [Note](../../learning-notes/P1/P1-024.md) | [Review](P1-024-review.md) |
| P1-025 | Install Kafka CLI | [Note](../../learning-notes/P1/P1-025.md) | [Review](P1-025-review.md) |
| P1-026 | Verify PostgreSQL CLI | [Note](../../learning-notes/P1/P1-026.md) | [Review](P1-026-review.md) |
| P1-027 | Define package naming | [Note](../../learning-notes/P1/P1-027.md) | [Review](P1-027-review.md) |
| P1-028 | Define class naming | [Note](../../learning-notes/P1/P1-028.md) | [Review](P1-028-review.md) |
| P1-029 | Define exception handling standards | [Note](../../learning-notes/P1/P1-029.md) | [Review](P1-029-review.md) |
| P1-030 | Define logging standards | [Note](../../learning-notes/P1/P1-030.md) | [Review](P1-030-review.md) |
| P1-031 | Define configuration conventions | [Note](../../learning-notes/P1/P1-031.md) | [Review](P1-031-review.md) |
| P1-032 | Define Maven dependency management | [Note](../../learning-notes/P1/P1-032.md) | [Review](P1-032-review.md) |
| P1-033 | Configure compiler plugin | [Note](../../learning-notes/P1/P1-033.md) | [Review](P1-033-review.md) |
| P1-034 | Configure test plugins | [Note](../../learning-notes/P1/P1-034.md) | [Review](P1-034-review.md) |
| P1-035 | Configure formatter and static analysis | [Note](../../learning-notes/P1/P1-035.md) | [Review](P1-035-review.md) |
| P1-036 | Define review checklist | [Note](../../learning-notes/P1/P1-036.md) | [Review](P1-036-review.md) |
| P1-037 | Create GitHub Actions workflow | [Note](../../learning-notes/P1/P1-037.md) | [Review](P1-037-review.md) |
| P1-038 | Configure checkout step | [Note](../../learning-notes/P1/P1-038.md) | [Review](P1-038-review.md) |
| P1-039 | Configure JDK setup | [Note](../../learning-notes/P1/P1-039.md) | [Review](P1-039-review.md) |
| P1-040 | Configure Maven build | [Note](../../learning-notes/P1/P1-040.md) | [Review](P1-040-review.md) |
| P1-041 | Run unit tests in CI | [Note](../../learning-notes/P1/P1-041.md) | [Review](P1-041-review.md) |
| P1-042 | Publish CI test artifacts | [Note](../../learning-notes/P1/P1-042.md) | [Review](P1-042-review.md) |
| P1-043 | Configure CI failure reporting | [Note](../../learning-notes/P1/P1-043.md) | [Review](P1-043-review.md) |

## Handoff

P1 phase acceptance is met by actual repository standards, repeatable WSL setup, positive/negative tooling checks and passing hosted CI. See [CI guide](../../development/continuous-integration.md), [WSL setup](../../development/wsl-setup.md), [review checklist](../../development/review-checklist.md) and [ADR-0014](../../architecture/decisions/0014-ci-trust-and-evidence.md). Next task **P2-001** is suggested only. Stop before P2; merge only when requested.
