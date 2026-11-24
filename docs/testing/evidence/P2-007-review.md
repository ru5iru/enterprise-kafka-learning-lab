# P2-007 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-006: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `0a8fa765aeeca24f6ab5ea46693b613f1bad70b2`

## Scope and acceptance review

Reviewed Java25 Record documentation and existing immutable-data/class-naming guidance. Compared original mutable list alias with a compact-constructor copy, tested value equality/hash, invalid input and accessor mutation. No persistent event/DTO or serialization contract created.

## Executed check

Command: `python P2-007-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-007-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.util.ArrayList;\\nimport java.util.List;\\npublic final class Probe {\\n    record Shallow(List<String> values) { }\\n    record Snapshot(List<String> values) {\\n        Snapshot {\\n            values = List.copyOf(values);\\n            if (values.isEmpty()) throw new IllegalArgumentException("empty batch");\\n        }\\n    }\\n    public static void main(String[] args) {\\n        List<String> original = new ArrayList<>(List.of("synthetic-a"));\\n        Shallow shallow = new Shallow(original);\\n        Snapshot snapshot = new Snapshot(original);\\n        original.add("synthetic-b");\\n        assert shallow.values().size() == 2 && snapshot.values().size() == 1;\\n        Snapshot equal = new Snapshot(List.of("synthetic-a"));\\n        assert snapshot.equals(equal) && snapshot.hashCode() == equal.hashCode();\\n        try { snapshot.values().add("synthetic-c"); throw new AssertionError("mutated"); }\\n        catch (UnsupportedOperationException expected) { /* snapshot accessor */ }\\n        try { new Snapshot(List.of()); throw new AssertionError("empty accepted"); }\\n        catch (IllegalArgumentException expected) { /* constructor invariant */ }\\n        try { new Snapshot(null); throw new AssertionError("null accepted"); }\\n        catch (NullPointerException expected) { /* constructor invariant */ }\\n        System.out.println("PASS: shallow alias exposed, defensive snapshot stable, equality/hash and invalid construction/mutation verified");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n (p/\'Broken.java\').write_text(\'public record Broken(int value) { void change() { value = 2; } }\',encoding=\'utf-8\')\n bad=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Broken.java\')],capture_output=True,text=True,timeout=20)\n assert bad.returncode!=0 and not (p/\'Broken.class\').exists()\n print(\'PASS: intentionally invalid source rejected by compiler\')\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: shallow alias exposed, defensive snapshot stable, equality/hash and invalid construction/mutation verified
PASS: intentionally invalid source rejected by compiler
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

List.copyOf copies element references; the example is deeply safe only because its elements are immutable Strings. No serializer/schema compatibility or inter-thread publication experiment here. Record choice does not replace event identity or schema governance.

Revert this learning/index commit; no production model or wire contract to migrate.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-007.md).
