# P2-004 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-003: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `b5a44003feef487b092d96ea85ffe13ad9757749`

## Scope and acceptance review

Read official Spring constructor-dependency guidance, including fully initialized objects and circular-dependency caveat. Reviewed plain-Java policy/port/adapter/composition-root dependencies; no Spring container involved. Compared direct construction, service locator and explicit constructor injection.

## Executed check

Command: `python P2-004-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-004-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'import java.util.Objects;\\npublic final class Probe {\\n    interface TickSource { long tick(); }\\n    static final class FixedTicks implements TickSource {\\n        private final long value;\\n        FixedTicks(long value) { this.value = value; }\\n        public long tick() { return value; }\\n    }\\n    static final class UnavailableTicks implements TickSource {\\n        public long tick() { throw new IllegalStateException("clock unavailable"); }\\n    }\\n    static final class DeadlinePolicy {\\n        private final TickSource ticks;\\n        DeadlinePolicy(TickSource ticks) { this.ticks = Objects.requireNonNull(ticks); }\\n        boolean expired(long deadline) { return ticks.tick() >= deadline; }\\n    }\\n    public static void main(String[] args) {\\n        assert !new DeadlinePolicy(new FixedTicks(9)).expired(10);\\n        assert new DeadlinePolicy(new FixedTicks(10)).expired(10);\\n        try { new DeadlinePolicy(null); throw new AssertionError("null accepted"); }\\n        catch (NullPointerException expected) { /* required collaborator */ }\\n        try { new DeadlinePolicy(new UnavailableTicks()).expired(10); throw new AssertionError("failure hidden"); }\\n        catch (IllegalStateException expected) { assert expected.getMessage().equals("clock unavailable"); }\\n        System.out.println("PASS: policy accepts substituted clock; boundary, missing collaborator and adapter failure verified");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: policy accepts substituted clock; boundary, missing collaborator and adapter failure verified
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

A small synthetic policy proves substitution, not service layering, runtime clock accuracy or Spring autowiring. Tick values are synthetic; production elapsed-time deadlines need monotonic-time/overflow design. No infrastructure port committed or new architecture mandated.

Revert documentation/index changes; isolated temporary compiler exercise cleans itself. No application container or dependency graph installed.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-004.md).
