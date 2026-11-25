# Spring Boot learning starter

P2-014 creates the minimal non-web application for subsequent P2 lessons. It has no REST endpoint, Kafka client, database, Actuator or container image. It starts a Spring context, logs `Started LabStarterApplication`, then exits successfully because no server/worker holds the process open. A zero exit is expected here.

Keep editing in the existing Windows checkout. Run Java/Maven inside Ubuntu WSL with the [pinned environment](../../docs/development/wsl-setup.md). From repository root in WSL:

```bash
# Requires installed WSL JDK 25, unzip, sha256sum and HTTPS access to Central.
bash scripts/wsl/lab.sh sh mvnw --version
bash scripts/wsl/lab.sh sh mvnw -f applications/lab-starter/pom.xml clean verify
bash scripts/wsl/lab.sh java -jar applications/lab-starter/target/lab-starter-0.1.0-SNAPSHOT.jar
bash scripts/wsl/lab.sh python3 scripts/ci/verify-starter.py
```

The first wrapper run downloads checksum-pinned Maven 3.10.2 into the Linux user's `.m2/wrapper/dists` cache. Do not use `mvnw.cmd` or install Windows build dependencies. The root POM still builds only the tooling probe; `-f` independently selects this application and locates its parent directly in the checkout. Always invoke from repository root through the launcher so relative settings and quality paths resolve. No `mvn install`, broker, Docker or PostgreSQL server is needed.

`clean verify` runs Enforcer, formatting, Checkstyle, Java 25 compilation, one JUnit context smoke test and executable-JAR packaging. The CLI verifier checks reports, manifest, bytecode and scoped runtime libraries, launches the real JAR with a 30-second timeout, then confirms an invalid banner-mode option fails with a nonzero exit. It prints static result summaries rather than captured startup logs. It must run after the build; it does not compile the application.

Do not launch the `.jar.original` file: it lacks Boot's executable dependency layout. If `java -jar` says no main manifest, check the explicit `repackage` execution. A formatting failure can be corrected with `bash scripts/wsl/lab.sh sh mvnw -f applications/lab-starter/pom.xml spotless:apply`, then review the diff and rerun verification. A checksum/TLS failure requires investigation; do not remove the checksum or disable TLS. Upstream wrapper trusts an existing cache directory, so protect that cache and rebuild a suspect installation in a fresh user-owned cache.

Rollback is an ordinary revert of the scoped application/bootstrap change, including its CI and tracking updates after dependency review. No persistent application state or schema exists. The wrapper cache is outside Git and is not deleted automatically. Avoid destructive cleanup of the shared Linux Maven dependency cache.

See [ADR-0015](../../docs/architecture/decisions/0015-minimal-spring-boot-starter.md), [learning note](../../docs/learning-notes/P2/P2-014.md) and [executed evidence](../../docs/testing/evidence/P2-014-review.md). The [P2-015 lifecycle guide](../../docs/development/application-lifecycle.md) explains startup, readiness, failure and shutdown with temporary WSL experiments. SCA (P2-032), dedicated testing lessons and containerization (P2-034) remain future work. Local WSL currently defaults to root; no non-root runtime claim is made.
