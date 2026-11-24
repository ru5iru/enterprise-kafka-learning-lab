# Java compiler verification

Run `bash scripts/wsl/verify-java.sh` inside Ubuntu WSL. It explicitly sources the project Java environment, compiles a temporary synthetic Probe with `--release 25`, runs it, inspects class major 69 and rejects malformed source and unsupported release 99. Temporary inputs/output live under a unique Linux /tmp directory and are removed on exit; no Java service is added to the repository.

The experiment was repeated twice for P1-015. See [actual evidence](../testing/evidence/P1-015-review.md). This establishes basic compiler/runtime functionality, not Maven/Spring/Kafka integration. If a check fails, inspect the selected JAVA_HOME/compiler version and the stage that failed; do not remove --release or suppress compilation errors to make it pass. Rollback of this verification artifact does not uninstall Java or alter global environment.
