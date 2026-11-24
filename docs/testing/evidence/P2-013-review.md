# P2-013 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-012: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `9c47ee2cb162c528e53ec496d5dac0a69791fefc`

## Scope and acceptance review

Reviewed publisher manual/FAQ/MDC and project policy. Read exact slf4j.version2.0.20 from existing Boot4.2.0 BOM; resolved matching API/simple artifacts via pinned dependency plugin in WSL. Executed `python wsl_run.py P2-013-script.txt` from repository root (Windows orchestration only), exit0, running this exact self-contained Bash payload inside Ubuntu WSL:

```bash
source scripts/wsl/environment.sh
python3 - <<'PY'
import tempfile,subprocess,xml.etree.ElementTree as E,os
from pathlib import Path
bom=Path.home()/'.m2/repository/org/springframework/boot/spring-boot-dependencies/4.2.0/spring-boot-dependencies-4.2.0.pom'
version=E.parse(bom).getroot().find('{*}properties/{*}slf4j.version').text
assert version=='2.0.20'
for artifact in ['slf4j-api','slf4j-simple']:
 command=['bash','scripts/wsl/lab.sh','mvn','-f','tools/build-verification/pom.xml','org.apache.maven.plugins:maven-dependency-plugin:3.11.0:get','-Dartifact=org.slf4j:'+artifact+':'+version,'-Dtransitive=false']
 r=subprocess.run(command,capture_output=True,text=True,timeout=150);assert r.returncode==0,r.stderr
api=Path.home()/('.m2/repository/org/slf4j/slf4j-api/'+version+'/slf4j-api-'+version+'.jar')
provider=Path.home()/('.m2/repository/org/slf4j/slf4j-simple/'+version+'/slf4j-simple-'+version+'.jar')
assert api.exists() and provider.exists()
with tempfile.TemporaryDirectory(prefix='kafka-lab-P2-013-') as temp:
 p=Path(temp)
 (p/'Probe.java').write_text('import org.slf4j.Logger;\nimport org.slf4j.LoggerFactory;\nimport org.slf4j.MDC;\npublic final class Probe {\n    private static int expensiveCalls;\n    static int expensive() { expensiveCalls++; return 42; }\n    public static void main(String[] args) {\n        Logger log = LoggerFactory.getLogger(Probe.class);\n        assert !log.isDebugEnabled();\n        log.debug("eager {}", expensive());\n        log.atDebug().addArgument(Probe::expensive).log("lazy {}");\n        assert expensiveCalls == 1;\n        log.info("review id={} status={}", "synthetic-id", "ok");\n        log.warn("untrusted={}", "synthetic\\nforged-line");\n        log.error("review failure id={}", "synthetic-id", new IllegalStateException("synthetic failure"));\n        MDC.put("correlationId", "synthetic-id");\n        assert MDC.get("correlationId") == null;\n        MDC.clear();\n        assert log.isInfoEnabled() == args[0].equals("provider");\n        System.out.println("PASS: mode=" + args[0] + "; disabled eager call evaluated once, fluent supplier not evaluated; provider-specific MDC behavior verified");\n    }\n}\n',encoding='utf-8')

 c=subprocess.run(['javac','--release','25','-Xlint:all','-Werror','-cp',str(api),'-d',temp,str(p/'Probe.java')],capture_output=True,text=True,timeout=20);assert c.returncode==0,c.stderr
 def execute(jars,mode):
  return subprocess.run(['java','-ea','-Dorg.slf4j.simpleLogger.defaultLogLevel=info','-cp',os.pathsep.join([temp,*map(str,jars)]),'Probe',mode],capture_output=True,text=True,timeout=20)
 absent=execute([api],'api-only');assert absent.returncode==0,absent.stderr
 assert 'No SLF4J providers were found' in absent.stderr and 'review id=synthetic-id' not in absent.stderr
 print(absent.stdout.strip());print('PASS: API-only run warns and drops application log through NOP')
 present=execute([api,provider],'provider');assert present.returncode==0,present.stderr
 assert 'No SLF4J providers were found' not in present.stderr
 assert 'review id=synthetic-id status=ok' in present.stderr
 assert 'java.lang.IllegalStateException: synthetic failure' in present.stderr
 assert 'untrusted=synthetic\nforged-line' in present.stderr
 print(present.stdout.strip())
 print('PASS: matching provider emits parameters and Throwable; synthetic newline survives substitution, so parameterization is not sanitization')
 print('PASS: Boot-managed SLF4J '+version+' artifacts resolved only into Linux Maven cache; no POM/provider application configuration changed')

PY

```

Actual observed output (captured from execution, not inferred):

```text
PASS: mode=api-only; disabled eager call evaluated once, fluent supplier not evaluated; provider-specific MDC behavior verified
PASS: API-only run warns and drops application log through NOP
PASS: mode=provider; disabled eager call evaluated once, fluent supplier not evaluated; provider-specific MDC behavior verified
PASS: matching provider emits parameters and Throwable; synthetic newline survives substitution, so parameterization is not sanitization
PASS: Boot-managed SLF4J 2.0.20 artifacts resolved only into Linux Maven cache; no POM/provider application configuration changed
```

Also executed the documented Linux-native reproduction adapter against P2-006: lazy/ordered/associative behavior and invalid capture checks passed. No private helper or new Windows runtime dependency required to reproduce.

## Executed check

Command: `python P2-013-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
import csv,io,subprocess,ast,re
rows=list(csv.DictReader(io.StringIO(Path('docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv').read_text(encoding='utf-8'))))
assert all(r['Status']=='Done' for r in rows if r['Phase']=='P2' and int(r['Task_ID'][-3:])<=13)
assert all(r['Status']=='Not Started' for r in rows if r['Phase']=='P2' and int(r['Task_ID'][-3:])>13)
assert not Path('applications').exists()
assert not subprocess.check_output(['git','diff','3fe163ed3e33fbced4847e83c53bb0457991e9a9','--name-only','--','pom.xml','tools','scripts','.mvn','.github']).strip()
guide=Path('docs/development/java-foundations-review.md').read_text(encoding='utf-8')
adapter=re.search(r'```python\n(.*?)\n```',guide,re.S).group(1)
ast.parse(adapter)
print('PASS: all 13 authorized tasks Done; P2-014 onward untouched')
print('PASS: no application/build/tool/CI modification; replay guide includes Linux-native adapter')
print('PASS: logging experiment executed separately in WSL and documented with exact script/output; not relabeled as a new runtime run here')
```

Exit code: 0. Observed output:

```text
PASS: all 13 authorized tasks Done; P2-014 onward untouched
PASS: no application/build/tool/CI modification; replay guide includes Linux-native adapter
PASS: logging experiment executed separately in WSL and documented with exact script/output; not relabeled as a new runtime run here
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No Boot application, logging configuration/provider selection, JSON/redaction sink, rotation, audit durability or async MDC propagation implemented. Simple/NOP MDC deliberately has no stored context. Raw newline demonstration is negative evidence only; full synthetic log content inspected in memory and not committed as a raw log. Source/version pins are not SCA.

Revert documentation/navigation/index commit if needed. Isolated JVM/temp sources clean themselves; only ordinary Linux Maven cache artifacts remain. No service/provider setting or externally sent message to undo.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-013.md).

## Requested boundary review

[Actual 13-task review and integrity audit](P2-001-013-review.md). P2-014 remains Not Started; this is a partial P2 slice.
