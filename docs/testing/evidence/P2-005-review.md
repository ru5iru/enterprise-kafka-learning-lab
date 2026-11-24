# P2-005 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-004: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `952ef7b1a3dfd2f5312db7fd3487f5d2dc8427b2`

## Scope and acceptance review

Reviewed modern List/copy and Collections wrapper contracts plus older Oracle wildcard tutorial, explicitly noting its JDK8 provenance. Compiled current-Java generic producer/consumer bounds and invalid invariance assignment. Rejected mutation, duplicate Set.of input and null snapshot input in an isolated WSL probe.

## Executed check

Command: `python P2-005-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-005-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.util.ArrayList;\\nimport java.util.Collections;\\nimport java.util.HashMap;\\nimport java.util.List;\\nimport java.util.Map;\\nimport java.util.Set;\\npublic final class Probe {\\n    static <T> void append(List<? extends T> source, List<? super T> destination) {\\n        destination.addAll(source);\\n    }\\n    public static void main(String[] args) {\\n        List<Integer> values = new ArrayList<>(List.of(1, 2));\\n        List<Integer> view = Collections.unmodifiableList(values);\\n        List<Integer> snapshot = List.copyOf(values);\\n        values.add(3);\\n        assert view.size() == 3 && snapshot.size() == 2;\\n        List<Number> destination = new ArrayList<>();\\n        append(values, destination); assert destination.size() == 3;\\n        Map<String, Integer> map = new HashMap<>();\\n        map.put("synthetic-id", 1); map.put(new String("synthetic-id"), 2);\\n        assert map.size() == 1 && map.get("synthetic-id") == 2;\\n        try { snapshot.add(4); throw new AssertionError("snapshot mutated"); }\\n        catch (UnsupportedOperationException expected) { /* unmodifiable */ }\\n        try { Set.of(1, 1); throw new AssertionError("duplicate accepted"); }\\n        catch (IllegalArgumentException expected) { /* duplicate factory input */ }\\n        List<String> withNull = new ArrayList<>(); withNull.add(null);\\n        try { List.copyOf(withNull); throw new AssertionError("null accepted"); }\\n        catch (NullPointerException expected) { /* copy contract */ }\\n        System.out.println("PASS: generic producer/consumer bounds, view versus snapshot, key equality and mutation/duplicate/null rejection");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n (p/\'Broken.java\').write_text(\'import java.util.ArrayList; import java.util.List;\\npublic final class Broken { List<Number> values = new ArrayList<Integer>(); }\\n\',encoding=\'utf-8\')\n bad=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Broken.java\')],capture_output=True,text=True,timeout=20)\n assert bad.returncode!=0 and not (p/\'Broken.class\').exists()\n print(\'PASS: intentionally invalid source rejected by compiler\')\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: generic producer/consumer bounds, view versus snapshot, key equality and mutation/duplicate/null rejection
PASS: intentionally invalid source rejected by compiler
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

No throughput, memory-complexity or concurrent-collection benchmark. Snapshots copy references, not deeply immutable objects. Mutable-key and concurrent-access risks are reviewed scenarios, not executed distributed-system failures.

Revert learning/index commit; no persistent collection implementation or service state introduced.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-005.md).
