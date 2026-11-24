# P2-010 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-009: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `9649759731f537ff5741e54ae58970f4d3cb263f`

## Scope and acceptance review

Reviewed core/max worker and queue interaction, failure observation and orderly/forced shutdown. Actual synthetic pool uses one worker and one queue entry; latch holds active work until rejection observed. Future.get observes submitted task failure. Explicit lifecycle checks ensure no worker survives.

## Executed check

Command: `python P2-010-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-010-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.util.concurrent.ArrayBlockingQueue;\\nimport java.util.concurrent.CountDownLatch;\\nimport java.util.concurrent.ExecutionException;\\nimport java.util.concurrent.Future;\\nimport java.util.concurrent.RejectedExecutionException;\\nimport java.util.concurrent.ThreadPoolExecutor;\\nimport java.util.concurrent.TimeUnit;\\nimport java.util.concurrent.TimeoutException;\\npublic final class Probe {\\n    public static void main(String[] args) throws InterruptedException, ExecutionException, TimeoutException {\\n        ThreadPoolExecutor pool = new ThreadPoolExecutor(1, 1, 0, TimeUnit.MILLISECONDS,\\n                new ArrayBlockingQueue<>(1), work -> new Thread(work, "p2-review-worker"),\\n                new ThreadPoolExecutor.AbortPolicy());\\n        CountDownLatch started = new CountDownLatch(1);\\n        CountDownLatch release = new CountDownLatch(1);\\n        try {\\n            Future<?> running = pool.submit(() -> {\\n                started.countDown();\\n                try {\\n                    if (!release.await(3, TimeUnit.SECONDS)) throw new IllegalStateException("probe gate timeout");\\n                } catch (InterruptedException interrupted) {\\n                    Thread.currentThread().interrupt(); throw new IllegalStateException("interrupted", interrupted);\\n                }\\n            });\\n            assert started.await(3, TimeUnit.SECONDS);\\n            Future<String> queued = pool.submit(() -> "queued completed");\\n            assert pool.getQueue().size() == 1;\\n            try { pool.submit(() -> "excess"); throw new AssertionError("overload accepted"); }\\n            catch (RejectedExecutionException expected) { /* explicit saturation */ }\\n            release.countDown(); running.get(3, TimeUnit.SECONDS);\\n            assert queued.get(3, TimeUnit.SECONDS).equals("queued completed");\\n            Future<?> failed = pool.submit(() -> { throw new IllegalArgumentException("synthetic failure"); });\\n            try { failed.get(3, TimeUnit.SECONDS); throw new AssertionError("failure hidden"); }\\n            catch (ExecutionException expected) { assert expected.getCause() instanceof IllegalArgumentException; }\\n        } finally {\\n            release.countDown(); pool.shutdown();\\n            if (!pool.awaitTermination(3, TimeUnit.SECONDS)) {\\n                pool.shutdownNow(); assert pool.awaitTermination(3, TimeUnit.SECONDS);\\n            }\\n        }\\n        assert pool.isTerminated();\\n        try { pool.execute(() -> { }); throw new AssertionError("shutdown accepted task"); }\\n        catch (RejectedExecutionException expected) { /* shutdown contract */ }\\n        System.out.println("PASS: one-worker/one-queue saturation rejects excess; accepted tasks complete, failure observed and shutdown terminates/rejects");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: one-worker/one-queue saturation rejects excess; accepted tasks complete, failure observed and shutdown terminates/rejects
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Pool size1/queue1 is an experiment, not an application sizing recommendation. Virtual threads reviewed only; no throughput benchmark, Kafka poll-loop offloading or resource admission-control implementation. shutdownNow only attempts interruption.

Revert documentation/index commit; probe releases gate in finally, shuts down/awaits and verifies termination before process exit.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-010.md).
