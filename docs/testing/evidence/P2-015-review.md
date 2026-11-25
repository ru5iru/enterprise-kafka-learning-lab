# P2-015 verification

**Date:** 2026-11-25
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-014: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `32ae38b2e6218915747c33b520d440431a42ac75`

## Scope and acceptance review

## Scope and prerequisite review

Exact task P2-015 — Understand application lifecycle, Type Documentation / ADR, High priority. P2-014 is Done and merged by user request via PR7 into main `32ae38b2e6218915747c33b520d440431a42ac75`; original task head `b9e83c2cfbdde1b6808392a2dc0d7ed2c499f4ce` retained by merge commit. Its local/remote branch was deleted after clean-tree, ancestry, tip, worktree, protection and open-PR checks; intentional unmerged failure-probe branch preserved. New documentation branch starts at that verified main. [Merged-main CI45551403222](https://github.com/ru5iru/enterprise-kafka-learning-lab/actions/runs/45551403222) passed. No next task is included.

Reviewed README, AGENTS, task skill/workflow/template/DoD, roadmap/P2/exact row, architecture, SSDLC/security/Git guidance, previous P2-014 record and ADR0011/0013/0015. Self-review by executing agent against phase objective: explain Spring bootstrap and lifecycle without growing business behavior. No independent reviewer claimed. ADR not required: no new architecture/security choice, runtime configuration or dependency change.

## Application build actually executed

Inside Ubuntu WSL from repository root:

```bash
bash scripts/wsl/lab.sh sh mvnw -f applications/lab-starter/pom.xml clean verify
```

Actual exit0. Abbreviated observed output:

```text
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 6.467 s -- in io.github.ru5iru.kafkalab.starter.LabStarterApplicationTest
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] BUILD SUCCESS
```

Runtime remains OracleJDK25.0.5.1, Maven3.10.2, Boot4.2.0/Spring7.1.0. Existing Spotless Unsafe warning remains; no suppressions or dependency changes. Local WSL defaults to UID0. This unchanged build supplies current starter classes for the separate probe; it does not install a lifecycle listener into the application.

## Lifecycle experiment

**Executed**, not a suggested experiment. Copy this complete Python block to `/tmp/p215-lifecycle-probe.py` after source review, then run `bash scripts/wsl/lab.sh python3 /tmp/p215-lifecycle-probe.py` from repository root inside WSL. The original control-host orchestration fed this exact body to that Linux Python command using UTF-8 bytes on bash stdin. No Windows Java/Maven dependencies were installed.

The driver resolves only the application's existing runtime classpath with pinned Dependency3.11.0, compiles one temporary Java file with release25/lint-as-errors and runs four heap-capped isolated JVMs. The early listener is registered before run; a marker and finite runner are added only to each temporary context. One held main thread allows signal delivery. It sends signals solely to its own Popen objects and always kills/waits a survivor in finally; all temporary source/classes/logs/classpath output are removed by TemporaryDirectory. Outer startup/wait guards are experiment bounds, not production shutdown budgets.

```python
import os,signal,subprocess,tempfile,time
from pathlib import Path
root=Path.cwd()
source=r'''package io.github.ru5iru.kafkalab.lifecycleprobe;

import io.github.ru5iru.kafkalab.starter.LabStarterApplication;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import java.util.Set;
import java.util.concurrent.CountDownLatch;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.availability.AvailabilityChangeEvent;
import org.springframework.context.SmartLifecycle;
import org.springframework.context.support.GenericApplicationContext;

public final class LifecycleProbe {
    private LifecycleProbe() {}

    private static synchronized void mark(String value) {
        System.out.println("LIFECYCLE " + value);
        System.out.flush();
    }

    public static void main(String[] args) throws InterruptedException {
        String mode = args[0];
        var watched = Set.of("ApplicationStartingEvent", "ApplicationEnvironmentPreparedEvent",
                "ApplicationContextInitializedEvent", "ApplicationPreparedEvent",
                "ContextRefreshedEvent", "ApplicationStartedEvent", "ApplicationReadyEvent",
                "ApplicationFailedEvent", "ContextClosedEvent");
        var application = new SpringApplication(LabStarterApplication.class);
        application.addListeners(event -> {
            String name = event.getClass().getSimpleName();
            if (watched.contains(name)) {
                mark(name);
            }
            if (event instanceof AvailabilityChangeEvent<?> availability) {
                mark("AVAILABILITY_" + availability.getState());
            }
        });
        application.addInitializers(context -> {
            mark("INITIALIZER");
            var registry = (GenericApplicationContext) context;
            registry.registerBean("lifecycleMarker", Marker.class, Marker::new);
            registry.registerBean("probeRunner", ApplicationRunner.class, () -> arguments -> {
                mark("RUNNER");
                if ("runner-failure".equals(mode)) {
                    throw new IllegalStateException("synthetic lifecycle runner failure");
                }
            });
        });
        var context = application.run();
        mark("RUN_RETURNED");
        if ("hold".equals(mode)) {
            mark("HOLDING");
            new CountDownLatch(1).await();
        } else {
            context.close();
            mark("CLOSED_ACTIVE_" + context.isActive());
        }
    }

    public static final class Marker implements SmartLifecycle {
        private volatile boolean running;
        public Marker() { mark("CONSTRUCT"); }
        @PostConstruct
        public void initialize() { mark("POST_CONSTRUCT"); }
        @PreDestroy
        public void destroy() { mark("PRE_DESTROY"); }
        @Override
        public void start() { running = true; mark("SMART_START"); }
        @Override
        public void stop() { running = false; mark("SMART_STOP"); }
        @Override
        public void stop(Runnable callback) { stop(); callback.run(); }
        @Override
        public boolean isRunning() { return running; }
        @Override
        public int getPhase() { return 0; }
    }
}
'''
def markers(output):
    return [line.removeprefix('LIFECYCLE ') for line in output.splitlines() if line.startswith('LIFECYCLE ')]
def ordered(trace,items):
    positions=[trace.index(item) for item in items]
    assert positions==sorted(positions) and len(set(positions))==len(positions),(trace,items)
with tempfile.TemporaryDirectory(prefix='p215-lifecycle-') as name:
    work=Path(name);classpath_file=work/'runtime-classpath.txt'
    resolved=subprocess.run(['bash','scripts/wsl/lab.sh','sh','mvnw','-f','applications/lab-starter/pom.xml','dependency:build-classpath','-DincludeScope=runtime','-Dmdep.outputFile='+str(classpath_file)],capture_output=True,text=True,timeout=180)
    assert resolved.returncode==0,'Runtime classpath resolution failed; inspect locally without publishing raw logs'
    classpath=str(root/'applications/lab-starter/target/classes')+':'+classpath_file.read_text().strip()
    java_home=Path(os.environ['JAVA_HOME'])
    java_file=work/'LifecycleProbe.java';java_file.write_text(source,encoding='utf-8')
    compiled=subprocess.run([str(java_home/'bin/javac'),'--release','25','-proc:none','-Xlint:all','-Werror','-cp',classpath,'-d',str(work),str(java_file)],capture_output=True,text=True,timeout=30)
    assert compiled.returncode==0,compiled.stderr
    command=[str(java_home/'bin/java'),'-ea','-Xmx96m','-XX:-HeapDumpOnOutOfMemoryError','-cp',str(work)+':'+classpath,'io.github.ru5iru.kafkalab.lifecycleprobe.LifecycleProbe']
    normal=subprocess.run(command+['normal'],capture_output=True,text=True,timeout=30)
    assert normal.returncode==0
    trace=markers(normal.stdout)
    ordered(trace,['ApplicationStartingEvent','ApplicationEnvironmentPreparedEvent','INITIALIZER','ApplicationContextInitializedEvent','ApplicationPreparedEvent','CONSTRUCT','POST_CONSTRUCT','SMART_START','ContextRefreshedEvent','ApplicationStartedEvent','AVAILABILITY_CORRECT','RUNNER','ApplicationReadyEvent','AVAILABILITY_ACCEPTING_TRAFFIC','RUN_RETURNED','ContextClosedEvent','SMART_STOP','PRE_DESTROY','CLOSED_ACTIVE_false'])
    assert trace.count('PRE_DESTROY')==1
    print('NORMAL exit='+str(normal.returncode)+' trace='+','.join(trace))
    failed=subprocess.run(command+['runner-failure'],capture_output=True,text=True,timeout=30)
    trace=markers(failed.stdout)
    assert failed.returncode!=0
    ordered(trace,['SMART_START','ApplicationStartedEvent','RUNNER','ApplicationFailedEvent','ContextClosedEvent','SMART_STOP','PRE_DESTROY'])
    assert 'ApplicationReadyEvent' not in trace and 'AVAILABILITY_ACCEPTING_TRAFFIC' not in trace and 'RUN_RETURNED' not in trace
    print('RUNNER_FAILURE exit='+str(failed.returncode)+' trace='+','.join(trace))
    for label,force in [('SIGTERM',False),('SIGKILL',True)]:
        logfile=work/(label+'.log')
        with logfile.open('w',encoding='utf-8') as stream:
            process=subprocess.Popen(command+['hold'],stdout=stream,stderr=subprocess.STDOUT,text=True)
            try:
                deadline=time.monotonic()+30
                while 'LIFECYCLE HOLDING' not in logfile.read_text(encoding='utf-8'):
                    assert process.poll() is None,label+' exited before holding marker'
                    assert time.monotonic()<deadline,label+' startup timed out'
                    time.sleep(0.05)
                process.kill() if force else process.terminate()
                code=process.wait(timeout=10)
            finally:
                if process.poll() is None:
                    process.kill();process.wait(timeout=10)
        trace=markers(logfile.read_text(encoding='utf-8'))
        ordered(trace,['RUNNER','ApplicationReadyEvent','AVAILABILITY_ACCEPTING_TRAFFIC','HOLDING'])
        if force:
            assert code==-signal.SIGKILL
            assert not any(item in trace for item in ['ContextClosedEvent','SMART_STOP','PRE_DESTROY'])
        else:
            assert code in (-signal.SIGTERM,128+signal.SIGTERM)
            ordered(trace,['HOLDING','ContextClosedEvent','SMART_STOP','PRE_DESTROY'])
            assert trace.count('PRE_DESTROY')==1
        print(label+' exit='+str(code)+' trace='+','.join(trace))
print('PASS: lifecycle ordering, runner-failure readiness exclusion, explicit close, SIGTERM cleanup and SIGKILL absence of cleanup verified in isolated WSL JVMs')
print('No application/POM/CI changes, new dependencies, listener deployment or broker/DB/web runtime; temporary files and owned processes cleaned')
```

Observed output, exit0 for the Python driver:

```text
NORMAL exit=0 trace=ApplicationStartingEvent,ApplicationEnvironmentPreparedEvent,INITIALIZER,ApplicationContextInitializedEvent,ApplicationPreparedEvent,CONSTRUCT,POST_CONSTRUCT,SMART_START,ContextRefreshedEvent,ApplicationStartedEvent,AVAILABILITY_CORRECT,RUNNER,ApplicationReadyEvent,AVAILABILITY_ACCEPTING_TRAFFIC,RUN_RETURNED,ContextClosedEvent,SMART_STOP,PRE_DESTROY,CLOSED_ACTIVE_false
RUNNER_FAILURE exit=1 trace=ApplicationStartingEvent,ApplicationEnvironmentPreparedEvent,INITIALIZER,ApplicationContextInitializedEvent,ApplicationPreparedEvent,CONSTRUCT,POST_CONSTRUCT,SMART_START,ContextRefreshedEvent,ApplicationStartedEvent,AVAILABILITY_CORRECT,RUNNER,ApplicationFailedEvent,ContextClosedEvent,SMART_STOP,PRE_DESTROY
SIGTERM exit=143 trace=ApplicationStartingEvent,ApplicationEnvironmentPreparedEvent,INITIALIZER,ApplicationContextInitializedEvent,ApplicationPreparedEvent,CONSTRUCT,POST_CONSTRUCT,SMART_START,ContextRefreshedEvent,ApplicationStartedEvent,AVAILABILITY_CORRECT,RUNNER,ApplicationReadyEvent,AVAILABILITY_ACCEPTING_TRAFFIC,RUN_RETURNED,HOLDING,ContextClosedEvent,SMART_STOP,PRE_DESTROY
SIGKILL exit=-9 trace=ApplicationStartingEvent,ApplicationEnvironmentPreparedEvent,INITIALIZER,ApplicationContextInitializedEvent,ApplicationPreparedEvent,CONSTRUCT,POST_CONSTRUCT,SMART_START,ContextRefreshedEvent,ApplicationStartedEvent,AVAILABILITY_CORRECT,RUNNER,ApplicationReadyEvent,AVAILABILITY_ACCEPTING_TRAFFIC,RUN_RETURNED,HOLDING
PASS: lifecycle ordering, runner-failure readiness exclusion, explicit close, SIGTERM cleanup and SIGKILL absence of cleanup verified in isolated WSL JVMs
No application/POM/CI changes, new dependencies, listener deployment or broker/DB/web runtime; temporary files and owned processes cleaned
```

## Interpretation and failure review

- Normal: refresh initialized the marker and auto-started its SmartLifecycle before the started event; runner preceded ready/accepting state and normal run return. Explicit close produced close/stop/destroy, exactly one destruction and inactive context.
- Runner-failure: started/liveness events were present, but the deliberately throwing runner caused failed event and exit1. No ready, accepting or run-return marker. Cleanup of this already-refreshed context occurred; no claim about every partially failed refresh.
- SIGTERM: after an observed HOLDING marker, owned Java process exited143 and printed close/stop/destroy exactly once. No fixed sleeps substitute for readiness synchronization; monotonic deadlines bound marker polling and exit waits.
- SIGKILL: owned process return-9, with no close/stop/destroy markers. This illustrates why callbacks cannot provide crash durability; no production data was at risk.
- No REFUSING_TRAFFIC availability event appeared on normal close or SIGTERM for this non-web context. Guide explicitly distinguishes actual result from web/platform routing assumptions. No Actuator endpoint, HTTP traffic, Kafka drain, offset commit, worker processing or external dependency was tested.
- Traces contain only static event/state names and synthetic markers. Raw Spring logs, stack traces, configuration/environment and process output files are not published. No new component, runner, bean configuration, POM or CI code persists in this task.

Review checks cover lifecycle boundaries, callback selection/ordering limits, availability versus process state, termination failure semantics, future Kafka risks and WSL-only reproduction. Original roadmap/static phase checkboxes untouched. New guide/index/starter navigation is documentation, not P2-016 DI or P2-033 service behavior implementation.


## Executed check

Command: `python P2-015-verify.py` from the repository root, using this exact script:

```python
import subprocess,xml.etree.ElementTree as ET
from pathlib import Path
ns={'m':'http://maven.apache.org/POM/4.0.0'}
root=ET.parse('pom.xml').getroot()
assert root.find('m:properties/m:spring-boot.version',ns).text=='4.2.0'
assert root.find('m:properties/m:maven.compiler.release',ns).text=='25'
pom=ET.parse('applications/lab-starter/pom.xml').getroot()
assert [d.find('m:artifactId',ns).text for d in pom.findall('m:dependencies/m:dependency',ns)]==['spring-boot-starter','junit-jupiter']
main=Path('applications/lab-starter/src/main/java/io/github/ru5iru/kafkalab/starter/LabStarterApplication.java').read_text()
assert 'SpringApplication.run(LabStarterApplication.class, args)' in main
assert not subprocess.check_output(['git','diff','--name-only','--','pom.xml','.mvn','.github/workflows','scripts','applications/lab-starter/pom.xml','applications/lab-starter/src'],text=True).strip()
doc=Path('docs/development/application-lifecycle.md').read_text(encoding='utf-8')
for concept in ['ApplicationStartingEvent','ApplicationEnvironmentPreparedEvent','ApplicationContextInitializedEvent','ApplicationPreparedEvent','ContextRefreshedEvent','ApplicationStartedEvent','ApplicationReadyEvent','ApplicationFailedEvent','ContextClosedEvent','PostConstruct','PreDestroy','SmartLifecycle','ApplicationRunner','CommandLineRunner','SIGTERM','SIGKILL','REFUSING_TRAFFIC','96MiB','P2-016']:
    assert concept in doc,concept
assert 'Neither trace contained a `REFUSING_TRAFFIC` availability event' in doc
assert 'It leaves the application, POM and CI untouched' in doc
assert 'not automatically replay' in doc
for ending in ['.java','.class','.jar']:
    assert not any(p.endswith(ending) for p in subprocess.check_output(['git','ls-files','--others','--exclude-standard'],text=True).splitlines())
subprocess.run(['git','diff','--check'],check=True)
print('PASS: version/main/POM alignment, documentation-only source/build/CI scope, reviewed lifecycle/negative-case coverage, whitespace')
print('Review type: executing-agent self-review against official Boot4.2.0/Framework7.1.0/JDK25 references and the already-executed WSL traces below; no independent approval or new runtime execution claimed by this static gate')
```

Exit code: 0. Observed output:

```text
PASS: version/main/POM alignment, documentation-only source/build/CI scope, reviewed lifecycle/negative-case coverage, whitespace
Review type: executing-agent self-review against official Boot4.2.0/Framework7.1.0/JDK25 references and the already-executed WSL traces below; no independent approval or new runtime execution claimed by this static gate
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Documentation task with temporary synthetic probes; no persistent instrumentation or build/dependency/CI change. Single context/marker; no async worker, partial-refresh failure, phased graph, HTTP drain, Kafka/DB, container, SCA/SBOM or performance guarantee. WSL UID0 and prior warnings/reporting limits remain. No independent approval claimed. PR CI for this documentation branch is pending publication, not claimed by the main prerequisite run.

Revert only scoped documents and this tracking row normally, reviewing dependent-task effects. Temporary files/owned JVMs already cleaned. No runtime/data migration; do not delete shared caches or rewrite published history.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-015.md).
