# P1-035 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-034: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `5f03b81b34ce33532506270052792eaf9d71c6d9`

## Scope and acceptance review

Initial quality build failed with actual CLI/Spotless import-order differences. Official adapter documentation identified explicit AOSP reorderImports=true; corrected build passed. That run exposed an expired-certificate jvnet metadata attempt inherited through a plugin; project-scoped mirror settings route all remote IDs to HTTPS Central without weakening TLS. The quality-gate script then observed formatter drift and IllegalCatch rejection, removed only its own fixture and restored full verify without transfer warnings. The final verifier executes the new editor task vector and inspects actual quality/report outcomes. WSL default UID 0 was explicitly observed.

## Executed check

Command: `python P1-035-verify.py` from the repository root, using this exact script:

```python
import json,subprocess,xml.etree.ElementTree as ET
from pathlib import Path
cfg=json.loads(Path('enterprise-kafka-learning-lab.code-workspace').read_text(encoding='utf-8'))
task=next(t for t in cfg['tasks']['tasks'] if t['label']=='WSL: Verify build')
args=[v.replace('${workspaceFolder}',str(Path.cwd())) for v in task['windows']['args']]
r=subprocess.run([task['windows']['command'],*args],capture_output=True)
out=(r.stdout+r.stderr).decode();assert r.returncode==0,out
for value in ['spotless:3.12.0:check','checkstyle:3.6.0:check','0 Checkstyle violations','BUILD SUCCESS']:assert value in out,value
assert 'Could not transfer metadata' not in out
for folder in ['surefire-reports','failsafe-reports']:
 reports=list((Path('tools/build-verification/target')/folder).glob('TEST-*.xml'));assert len(reports)==1
 report=ET.parse(reports[0]).getroot();assert report.attrib['tests']=='1' and all(report.attrib[k]=='0' for k in ['failures','errors','skipped'])
assert not Path('tools/build-verification/src/main/java/io/github/ru5iru/kafkalab/buildverification/InspectionFailureProbe.java').exists()
settings=ET.parse('.mvn/settings.xml');ns={'s':'http://maven.apache.org/SETTINGS/1.2.0'}
assert settings.findtext('.//s:mirrorOf',namespaces=ns)=='*' and settings.findtext('.//s:url',namespaces=ns)=='https://repo.maven.apache.org/maven2'
print('PASS: editor process task runs WSL quality verify; format/style/convergence/compiler and 1 unit + 1 integration pass; Central mirror active')
```

Exit code: 0. Observed output:

```text
PASS: editor process task runs WSL quality verify; format/style/convergence/compiler and 1 unit + 1 integration pass; Central mirror active
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Spotless emits a Java 25 sun.misc.Unsafe deprecation warning; no suppression was added. These checks are not full SAST/SCA/SBOM/secret scanning. Local WSL currently defaults to root; no non-root execution/account change is claimed. Hosted CI, application/broker/database security and every future Java syntax remain unverified.

Restore reviewed tool/config pins with tests and quality rerun; keep the source fixture protected and remove only owned transient files. Review repository policy changes explicitly; never disable certificate checks or delete caches/source broadly.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-035.md).
