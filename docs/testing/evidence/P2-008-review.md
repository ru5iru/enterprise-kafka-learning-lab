# P2-008 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-007: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `25296355322b8f8de90638688e23da6f57551adb`

## Scope and acceptance review

Read hierarchy/compile checking, interruption and resource-closure documentation; compared existing project exception policy. Synthetic IOException translation preserves cause, try-with-resources retains primary plus suppressed close failure, interruption restored when caught. No universal retry/error mapper introduced.

## Executed check

Command: `python P2-008-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-008-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.io.IOException;\\nimport java.io.UncheckedIOException;\\npublic final class Probe {\\n    static final class Resource implements AutoCloseable {\\n        void read() throws IOException { throw new IOException("synthetic primary"); }\\n        public void close() throws IOException { throw new IOException("synthetic close"); }\\n    }\\n    static void translate() {\\n        try { throw new IOException("synthetic cause"); }\\n        catch (IOException failure) { throw new UncheckedIOException("read failed", failure); }\\n    }\\n    public static void main(String[] args) {\\n        try { translate(); throw new AssertionError("failure hidden"); }\\n        catch (UncheckedIOException expected) { assert expected.getCause().getMessage().equals("synthetic cause"); }\\n        try (Resource resource = new Resource()) { resource.read(); }\\n        catch (IOException expected) {\\n            assert expected.getMessage().equals("synthetic primary");\\n            assert expected.getSuppressed().length == 1;\\n            assert expected.getSuppressed()[0].getMessage().equals("synthetic close");\\n        }\\n        Thread.currentThread().interrupt();\\n        try { Thread.sleep(1); throw new AssertionError("interrupt ignored"); }\\n        catch (InterruptedException expected) {\\n            assert !Thread.currentThread().isInterrupted();\\n            Thread.currentThread().interrupt();\\n        }\\n        assert Thread.currentThread().isInterrupted();\\n        assert Thread.interrupted();\\n        System.out.println("PASS: checked cause preserved, close failure suppressed, interrupt restored and cleared after probe");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n (p/\'Broken.java\').write_text(\'public final class Broken { void read() { throw new java.io.IOException("synthetic"); } }\',encoding=\'utf-8\')\n bad=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Broken.java\')],capture_output=True,text=True,timeout=20)\n assert bad.returncode!=0 and not (p/\'Broken.class\').exists()\n print(\'PASS: intentionally invalid source rejected by compiler\')\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: checked cause preserved, close failure suppressed, interrupt restored and cleared after probe
PASS: intentionally invalid source rejected by compiler
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Synthetic local failures only. No Kafka retry, offset, remote timeout or Spring HTTP error mapping executed. Interruption is cooperative and does not guarantee every blocking API/task stops.

Revert review/index commit; temporary process clears its deliberate interrupt flag before exit and owns no external resources.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-008.md).
