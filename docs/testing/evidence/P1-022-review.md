# P1-022 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-021: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `a6b524da3ead8fdc7cc25814cf6c015dbdddb417`

## Scope and acceptance review

Verified existing VS Code CLI version 1.107.1, reviewed official process-task guidance and created a tracked workspace file. Executed both Windows task argument vectors after resolving the workspace variable; each selected the Linux toolchain successfully. No GUI/editor window was opened and no Windows dependency or extension was installed.

## Executed check

Command: `python P1-022-verify.py` from the repository root, using this exact script:

```python
import json,subprocess
from pathlib import Path
p=Path('enterprise-kafka-learning-lab.code-workspace');cfg=json.loads(p.read_text(encoding='utf-8'))
assert cfg['folders']==[{'path':'.'}] and cfg['tasks']['version']=='2.0.0'
assert cfg['settings']['terminal.integrated.defaultProfile.windows']=='Ubuntu (WSL)'
for task in cfg['tasks']['tasks']:
 assert task['type']=='process' and 'runOptions' not in task
 command=task['windows']['command'];args=[arg.replace('${workspaceFolder}',str(Path.cwd())) for arg in task['windows']['args']]
 r=subprocess.run([command,*args],capture_output=True)
 out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
 if 'Java' in task['label']:assert '25.0.5.1' in out
 else:assert 'Apache Maven 3.10.2' in out and 'OS name: "linux"' in out
 print('PASS: '+task['label']+' process task executed in Ubuntu')
assert not Path('.vscode/tasks.json').exists()
print('PASS: tracked workspace JSON, explicit process args, no automatic tasks/global editor edits')
```

Exit code: 0. Observed output:

```text
PASS: WSL: Java version process task executed in Ubuntu
PASS: WSL: Maven version process task executed in Ubuntu
PASS: tracked workspace JSON, explicit process args, no automatic tasks/global editor edits
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

This configures project task/terminal integration, not Java language-server/debugger behavior or a runnable app. UI selection and editor indexing were not exercised. The existing editor version was adopted, not upgraded or claimed latest. Rootful Docker permissions remain separate.

Close/correct the optional workspace; no global user preferences or personal .vscode files were changed. Do not relax workspace trust or daemon permissions to repair a task.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-022.md).
