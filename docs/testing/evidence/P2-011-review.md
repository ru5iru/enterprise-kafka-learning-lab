# P2-011 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-010: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `7de351e72ed1d25439992df8534b0fa972c4c76f`

## Scope and acceptance review

Reviewed current execution/completion policies and explicit executor ownership. Compiled a finite chain and negative result-state cases in WSL. Timed get leaves an uncompleted future available; orTimeout completes its receiver exceptionally; cancellation experiment concerns state only, no claim it interrupts underlying work.

## Executed check

Command: `python P2-011-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-011-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.util.concurrent.ArrayBlockingQueue;\\nimport java.util.concurrent.CancellationException;\\nimport java.util.concurrent.CompletableFuture;\\nimport java.util.concurrent.ExecutionException;\\nimport java.util.concurrent.ThreadPoolExecutor;\\nimport java.util.concurrent.TimeUnit;\\nimport java.util.concurrent.TimeoutException;\\nimport java.util.concurrent.atomic.AtomicInteger;\\npublic final class Probe {\\n    public static void main(String[] args) throws InterruptedException, ExecutionException, TimeoutException {\\n        ThreadPoolExecutor pool = new ThreadPoolExecutor(1, 1, 0, TimeUnit.MILLISECONDS,\\n                new ArrayBlockingQueue<>(4), task -> new Thread(task, "p2-future-worker"),\\n                new ThreadPoolExecutor.AbortPolicy());\\n        try {\\n            CompletableFuture<Integer> chain = CompletableFuture.supplyAsync(() -> {\\n                assert Thread.currentThread().getName().equals("p2-future-worker"); return 20;\\n            }, pool).thenApply(value -> value * 2)\\n                    .thenCompose(value -> CompletableFuture.completedFuture(value + 2));\\n            assert chain.get(3, TimeUnit.SECONDS) == 42;\\n            CompletableFuture<CompletableFuture<Integer>> nested = CompletableFuture.completedFuture(1)\\n                    .thenApply(value -> CompletableFuture.completedFuture(value + 1));\\n            assert nested.get(3, TimeUnit.SECONDS).get(3, TimeUnit.SECONDS) == 2;\\n            AtomicInteger failures = new AtomicInteger();\\n            CompletableFuture<Integer> failed = CompletableFuture.<Integer>failedFuture(\\n                    new IllegalArgumentException("synthetic failure"))\\n                    .whenComplete((value, failure) -> { if (failure != null) failures.incrementAndGet(); });\\n            try { failed.get(3, TimeUnit.SECONDS); throw new AssertionError("failure hidden"); }\\n            catch (ExecutionException expected) { assert expected.getCause() instanceof IllegalArgumentException; }\\n            assert failures.get() == 1 && failed.exceptionally(failure -> -1).get(3, TimeUnit.SECONDS) == -1;\\n            CompletableFuture<Integer> pending = new CompletableFuture<>();\\n            try { pending.get(1, TimeUnit.MILLISECONDS); throw new AssertionError("no timeout"); }\\n            catch (TimeoutException expected) { assert !pending.isDone(); }\\n            assert pending.complete(7) && pending.get(3, TimeUnit.SECONDS) == 7;\\n            CompletableFuture<Integer> timed = new CompletableFuture<>();\\n            assert timed.orTimeout(10, TimeUnit.MILLISECONDS) == timed;\\n            try { timed.get(3, TimeUnit.SECONDS); throw new AssertionError("no exceptional timeout"); }\\n            catch (ExecutionException expected) { assert expected.getCause() instanceof TimeoutException; }\\n            assert timed.isCompletedExceptionally() && !timed.complete(8);\\n            CompletableFuture<Integer> cancelled = new CompletableFuture<>();\\n            assert cancelled.cancel(true) && cancelled.isCancelled();\\n            try { cancelled.get(3, TimeUnit.SECONDS); throw new AssertionError("cancel ignored"); }\\n            catch (CancellationException expected) { /* result state, not worker interruption proof */ }\\n        } finally {\\n            pool.shutdown();\\n            if (!pool.awaitTermination(3, TimeUnit.SECONDS)) {\\n                pool.shutdownNow(); assert pool.awaitTermination(3, TimeUnit.SECONDS);\\n            }\\n        }\\n        assert pool.isTerminated();\\n        System.out.println("PASS: explicit executor, compose versus nesting, failure observation/recovery, wait versus stage timeout and cancellation state");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: explicit executor, compose versus nesting, failure observation/recovery, wait versus stage timeout and cancellation state
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No remote call, Kafka acknowledgement, transaction rollback or cancellation of a running external operation tested. Millisecond timeouts trigger result-state transitions; elapsed time not benchmarked. Synthetic fallback -1 illustrates recovery mechanics, not an approved success value for application failure.

Revert review/index commit; probe owns and terminates executor. Timeout/cancellation objects have no external side effects to roll back.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-011.md).
