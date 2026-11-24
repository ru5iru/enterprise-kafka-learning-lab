# WSL development environment

Develop in the current checkout and execute the lab in Ubuntu WSL, per [ADR-0011](../architecture/decisions/0011-wsl-development-runtime.md). Keep one active working tree. No application or broker is created by these setup instructions.

## JDK installation — P1-013

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

## Maven installation — P1-016

Maven 3.10.2 is installed in `/opt/kafka-lab/apache-maven-3.10.2`; the launcher selects it before inherited Windows executables. Run `bash scripts/wsl/lab.sh mvn --version` in WSL. [install-maven.sh](../../scripts/wsl/install-maven.sh) verifies a pinned Apache SHA-512 before extraction and can consume one local archive acquired through verified TLS.

The WSL Apache download failed certificate validation during setup. A Windows `curl.exe --fail --location` download succeeded with normal certificate validation; its archive was passed to the Linux installer and hash-checked there. No insecure TLS flag or new trust root was used. To reproduce that fallback, download the named 3.10.2 archive from the official URL in the installer to a temporary Windows file, translate its path with `wslpath -u`, then run the installer as WSL root with that path. The download location does not change where Maven is installed/executed. Publisher checksums are integrity evidence, not an independent signature audit. Dependency resolution is verified separately in P1-017.

No Windows Maven or global alternatives were changed. Rollback means retire only this versioned Linux Maven after checking consumers and correct the project launcher; do not remove the existing Windows toolchain or alter TLS verification to work around download errors.

## Docker engine — P1-018

Ubuntu-packaged Docker 29.1.3 and its exact containerd/runc package pins are installed in WSL; see [ADR-0012](../architecture/decisions/0012-wsl-container-runtime.md). This is not upstream Docker CE or Docker Desktop. [install-docker.sh](../../scripts/wsl/install-docker.sh) uses a private signed apt index to avoid an unrelated long-running apt update, then normal dpkg locks. Do not kill that process or delete locks.

Use `wsl -d Ubuntu -u root --exec /usr/bin/docker version` for an explicit administrative check. The rootful daemon is systemd-managed on the normal Unix socket; no user/group membership or world-writable socket workaround was added. Images/volumes stay in WSL. Compose/container execution are the next tasks, and ordinary unprivileged Docker access is not claimed. To roll back, first assess daemon users/data, then stop/disable the service in a reviewed change; never purge Docker state as routine cleanup.
