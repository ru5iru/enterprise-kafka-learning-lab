# P2-003 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P2-002: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `47869df84fd463a0af5700162813b2bd949c6545`

## Scope and acceptance review

Read Java interface/abstract-class specifications and reviewed synthetic SizePolicy contract: nonnegative input, accepted result between zero and input, same invalid-input behavior. Compiled and ran two substitutable implementations in WSL; missing Runnable.run implementation rejected. No repository Java source added.

## Executed check

Command: `python P2-003-verify.py` from the repository root, using this exact script:

```python
from wsl_run import run,ROOT
code,output=run('cd '+ROOT+'\n'+'source scripts/wsl/environment.sh\npython3 - <<\'PY\'\nimport tempfile,subprocess\nfrom pathlib import Path\nwith tempfile.TemporaryDirectory(prefix=\'kafka-lab-P2-003-\') as temp:\n p=Path(temp);(p/\'Probe.java\').write_text(\'public final class Probe {\\n    interface SizePolicy { int accepted(int offered); }\\n    static final class Exact implements SizePolicy {\\n        public int accepted(int offered) {\\n            if (offered < 0) throw new IllegalArgumentException("negative size");\\n            return offered;\\n        }\\n    }\\n    static final class Capped implements SizePolicy {\\n        public int accepted(int offered) {\\n            if (offered < 0) throw new IllegalArgumentException("negative size");\\n            return Math.min(offered, 4);\\n        }\\n    }\\n    static int evaluate(SizePolicy policy) { return policy.accepted(10); }\\n    public static void main(String[] args) {\\n        assert evaluate(new Exact()) == 10;\\n        assert evaluate(new Capped()) == 4;\\n        for (SizePolicy policy : new SizePolicy[] {new Exact(), new Capped()}) {\\n            try { policy.accepted(-1); throw new AssertionError("invalid size accepted"); }\\n            catch (IllegalArgumentException expected) { /* expected contract rejection */ }\\n        }\\n        System.out.println("PASS: interface dispatch selects two strategies; both reject negative size");\\n    }\\n}\\n\',encoding=\'utf-8\')\n compile=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Probe.java\')],capture_output=True,text=True,timeout=20)\n assert compile.returncode==0,compile.stderr\n result=subprocess.run([\'java\',\'-ea\',\'-cp\',temp,\'Probe\'],capture_output=True,text=True,timeout=20)\n assert result.returncode==0,result.stderr\n print(result.stdout.strip())\n (p/\'Broken.java\').write_text(\'public final class Broken implements Runnable { }\',encoding=\'utf-8\')\n bad=subprocess.run([\'javac\',\'--release\',\'25\',\'-Xlint:all\',\'-Werror\',\'-d\',temp,str(p/\'Broken.java\')],capture_output=True,text=True,timeout=20)\n assert bad.returncode!=0 and not (p/\'Broken.class\').exists()\n print(\'PASS: intentionally invalid source rejected by compiler\')\n\nPY\n')
assert code==0
print(output.strip())
```

Exit code: 0. Observed output:

```text
PASS: interface dispatch selects two strategies; both reject negative size
PASS: intentionally invalid source rejected by compiler
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

Synthetic language exercise only; static method signatures do not enforce behavioral contracts, thread safety, delivery semantics or runtime authorization. Abstract-class trade-off reviewed, not a new framework. No application adapter or Kafka client exists.

Revert the documentation/index commit; TemporaryDirectory removes the isolated Java sources/classes. No runtime wiring to roll back.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P2/P2-003.md).
