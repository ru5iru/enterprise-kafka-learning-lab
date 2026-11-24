#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/environment.sh"
work=$(mktemp -d /tmp/kafka-lab-javac.XXXXXXXX)
trap 'rm -f -- "$work/Probe.java" "$work/Probe.class" "$work/Broken.java" "$work/broken.log" "$work/release.log"; rmdir -- "$work"' EXIT

cat > "$work/Probe.java" <<'JAVA'
public final class Probe {
    public static void main(String[] args) {
        System.out.println("WSL compiler verified");
    }
}
JAVA
javac --version
javac --release 25 -d "$work" "$work/Probe.java"
[[ $(java -cp "$work" Probe) == 'WSL compiler verified' ]]
major=$(javap -verbose "$work/Probe.class" | awk '/major version:/ {print $3}')
[[ "$major" == 69 ]]

printf 'public class Broken { invalid }\n' > "$work/Broken.java"
if javac -d "$work" "$work/Broken.java" 2> "$work/broken.log"; then
  echo 'Invalid Java unexpectedly compiled.' >&2
  exit 1
fi
[[ ! -e "$work/Broken.class" ]]
if javac --release 99 -d "$work" "$work/Probe.java" 2> "$work/release.log"; then
  echo 'Unsupported release unexpectedly compiled.' >&2
  exit 1
fi
printf 'PASS: compile/run release 25, class major 69, malformed source and unsupported release rejected\n'
