# ADR-0011: Develop in the current workspace, execute in Ubuntu WSL

- **Status:** Accepted; owner explicitly requested this environment on 2026-11-24.
- **Related tasks:** P1-013 onward.
- **Decision:** Keep editing this Windows-hosted checkout and run Linux development commands in Ubuntu 24.04, WSL 2. Install project dependencies inside WSL. Do not install parallel Windows toolchains or move/copy the active checkout implicitly.

## Context and rationale

The existing workspace and Windows Git credentials contain the accepted history. WSL is installed, Ubuntu runs systemd, and the checkout is readable at `/mnt/c/Users/rusiru.r/Desktop/Projects/enterprise-kafka-learning-lab`. The previous environment probe found no Linux JDK, Docker or PostgreSQL client; `mvn` resolved to a Windows installation with no valid Linux JAVA_HOME. A Windows executable discovered through inherited PATH is not a verified Linux dependency.

Use Linux-managed versioned tool directories and Linux caches. Configure an explicit project environment in P1-014 so builds do not accidentally select Windows tools. Retain the reviewed Java 25.0.5.1 reference in ADR-0004; the official Oracle page and publisher SHA-256 were rechecked before installation. No preview features or service implementation is introduced by setup.

## Alternatives and consequences

| Option | Decision and trade-off |
|---|---|
| Current checkout with WSL execution | Selected to honor the owner's workflow and preserve one active tree; `/mnt/c` filesystem operations can be slower |
| Move/clone into Linux home | Potentially faster Linux builds, but changes workspace location and risks two divergent trees; deferred until explicitly chosen |
| Windows toolchain plus WSL runtime | Rejected: ambiguous executable/PATH/Java homes and inconsistent local builds |
| Docker Desktop as the runtime dependency | Not selected by this decision; P1-018 will install/verify the Linux engine inside WSL |

Use Windows Git for the existing publication workflow and Linux Git when its assigned task is verified. Never run concurrent Git mutations against the same checkout. WSL installations require explicit escalated tool execution outside the repository; that is environment access, not a request to broaden task scope. Package downloads use TLS and publisher integrity verification; do not disable certificate checks to work around network problems.

## Verification and limitations

Each setup task must record real Linux versions, executable locations, positive/negative checks and rollback. The JDK installer pins a hash even though Oracle's current download URL contains `latest`: a changed artifact fails closed and needs a reviewed pin update. A checksum retrieved from the same publisher is an integrity check, not an independent authenticity audit. Review Oracle's acquisition terms; no commercial support/redistribution entitlement is inferred.

No application is runnable yet, no Kafka server is started during P1 tool setup, and WSL/systemd availability does not prove Docker, network or future integration behavior. Developer tools are not production security controls. The remaining P1 tasks and later phases provide the actual checks.

## References

- [Microsoft: filesystem location and Linux performance](https://learn.microsoft.com/en-us/windows/wsl/filesystems).
- [Oracle Java downloads](https://www.oracle.com/java/technologies/downloads/) and [No-Fee Terms](https://www.oracle.com/downloads/licenses/no-fee-license.html).
- [Java baseline](0004-java-spring-versions.md), [P1-013 learning](../../learning-notes/P1/P1-013.md).
