# P2-009 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-008: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `9948565d197e4af7aabc6ecf0868d645c7e22042`

## Scope and acceptance review

Reviewed Java memory-model visibility/ordering, latch and atomic contracts. Deliberately coordinated two read/modify/write operations so both read zero before either writes; final volatile value1 proves lost update without probabilistic stress. Safe atomic/monitor loops each reached2000; all waits/joins bounded and threads checked terminated.

## Executed check

Command: `python P2-009-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-009-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.util.concurrent.CountDownLatch;\\nimport java.util.concurrent.TimeUnit;\\nimport java.util.concurrent.atomic.AtomicBoolean;\\nimport java.util.concurrent.atomic.AtomicInteger;\\npublic final class Probe {\\n    private static volatile int raced;\\n    static final class Guarded {\\n        private int value;\\n        synchronized void increment() { value++; }\\n        synchronized int value() { return value; }\\n    }\\n    public static void main(String[] args) throws InterruptedException {\\n        CountDownLatch read = new CountDownLatch(2);\\n        CountDownLatch write = new CountDownLatch(1);\\n        AtomicBoolean failed = new AtomicBoolean();\\n        Runnable splitIncrement = () -> {\\n            int before = raced;\\n            read.countDown();\\n            try {\\n                if (!write.await(3, TimeUnit.SECONDS)) { failed.set(true); return; }\\n                raced = before + 1;\\n            } catch (InterruptedException interrupted) {\\n                Thread.currentThread().interrupt(); failed.set(true);\\n            }\\n        };\\n        Thread left = new Thread(splitIncrement);\\n        Thread right = new Thread(splitIncrement);\\n        left.start(); right.start();\\n        try { assert read.await(3, TimeUnit.SECONDS); }\\n        finally { write.countDown(); left.join(3000); right.join(3000); }\\n        assert !left.isAlive() && !right.isAlive() && !failed.get();\\n        assert raced == 1;\\n        AtomicInteger atomic = new AtomicInteger();\\n        Guarded guarded = new Guarded();\\n        Runnable safeIncrement = () -> {\\n            for (int i = 0; i < 1000; i++) { atomic.incrementAndGet(); guarded.increment(); }\\n        };\\n        Thread first = new Thread(safeIncrement);\\n        Thread second = new Thread(safeIncrement);\\n        first.start(); second.start(); first.join(3000); second.join(3000);\\n        assert !first.isAlive() && !second.isAlive();\\n        assert atomic.get() == 2000 && guarded.value() == 2000;\\n        System.out.println("PASS: coordinated volatile read/modify/write loses one update; atomic and synchronized counters both reach 2000");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: coordinated volatile read/modify/write loses one update; atomic and synchronized counters both reach 2000
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

This deterministic interleaving illustrates non-atomic compound work, not all data-race outcomes or JVM correctness testing. No production worker pool, Kafka Consumer concurrency, deadlock or stress benchmark installed. Scheduling deadlines are probe guards, not measured SLOs.

Revert review/index changes; temporary JVM exits with all owned threads terminated. No background process/service persists.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-009.md).
