# WSL development environment

Develop in the current checkout and execute the lab in Ubuntu WSL, per [ADR-0011](../architecture/decisions/0011-wsl-development-runtime.md). Keep one active working tree. No application or broker is created by these setup instructions.

## JDK installation â€” P1-013

The target is Ubuntu 24.04 x86_64 under WSL 2. Oracle's download page was checked on 2026-11-24: JDK 25.0.5.1. The Linux archive SHA-256 is pinned in [install-jdk.sh](../../scripts/wsl/install-jdk.sh); TLS and checksum verification must succeed before extraction. Existing installation checks are idempotent. No PATH/JAVA_HOME or Windows settings are changed by that installer.

From PowerShell, the equivalent installation command is:

```powershell
wsl -d Ubuntu -u root -- bash /mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab/scripts/wsl/install-jdk.sh
```

This installs `/opt/kafka-lab/jdk-25.0.5.1`. The current Oracle URL is mutable, so a future checksum mismatch must stop installation: review the new artifact/version rather than bypassing verification. Consult [Oracle terms](https://www.oracle.com/downloads/licenses/no-fee-license.html) for intended use; the installation does not establish a support entitlement.

Verification and rollback are in the [task evidence](../testing/evidence/P1-013-review.md). Do not remove a pre-existing toolchain as rollback. This new versioned directory can be retired only after confirming nothing uses it; no global alternatives were changed. Environment configuration, compiler experiments, Maven and Docker have their own sequential tasks.

## Project Java environment — P1-014

Use the checked-in launcher rather than Windows Java/Maven or global shell edits:

```text
wsl -d Ubuntu --exec /bin/bash /mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab/scripts/wsl/lab.sh java --version
```

Inside WSL, `bash scripts/wsl/lab.sh <command> [arguments...]` selects the Linux JDK, filters inherited Windows PATH entries and runs from repository root. To configure an interactive shell explicitly, source `scripts/wsl/environment.sh`. `LAB_JAVA_HOME` can select another complete Linux JDK only after a reviewed version change; an absent/incomplete path is rejected. The launcher passes arguments directly without eval, supports paths containing spaces, and returns the command's exit code. It does not persist global JAVA_HOME, change Windows settings or modify login files. Rollback: stop sourcing/using this launcher; existing shells are unchanged unless they explicitly sourced it.
