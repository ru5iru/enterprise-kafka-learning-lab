#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/environment.sh"
cd -- "$script_dir/../.."
work=$(mktemp -d /tmp/kafka-lab-test-gates.XXXXXXXX)
trap 'rm -f -- "$work/unit.log" "$work/missing.log" "$work/integration.log" "$work/positive.log"; rmdir -- "$work"' EXIT
if mvn test -Dprobe.expectedJava=99 > "$work/unit.log" 2>&1; then echo 'Expected unit failure did not block.' >&2; exit 1; fi
python3 - <<'PY'
import xml.etree.ElementTree as ET
r=ET.parse('tools/build-verification/target/surefire-reports/TEST-io.github.ru5iru.kafkalab.buildverification.ToolchainProbeTest.xml').getroot()
assert r.attrib['tests']=='1' and r.attrib['failures']=='1' and r.attrib['errors']=='0'
PY
if mvn test -Dtest=NoSuchToolchainTest > "$work/missing.log" 2>&1; then echo 'Missing test selection did not block.' >&2; exit 1; fi
python3 -c 'import sys; assert "No tests matching pattern" in open(sys.argv[1]).read()' "$work/missing.log"
if mvn verify -Dprobe.expectedMajor=0 > "$work/integration.log" 2>&1; then echo 'Expected integration failure did not block.' >&2; exit 1; fi
python3 - "$work/integration.log" <<'PY'
import sys,xml.etree.ElementTree as ET
r=ET.parse('tools/build-verification/target/failsafe-reports/TEST-io.github.ru5iru.kafkalab.buildverification.ToolchainProbeIT.xml').getroot()
assert r.attrib['tests']=='1' and r.attrib['failures']=='1' and r.attrib['errors']=='0'
assert 'failsafe:3.6.1:verify' in open(sys.argv[1]).read()
PY
mvn clean verify > "$work/positive.log" 2>&1 || { tail -n 25 "$work/positive.log" >&2; exit 1; }
python3 - <<'PY'
from pathlib import Path
import xml.etree.ElementTree as ET
for folder in ['surefire-reports','failsafe-reports']:
    reports=list((Path('tools/build-verification/target')/folder).glob('TEST-*.xml'))
    assert len(reports)==1
    r=ET.parse(reports[0]).getroot()
    assert r.attrib['tests']=='1' and all(r.attrib[k]=='0' for k in ['failures','errors','skipped'])
PY
printf 'PASS: unit failure, missing-test guard and integration verify failure blocked; restored 1 unit + 1 integration test passing\n'
