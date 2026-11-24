# Maven verification in WSL

Run `bash scripts/wsl/verify-maven.sh`. The probe creates a temporary packaging=pom project and isolated Linux repository, resolves the explicitly pinned Maven Help Plugin 3.6.0 with strict checksum handling, generates an effective POM, repeats offline from that populated cache, and rejects malformed XML and an unknown lifecycle phase. No permanent application/POM or service build is created.

Plugin 3.6.0 was identified from official Maven Central metadata on 2026-11-24. This is a verification-only pin, not a shared application build policy. The real project plugin/dependency choices are owned by P1-032 onward. The temporary directory and repository are removed using a prefix-checked cleanup trap. Full logs stay bounded to synthetic inputs; failures print only the final diagnostic lines.

The experiment passed twice, each with an online and offline stage. [Evidence](../testing/evidence/P1-017-review.md) records observed behavior. Maven Central worked with verified TLS even though the separate Apache distribution host failed Linux certificate validation in P1-016; do not generalize one endpoint's result to all repositories. A cached/offline success alone would not prove fresh resolution.

For failure, inspect JAVA_HOME/executable selection, repository access, checksums and the failing POM/phase. Do not disable TLS/checksum checks. No persistent build artifacts or application state require rollback; remove/correct this probe through normal Git review.
