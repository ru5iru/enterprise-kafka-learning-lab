# P2-006 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-005: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `c3ffc783c30ff182d6c8a5c806ac72501f24e767`

## Scope and acceptance review

Read current stream pipeline and JLS lambda/capture contracts. Reviewed simple sequential pipeline, no stateful production callbacks or parallel I/O. One instrumentation-only counter observes filter traversal; a separate pure associative sum checks sequential/parallel equivalence on finite input.

## Executed check

Command: `python P2-006-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-006-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.util.List;\\nimport java.util.stream.Stream;\\npublic final class Probe {\\n    public static void main(String[] args) {\\n        int[] observed = {0};\\n        Stream<Integer> pipeline = List.of(1, 2, 3).stream()\\n                .filter(value -> { observed[0]++; return value % 2 == 1; })\\n                .map(value -> value * 10);\\n        assert observed[0] == 0;\\n        assert pipeline.toList().equals(List.of(10, 30));\\n        assert observed[0] == 3;\\n        try { pipeline.findFirst(); throw new AssertionError("stream reused"); }\\n        catch (IllegalStateException expected) { /* consumed pipeline */ }\\n        int sequential = List.of(1, 2, 3).stream().reduce(0, Integer::sum);\\n        int parallel = List.of(1, 2, 3).parallelStream().reduce(0, Integer::sum);\\n        assert sequential == 6 && parallel == sequential;\\n        try { Stream.of("invalid-number").map(Integer::parseInt).toList(); throw new AssertionError("failure hidden"); }\\n        catch (NumberFormatException expected) { /* terminal evaluation propagates failure */ }\\n        System.out.println("PASS: lazy pipeline, ordered transform, associative reduction, consumed reuse and evaluation failure verified");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n (p/\'Broken.java\').write_text(\'public final class Broken { void invalid() { int counter = 0; Runnable work = () -> counter++; } }\',encoding=\'utf-8\')\n bad=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Broken.java\')],capture_output=True,text=True,timeout=20)\n assert bad.returncode!=0 and not (p/\'Broken.class\').exists()\n print(\'PASS: intentionally invalid source rejected by compiler\')\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: lazy pipeline, ordered transform, associative reduction, consumed reuse and evaluation failure verified
PASS: intentionally invalid source rejected by compiler
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Counter callback is isolated instrumentation, not recommended application logic. Parallel sum is semantic demonstration, not throughput or Kafka ordering evidence. No file-backed stream, infinite pipeline or cancellation runtime experiment performed.

Revert documentation/index update; no Java runtime/source settings changed and temporary WSL probes are removed.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-006.md).
