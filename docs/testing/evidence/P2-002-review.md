# P2-002 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-001: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `5969a87c8274544aa2120d2c4b7ef8d5227e28c5`

## Scope and acceptance review

Read official scope/transitivity/management and plugin classpath-filter documentation, compared current test-scoped JUnit declaration and Boot BOM. Resolved compile/runtime/test classpaths in WSL then compiled a temporary JUnit import without and with the test classpath. No POM edits or new runtime dependencies.

## Executed check

Command: `python P2-002-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+"source scripts/wsl/environment.sh\npython3 - <<'PY'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix='kafka-lab-P2-002-') as t:\n p=Path(t);paths={}\n for scope in ('compile','runtime','test'):\n  out=p/(scope+'.cp')\n  cmd=['bash','scripts/wsl/lab.sh','mvn','-f','tools/build-verification/pom.xml','org.apache.maven.plugins:maven-dependency-plugin:3.11.0:build-classpath','-DincludeScope='+scope,'-Dmdep.outputFile='+str(out)]\n  r=subprocess.run(cmd,capture_output=True,text=True,timeout=90);assert r.returncode==0,r.stderr\n  paths[scope]=out.read_text(encoding='utf-8').strip() if out.exists() else ''\n assert paths['compile']==paths['runtime']==''\n assert 'junit-jupiter-api/6.1.3/' in paths['test']\n source=p/'UsesTestApi.java';source.write_text('import org.junit.jupiter.api.Assertions; public final class UsesTestApi { void check() { Assertions.assertTrue(true); } }',encoding='utf-8')\n bad=subprocess.run(['javac','-cp',str(p),'-d',t,str(source)],capture_output=True,text=True,timeout=20);assert bad.returncode!=0\n good=subprocess.run(['javac','-cp',paths['test'],'-d',t,str(source)],capture_output=True,text=True,timeout=20);assert good.returncode==0,good.stderr\n print('PASS: compile/runtime dependency classpaths empty; test classpath contains managed JUnit 6.1.3')\n print('PASS: JUnit import rejected without test classpath and accepted with test classpath; POM unchanged')\nPY\n")
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: compile/runtime dependency classpaths empty; test classpath contains managed JUnit 6.1.3
PASS: JUnit import rejected without test classpath and accepted with test classpath; POM unchanged
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Classpath experiment covers the existing JUnit test dependency. provided/runtime/import/system semantics are documentary review, not a simulated application server or executable Boot packaging test. Scope controls availability, not vulnerability or license approval.

Only review/index/tracker files change. Temporary WSL source/classpath files are automatically removed; Maven cache remains normal Linux dependency cache.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-002.md).
