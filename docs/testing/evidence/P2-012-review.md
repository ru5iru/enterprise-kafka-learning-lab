# P2-012 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-011: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `67a1686be06070d6750f0e4b025d61381eaf0ce0`

## Scope and acceptance review

Read abstract JVM runtime regions, management memory observations and HotSpot NMT limitations. Ran a32MiB heap-capped process observing nonheap/direct buffer separately, invalid Xms/Xmx startup and a separate16MiB heap process with one oversized allocation. No heap dumps, live-service attachment or host exhaustion experiment.

## Executed check

Command: `python P2-012-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-012-\') as temp:\n p=Path(temp)\n (p/\'Probe.java\').write_text(\'import java.lang.management.BufferPoolMXBean;\\nimport java.lang.management.ManagementFactory;\\nimport java.nio.ByteBuffer;\\npublic final class Probe {\\n    public static void main(String[] args) {\\n        long max = Runtime.getRuntime().maxMemory();\\n        assert max > 0 && max <= 40L * 1024 * 1024;\\n        assert ManagementFactory.getMemoryMXBean().getNonHeapMemoryUsage().getUsed() > 0;\\n        ByteBuffer direct = ByteBuffer.allocateDirect(4096);\\n        direct.putInt(0, 7); assert direct.getInt(0) == 7;\\n        long tracked = ManagementFactory.getPlatformMXBeans(BufferPoolMXBean.class).stream()\\n                .filter(pool -> pool.getName().equals("direct"))\\n                .mapToLong(BufferPoolMXBean::getMemoryUsed).sum();\\n        assert tracked >= 4096;\\n        System.out.println("PASS: heap maximum MiB=" + max / (1024 * 1024) + "; nonheap present; direct buffer tracked separately");\\n    }\\n}\\n\',encoding=\'utf-8\')\n (p/\'Exhaustion.java\').write_text(\'public final class Exhaustion { static byte[] retained; public static void main(String[] args) { retained = new byte[64 * 1024 * 1024]; } }\',encoding=\'utf-8\')\n\n c=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\'),str(p/\'Exhaustion.java\')],capture_output=True,text=True,timeout=20);assert c.returncode==0,c.stderr\n good=subprocess.run([\'java\',\'-ea\',\'-Xms16m\',\'-Xmx32m\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20);assert good.returncode==0,good.stderr;print(good.stdout.strip())\n bad=subprocess.run([\'java\',\'-Xms64m\',\'-Xmx32m\',\'-version\'],capture_output=True,text=True,timeout=10);assert bad.returncode!=0\n print(\'PASS: initial heap larger than maximum rejected at JVM startup\')\n exhausted=subprocess.run([\'java\',\'-Xms16m\',\'-Xmx16m\',\'-XX:-HeapDumpOnOutOfMemoryError\',\'-cp\',temp,\'Exhaustion\'],capture_output=True,text=True,timeout=20)\n assert exhausted.returncode!=0 and \'OutOfMemoryError: Java heap space\' in exhausted.stderr\n assert not list(p.glob(\'*.hprof\'))\n print(\'PASS: separate 16MiB-capped JVM exits on oversized allocation; no heap dump created or Error swallowed\')\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: heap maximum MiB=32; nonheap present; direct buffer tracked separately
PASS: initial heap larger than maximum rejected at JVM startup
PASS: separate 16MiB-capped JVM exits on oversized allocation; no heap dump created or Error swallowed
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Heap cap is not total process RSS or a container memory limit. No GC pause/throughput/leak benchmark, forced-GC guarantee, NMT capture, stack overflow or OS OOM-killer experiment. Heap failure occurs only in an isolated capped subprocess, not a service.

Revert review/index commit. All JVMs are bounded subprocesses and temporary source/classes removed; no persistent heap/JVM settings changed.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-012.md).
