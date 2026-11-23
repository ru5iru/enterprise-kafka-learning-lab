# P0-002 — learning objectives review evidence

**Date:** 2026-11-23 (Asia/Colombo)  
**Reviewer:** Executing coding agent; documented self-review, no independent peer approval.  
**Artifact:** [Learning objectives](../../requirements/learning-objectives.md)  
**Task note:** [P0-002](../../learning-notes/P0/P0-002.md)  
**Pre-task commit:** `db47b8c04c6dc9ede12443a065c98502f4bbca9c`  
**Environment:** Repository-root PowerShell (`login: false`), Python 3.13.14, Git. Initial working tree clean; existing branch `docs/P0-002-define-learning-objectives`.

## Task and semantic self-review

Read the exact P0-002 CSV row: High priority, depends on P0-001; document concept/decision, rationale, and implications; peer/self-review against phase objectives. P0-001 is Done, and its charter, note, and evidence exist and were reviewed. Compare the new catalogue to those six charter objectives, the P0 phase, master roadmap and phase objectives, architecture, security/SSDLC baseline, and Definition of Done. This task defines a learning plan, so the reviewed evidence is documentary rather than runtime output.

| Review question / scenario | Expected | Observed assessment | Result |
|---|---|---|---|
| Alignment with completed P0-001 | Every LO supports a project goal; all six goals have coverage. | Thirteen LOs map to OBJ-01–OBJ-06 with phase evidence locations; charter is unchanged. | Pass |
| Required objective dimensions | Knowledge, practical skills, concepts, experiments, verification, proficiency for every major objective. | All thirteen detailed entries include six distinct fields; knowledge and practical skills are separately expressed. | Pass |
| Concrete future assessment | Observable actions and positive/negative evidence rather than “understand X.” | Experiments specify normal and fault/rejection cases; verification names observations, artifacts, and explanations. | Pass |
| Meaningful proficiency | Explain independent application and diagnosis with cumulative evidence requirements. | L1/L2/L3 rubric defines behavior and evidence; each LO states its target level and phase endpoint. | Pass |
| Roadmap progression | Native before Spring; Compose before Kubernetes; progressive security; no premature implementation. | These sequences are explicit; experiments are assigned to existing phases and left unexecuted. LO IDs are not new task IDs. | Pass |
| Negative claim: task completion implies mastery | Separate planning completion from learner assessment. | All proficiency remains not assessed; assessment outcomes are recorded later with task evidence. | Pass |
| Negative claim: “exactly once” covers all side effects | Differentiate Kafka transaction scope, application effects, and cross-system persistence. | LO-05 and LO-07 require explicit transaction/replay boundaries and evidence accounting. | Pass |
| Negative claim: 100,000 users proves capacity | Hypothesis, with workload and measured results pending. | LO-10 requires model inputs, units, environment, sustained observations, and limits; no numeric targets assigned. | Pass |
| Safe experimental learning | Synthetic data, isolated lab resources, bounded disruption/load/replay, redacted evidence, no weakened verification. | Experiment discipline plus LO-08 and LO-13 retain these restrictions and deferred control milestones. | Pass |
| Scope and architecture | P0-002 only; no changed architecture or early requirements/scope deliverable. | Three documentation artifacts and one tracker row; no P0-003 work, versions, ADR, diagram, code, or deployment change. | Pass |
| Security review of actual changes | No operational secrets, real user data, exposed endpoint, new dependency, or unsafe configuration. | Manual review of new documents and task diff found no such additions. Sensitive fixture data is prohibited. | Pass |

Semantic self-review includes the specificity and plausibility of each experiment and its verification, not just field presence. The structural checks below cannot establish teaching quality or learner proficiency. The full phase-P0 charter/requirements/diagrams/STRIDE/ADRs and phase approval remain pending.

## Reproducible checks

The fixed commit permits comparison to the actual pre-task state. The CSV's committed blob uses LF and its initial clean Windows checkout uses CRLF with a UTF-8 BOM (727 CRLF; zero bare LF); compare untouched line bytes after newline normalization and separately check the working-copy encoding/endings. The scope assertion expects these task changes still to be uncommitted. Local link checks cover file targets, not rendering or every fragment.

From the repository root, run the Python block in this file and the Git checks:

```powershell
@'
from pathlib import Path
import re
record = Path('docs/testing/evidence/P0-002-review.md').read_text(encoding='utf-8')
script = re.search(r'```python\n(.*?)\n```', record, re.S).group(1)
exec(compile(script, 'P0-002-review-checks', 'exec'))
'@ | python -
git diff --check
git diff --stat
git status --short
```

```python
import copy
import csv
import io
import re
import subprocess
from pathlib import Path

baseline = 'db47b8c04c6dc9ede12443a065c98502f4bbca9c'
ledger = 'docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv'
evidence = 'docs/testing/evidence/P0-002-review.md'
docs = [Path('docs/requirements/learning-objectives.md'),
        Path('docs/learning-notes/P0/P0-002.md'), Path(evidence)]
original = subprocess.check_output(['git', 'show', f'{baseline}:{ledger}'])
current = Path(ledger).read_bytes()
parse = lambda b: list(csv.reader(io.StringIO(b.decode('utf-8-sig'), newline='')))
old, new = parse(original), parse(current)
header = old[0]
index = next(i for i, row in enumerate(old) if row[0] == 'P0-002')
expected = {'Status': 'Done', 'Completed_Date': '2026-11-23',
            'Notes': 'Learning objectives self-reviewed against P0-001; proficiency not yet assessed.',
            'Evidence_Link': evidence}

def check_ledger(rows):
    assert rows[0] == header and len(header) == 18, 'Header changed'
    assert len(rows) == 727 and all(len(r) == 18 for r in rows), 'CSV dimensions'
    assert [r[0] for r in rows[1:]] == [r[0] for r in old[1:]], 'Task IDs/order'
    assert len({r[0] for r in rows[1:]}) == 726, 'Duplicate task'
    assert len({r[1] for r in rows[1:]}) == 15, 'Phase count'
    assert all(r == old[i] for i, r in enumerate(rows) if i != index), 'Unrelated task changed'
    changes = {header[j]: value for j, value in enumerate(rows[index]) if value != old[index][j]}
    assert changes == expected, 'Unexpected tracking fields'
    target = dict(zip(header, rows[index]))
    prerequisite = dict(zip(header, next(r for r in rows[1:] if r[0] == 'P0-001')))
    assert target['Depends_On'] == 'P0-001' and prerequisite['Status'] == 'Done', 'Dependency'

check_ledger(new)
assert current.startswith(b'\xef\xbb\xbf') and original.startswith(b'\xef\xbb\xbf'), 'BOM'
assert current.count(b'\r\n') == current.count(b'\n') == 727, 'CRLF'
before = original.replace(b'\r\n', b'\n').splitlines(keepends=True)
after = current.replace(b'\r\n', b'\n').splitlines(keepends=True)
assert all(line == before[i] for i, line in enumerate(after) if i != index), 'Unrelated line bytes'
print('PASS: 726 tasks / 18 columns / 15 phases; only four P0-002 tracking fields changed')
print('PASS: prerequisite Done; all unrelated rows, IDs/order, dependencies, BOM/CRLF preserved')

catalogue = docs[0].read_text(encoding='utf-8')
charter = Path('docs/requirements/project-charter.md').read_text(encoding='utf-8')
goals = set(re.findall(r'\| (OBJ-\d{2}) \|', charter))
entries = re.findall(r'^\| (LO-\d{2}) \|[^\n]+$', catalogue, re.M)
expected_ids = [f'LO-{i:02}' for i in range(1, 14)]
fields = ['Knowledge', 'Practical skills', 'Concepts', 'Planned experiments',
          'Learning verification', 'Expected proficiency']

def check_objectives(text):
    blocks = re.split(r'^### (LO-\d{2})[^\n]*\n', text, flags=re.M)
    assert blocks[1::2] == expected_ids, 'Objective IDs/order'
    for block in blocks[2::2]:
        for field in fields:
            assert re.search(rf'^- \*\*{field}:\*\* \S.+', block, re.M), 'Missing objective field'
        assert re.search(r'Expected proficiency:\*\* L[123]\b', block), 'Missing proficiency'

check_objectives(catalogue)
assert entries == expected_ids, 'Alignment catalogue IDs'
table = catalogue.split('## Alignment with project objectives')[1].split('## Detailed objectives')[0]
covered = set(re.findall(r'OBJ-\d{2}', table))
assert covered == goals and len(goals) == 6, 'Project objective coverage'
for line in table.splitlines():
    if line.startswith('| LO-'):
        cells = [s.strip() for s in line.strip('|').split('|')]
        assert len(cells) == 5 and re.search(r'OBJ-\d{2}', cells[2]), 'Missing alignment'
        assert re.search(r'P\d+', cells[3]) and cells[4] in {'L1', 'L2', 'L3'}, 'Phase/level'
print('PASS: 13 complete learning objectives, six charter goals covered, phase/level mapping present')

links = 0
for document in docs:
    data = document.read_bytes()
    text = data.decode('utf-8')
    assert not data.startswith(b'\xef\xbb\xbf') and b'\r' not in data and data.endswith(b'\n'), 'Markdown encoding'
    for target in re.findall(r'\[[^\]]+\]\(([^)]+)\)', text):
        if not target.startswith(('https://', 'http://', '#')):
            assert (document.parent / target.split('#')[0]).is_file(), 'Missing local target'
            links += 1
assert Path(evidence).is_file(), 'Missing CSV evidence'
template = Path('docs/learning-notes/TEMPLATE.md').read_text(encoding='utf-8')
sections = re.findall(r'^## \d+\. .+$', template, re.M)
assert len(sections) == 11 and all(s in docs[1].read_text(encoding='utf-8') for s in sections), 'Learning sections'
print(f'PASS: {links} local links resolve; all 11 learning-note sections and evidence target present')

bad_rows = copy.deepcopy(new)
bad_rows[next(i for i, row in enumerate(bad_rows) if row[0] == 'P0-003')][header.index('Status')] = 'Done'
try:
    check_ledger(bad_rows)
except AssertionError as error:
    assert str(error) == 'Unrelated task changed'
else:
    raise AssertionError('Unrelated task mutation missed')
try:
    check_objectives(catalogue.replace('**Learning verification:**', '**Omitted field:**', 1))
except AssertionError as error:
    assert str(error) == 'Missing objective field'
else:
    raise AssertionError('Missing verification field missed')
print('PASS: unrelated-task and missing-verification negative fixtures rejected without writes')

status = subprocess.check_output(['git', 'status', '--porcelain', '--untracked-files=all'], text=True)
assert {line[3:] for line in status.splitlines()} == {ledger, *(p.as_posix() for p in docs)}, 'Changed-file scope'
print('PASS: working tree limited to the four P0-002 files; P0-001 documents unchanged')
```

## Observed command results

Before updating the ledger, the document-only portion of the Python block was executed by extracting the portion from `catalogue =` to `bad_rows =`, with `Path`, `re`, `docs`, and `evidence` initialized as in the full block. It passed the objective, coverage, local-link, and template-section checks. An additional per-entry summary confirmed LO-01/LO-03/LO-06 target L2 and the remaining ten target L3. The semantic review above supplies the actual judgment of content quality.

After the P0-002-only ledger edit, the full Python block executed with exit 0. Captured output:

```text
PASS: 726 tasks / 18 columns / 15 phases; only four P0-002 tracking fields changed
PASS: prerequisite Done; all unrelated rows, IDs/order, dependencies, BOM/CRLF preserved
PASS: 13 complete learning objectives, six charter goals covered, phase/level mapping present
PASS: 32 local links resolve; all 11 learning-note sections and evidence target present
PASS: unrelated-task and missing-verification negative fixtures rejected without writes
PASS: working tree limited to the four P0-002 files; P0-001 documents unchanged
```

`git diff --check` executed separately with exit 0 and no output. `git diff --stat` reported one tracked file with one insertion and one deletion (the replaced CSV row). `git status --short` additionally identified the three new documentation files:

```text
 M docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv
?? docs/learning-notes/P0/P0-002.md
?? docs/requirements/learning-objectives.md
?? docs/testing/evidence/P0-002-review.md
```

`git diff -- docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv` was inspected and showed only P0-002 changing from Not Started to Done, with completion date 2026-11-23, the proficiency-not-assessed note, and this evidence pointer. P0-001 remained Done and P0-003 remained Not Started. Owner and effort fields were left blank; no values were invented. No Git mutation (branch creation, staging, commit, push, or merge) was performed.

## Verification limits

Negative fixtures exist only in memory and make no repository writes. These are document/ledger failure checks, not executed Kafka, security, schema, Kubernetes, load, or pipeline experiments. No learner proficiency was measured. No automated secret/dependency/vulnerability scanner ran; the actual documentation changes received manual security review. Official pages were opened separately for conceptual study; no runtime version was selected. Independent peer assessment, detailed scope, and full phase approval remain future work.
