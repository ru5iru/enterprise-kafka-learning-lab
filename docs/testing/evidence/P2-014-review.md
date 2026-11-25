# P2-014 verification

**Date:** 2026-11-25
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-013: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `73d8367831b66c51f1d3c7bbacea104464e5f23d`

## Scope and acceptance review

P2-014 depends on P2-013 (Done). Base is main merge 73d8367; executing-agent self-review, no independent approval. Reviewed required README/AGENTS/skill, roadmap/phase/CSV, SSDLC, security, Git/DoD, ADR-0002/0004/0011/0013/0014 and prior Java/logging work. Scope is one minimal Spring Boot application and the build/CI/docs necessary to exercise it. No later task is completed. Phase-wide wording "Tested and containerized Spring Boot starter application" is not interpreted as authorization to implement P2-034.

## Earlier executed WSL build and regression commands

All commands below ran in Ubuntu WSL at repository root, using the existing Windows checkout. Commands returned 0 except the explicitly recorded initial tooling failure.

```bash
bash scripts/wsl/lab.sh sh mvnw --version
bash scripts/wsl/lab.sh sh mvnw -f applications/lab-starter/pom.xml clean verify
bash scripts/wsl/lab.sh python3 scripts/ci/verify-starter.py
bash scripts/wsl/lab.sh mvn clean verify
python3 scripts/ci/verify-test-reports.py
bash scripts/wsl/lab.sh sh mvnw -f applications/lab-starter/pom.xml dependency:tree
```

Observed: application Enforcer 4 rules passed, Spotless 2 Java files clean, Checkstyle 0 violations, compile/testCompile Java release25, Surefire 1 smoke test (zero failures/errors/skips), Boot 4.2.0 repackage and BUILD SUCCESS. Actual runtime: Oracle JDK25.0.5.1, Maven3.10.2 from Linux wrapper cache, WSL2 Linux amd64. Dependency tree resolved Boot4.2.0, Spring7.1.0, Logback1.6.6, SLF4J2.0.20, JUnit6.1.3 test scope; no independent overrides. The packaged CLI verifier checked JUnit exclusion and non-web/Kafka/database library scope.

The first tooling regression failed at Spotless: existing Java working files had CRLF after Windows checkout, while the Git blobs were LF. Added `*.java text eol=lf`, normalized only the three existing fixture working files, and reran. Their repository content diff remains empty. Restored tooling build passed: one unit and one integration test, zero failures/errors/skips. No formatter/test gate was disabled. Spotless emits its existing JDK Unsafe deprecation warning; it is not suppressed.

Abbreviated actual output (duplicate Maven summaries retained):

```text
Apache Maven 3.10.2 (61b8bc355f4c4325463c22aa9afe4e7811a290f8)
Java version: 25.0.5.1, vendor: Oracle Corporation, runtime: /opt/kafka-lab/jdk-25.0.5.1
OS name: "linux", version: "5.15.167.4-microsoft-standard-wsl2", arch: "amd64", family: "unix"
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 4.820 s -- in io.github.ru5iru.kafkalab.starter.LabStarterApplicationTest
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] BUILD SUCCESS
PASS: starter context smoke test: 1 tests, zero failures/errors/skips
PASS: executable Boot 4.2.0 JAR, Java 25 bytecode, scoped runtime dependencies
PASS: packaged java -jar startup marker and normal exit within 30 seconds
PASS: malformed banner-mode rejected with nonzero exit and startup failure diagnostic
Prepared 1 sanitized JUnit reports; no properties/output/failure text
PASS: fresh-cache wrapper rejects wrong SHA256 before Maven extraction/execution
PASS: starter report guard rejects missing reports
PASS: starter report guard rejects zero reports
PASS: starter report guard rejects failing reports
PASS: starter report guard rejects skipped reports
PASS: starter artifact contains suite/test status only; no JVM properties or captured logs
WSL runtime UID=0; no Windows Java/Maven execution
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.212 s -- in io.github.ru5iru.kafkalab.buildverification.ToolchainProbeTest
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.103 s -- in io.github.ru5iru.kafkalab.buildverification.ToolchainProbeIT
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] BUILD SUCCESS
PASS: surefire-reports: 1 tests, zero failures/errors/skips
PASS: failsafe-reports: 1 tests, zero failures/errors/skips
[INFO] BUILD SUCCESS
```

## Negative checksum/report experiments and artifact inspection

The following Python body ran via `bash scripts/wsl/lab.sh python3 -` at repository root. Temporary files/caches are scoped to TemporaryDirectory; the active wrapper properties never changed. Wrong-checksum download uses validated HTTPS and is rejected before extraction. Missing/zero/failing/skipped report probes each returned nonzero. Actual application report sanitization retained counters/test identity only.

```python
import os, shutil, subprocess, tempfile, xml.etree.ElementTree as ET
from pathlib import Path
root=Path.cwd()
with tempfile.TemporaryDirectory(prefix='p214-wrapper-') as name:
    work=Path(name)
    shutil.copyfile(root/'mvnw',work/'mvnw')
    props=work/'.mvn/wrapper/maven-wrapper.properties';props.parent.mkdir(parents=True)
    text=(root/'.mvn/wrapper/maven-wrapper.properties').read_text()
    digest=next(line.split('=',1)[1] for line in text.splitlines() if line.startswith('distributionSha256Sum='))
    props.write_text(text.replace(digest,'0'*64))
    environment=os.environ.copy();environment['MAVEN_USER_HOME']=str(work/'fresh-cache')
    result=subprocess.run(['sh',str(work/'mvnw'),'--version'],env=environment,capture_output=True,text=True,timeout=120)
    assert result.returncode!=0 and 'Failed to validate Maven distribution SHA-256' in result.stderr
    assert not list((work/'fresh-cache').rglob('bin/mvn'))
    print('PASS: fresh-cache wrapper rejects wrong SHA256 before Maven extraction/execution')
with tempfile.TemporaryDirectory(prefix='p214-guards-') as name:
    work=Path(name);reports=work/'applications/lab-starter/target/surefire-reports'
    reports.mkdir(parents=True)
    verifier=root/'scripts/ci/verify-starter.py'
    for label,attributes in [('missing',None),('zero','tests="0" failures="0" errors="0" skipped="0"'),('failing','tests="1" failures="1" errors="0" skipped="0"'),('skipped','tests="1" failures="0" errors="0" skipped="1"')]:
        if attributes is not None:(reports/'TEST-probe.xml').write_text('<testsuite '+attributes+'/>')
        result=subprocess.run(['python3',str(verifier)],cwd=work,capture_output=True,text=True,timeout=10)
        assert result.returncode!=0,label
        print('PASS: starter report guard rejects '+label+' reports')
subprocess.run(['python3','scripts/ci/prepare-test-artifacts.py','applications/lab-starter/target'],check=True)
reports=list(Path('applications/lab-starter/target/ci-reports').glob('*.xml'));assert len(reports)==1
for report in reports:
    suite=ET.parse(report).getroot()
    assert not suite.findall('.//properties') and not suite.findall('.//system-out') and not suite.findall('.//system-err')
    assert all(not element.text or not element.text.strip() for element in suite.iter())
print('PASS: starter artifact contains suite/test status only; no JVM properties or captured logs')
print('WSL runtime UID='+str(os.getuid())+'; no Windows Java/Maven execution')
```

The wrapper was generated with `bash scripts/wsl/lab.sh mvn org.apache.maven.plugins:maven-wrapper-plugin:3.3.4:wrapper -Dtype=only-script -Dmaven=3.10.2 -DdistributionSha256Sum=7d69999d218e025cf1c14691ba748a09706e47999bd505009403cef9d757c2df` (exit0). Before generation, the Maven3.10.2 ZIP was downloaded using Python urllib with normal TLS on the Windows control host, compared to the publisher's HTTPS `.sha512`, then hashed with SHA256. Only bytes/checksums were inspected on Windows; Java/Maven generation, download/unpack and execution occurred in WSL. No ZIP or wrapper binary is committed. Upstream script reviewed: download via wget/curl/Java, checksum before unpack, cache short-circuit; generated Windows companion retained but not executed.

CI review: application/wrapper push paths included, explicit independent build and CLI verification, failure propagation, bounded job, read-only token, full action pins unchanged, sanitized reports from both targets uploaded for7 days. Local PyYAML was unavailable; no Windows dependency was installed for it. Hosted validation is pending publication and must be reported separately; no hosted pass is invented here. Existing quality/test fault-injection scripts were not replayed because their rules/versions are unchanged; actual initial EOL rejection and new report rejection probes exercise affected behavior. No broker, DB, HTTP, image, load, SCA, signature or SBOM experiment is claimed.


## Executed check

Command: `python P2-014-verify.py` from the repository root, using this exact script:

```python
import ast, os, shlex, subprocess, xml.etree.ElementTree as ET
from pathlib import Path
from zipfile import ZipFile
root=Path.cwd()
ns={'m':'http://maven.apache.org/POM/4.0.0'}
parent=ET.parse('pom.xml').getroot()
assert [node.text for node in parent.findall('m:modules/m:module',ns)]==['tools/build-verification']
pom=ET.parse('applications/lab-starter/pom.xml').getroot()
assert pom.find('m:parent/m:relativePath',ns).text=='../../pom.xml'
deps=pom.findall('m:dependencies/m:dependency',ns)
assert [node.find('m:artifactId',ns).text for node in deps]==['spring-boot-starter','junit-jupiter']
assert deps[1].find('m:scope',ns).text=='test'
for source in ['scripts/ci/verify-starter.py','scripts/ci/prepare-test-artifacts.py']:
    ast.parse(Path(source).read_text(encoding='utf-8'))
for source in Path('applications/lab-starter/src').rglob('*.java'):
    assert b'\r' not in source.read_bytes()
properties=Path('.mvn/wrapper/maven-wrapper.properties').read_text()
assert 'wrapperVersion=3.3.4' in properties and 'distributionType=only-script' in properties
assert 'distributionSha256Sum=7d69999d218e025cf1c14691ba748a09706e47999bd505009403cef9d757c2df' in properties
assert not list(Path('.mvn/wrapper').glob('*.jar'))
assert '*.java text eol=lf' in Path('.gitattributes').read_text()
print('PASS: independent POM, narrow/test-scoped dependencies, Python syntax, LF Java, pinned script-only wrapper')
commands='bash scripts/wsl/lab.sh python3 scripts/ci/verify-starter.py\npython3 scripts/ci/verify-test-reports.py\npython3 scripts/ci/prepare-test-artifacts.py applications/lab-starter/target\n'
if os.name=='nt':
    location=subprocess.check_output(['wsl','-d','Ubuntu','--','wslpath','-a','-u',root.as_posix()],text=True,timeout=20).strip()
    result=subprocess.run(['wsl','-d','Ubuntu','--','bash','-s'],input=('set -euo pipefail\ncd '+shlex.quote(location)+'\n'+commands).encode('utf-8'),capture_output=True,timeout=100)
else:
    result=subprocess.run(['bash','-s'],input=('set -euo pipefail\n'+commands).encode('utf-8'),capture_output=True,timeout=100)
if result.returncode:
    raise RuntimeError('Final runtime checks failed: '+(result.stdout+result.stderr).decode('utf-8',errors='replace'))
print(result.stdout.decode('utf-8').strip())
reports=list(Path('applications/lab-starter/target/ci-reports').glob('*.xml'))
assert len(reports)==1
for report in reports:
    suite=ET.parse(report).getroot()
    assert set(suite.attrib)<={'name','tests','failures','errors','skipped','time'}
    assert all(node.tag in {'testsuite','testcase','failure','error','skipped'} for node in suite.iter())
    assert all(not node.text or not node.text.strip() for node in suite.iter())
print('PASS: sanitized starter artifact structure and no captured output/properties')
subprocess.run(['git','diff','--check'],check=True)
print('PASS: working diff whitespace check')
```

Exit code: 0. Observed output:

```text
PASS: independent POM, narrow/test-scoped dependencies, Python syntax, LF Java, pinned script-only wrapper
PASS: starter context smoke test: 1 tests, zero failures/errors/skips
PASS: executable Boot 4.2.0 JAR, Java 25 bytecode, scoped runtime dependencies
PASS: packaged java -jar startup marker and normal exit within 30 seconds
PASS: malformed banner-mode rejected with nonzero exit and startup failure diagnostic
PASS: surefire-reports: 1 tests, zero failures/errors/skips
PASS: failsafe-reports: 1 tests, zero failures/errors/skips
Prepared 1 sanitized JUnit reports; no properties/output/failure text
PASS: sanitized starter artifact structure and no captured output/properties
PASS: working diff whitespace check
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Only this bootstrap is complete, not the phase container deliverable. No HTTP/Kafka/DB/container/SCA/SBOM/performance test. Generated mvnw.cmd not executed; WSL UID0, existing Spotless Unsafe warning and disabled private reporting remain. Wrapper trusts existing cache; TLS/checksums are not independent signature or vulnerability assurance. Hosted CI pending at record creation. Review by executing agent only.

Revert the scoped application/bootstrap/CI/docs/tracking commit normally after assessing dependent tasks. No data/schema migration. External Linux wrapper/dependency caches are not deleted automatically; no force-push or shared cache deletion.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-014.md).
