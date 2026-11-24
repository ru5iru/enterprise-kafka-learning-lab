# Reproducing the Java foundations reviews

The [P2 journal](../learning-notes/P2/README.md) contains concept reviews and bounded synthetic experiments, not application code. The evidence records the exact executed driver and actual results. Temporary Windows orchestration originally called Ubuntu WSL; no Windows Java/Maven dependencies were installed.

## Execute a recorded Java experiment inside WSL

Start in the repository root **inside Ubuntu WSL**. Copy the following standard-library adapter to `/tmp/reproduce-review.py`, then select a completed review, for example:

```bash
python3 /tmp/reproduce-review.py P2-006
```

```python
import re,subprocess,sys,types
from pathlib import Path
root=Path.cwd().resolve()
assert (root/'AGENTS.md').is_file() and (root/'scripts/wsl/environment.sh').is_file()
task=sys.argv[1]
assert re.fullmatch(r'P2-00[2-9]|P2-01[0-2]',task), 'Use a completed P2-002 through P2-012 review'
evidence=root/'docs/testing/evidence'/(task+'-review.md')
section=evidence.read_text(encoding='utf-8').split('## Executed check',1)[1]
code=re.search(r'```python\n(.*?)\n```',section,re.S).group(1)
module=types.ModuleType('wsl_run');module.ROOT=str(root)
def run(script):
 result=subprocess.run(['bash','-s'],input='set -euo pipefail\n'+script+'\n',capture_output=True,text=True,timeout=360)
 output=result.stdout+result.stderr
 if result.returncode:raise RuntimeError('Review failed: '+output)
 return result.returncode,output
module.run=run;sys.modules['wsl_run']=module
exec(compile(code,str(evidence),'exec'))

```

This reads only a selected P2-002 through P2-012 record's Executed check Python block and supplies a local Bash adapter for its original `wsl_run` import. It is executable repository evidence: inspect the selected record before running it. It needs only the existing Python 3/Bash and reviewed WSL Java/Maven tools. No temporary Windows helper or hardcoded Windows user path is required. This adapter was actually checked against P2-006; its source is shown rather than installing another project runner.

P2-001 is descriptor/path self-review and its evidence script is directly executable Python from repository root. P2-013's evidence includes the complete standalone Bash/Python SLF4J experiment under its scope review; copy that Bash block into a temporary script and run `bash /tmp/slf4j-review.sh` in WSL. Its final Executed check Python block is the document/CSV review gate, not a claim to repeat the logging experiment.

Experiments use temporary directories, Java assertions enabled, finite inputs and bounded subprocess waits. P2-012 deliberately fails a separate 16MiB-heap-capped JVM with heap dumps disabled; it does not stress host memory. P2-013's synthetic newline deliberately demonstrates why raw parameter input can forge line structure; only safe synthetic data is used. No persistent Java service, Spring application, provider configuration or Kafka/DB runtime is installed. Dependency resolution populates only the Linux Maven cache and requires HTTPS connectivity if artifacts are absent.

These experiments are separate from existing `bash scripts/wsl/lab.sh mvn clean verify`, which still tests the P1 tooling module. No claim that CI reruns all Java concept probes automatically. Local Ubuntu currently defaults to root; the reviewed scripts did not create/change accounts. P2-014 and later require separate authorization.
