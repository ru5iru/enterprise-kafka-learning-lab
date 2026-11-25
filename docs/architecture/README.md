# Architecture work products

These P0 outcomes are planning artifacts; they are not deployed components. The [original conceptual blueprint](../roadmap/ARCHITECTURE.md) remains the historical baseline.

- [Target architecture](target-architecture.md), [system context](system-context.md), [logical component diagram](logical-component-diagram.md).
- [Service boundaries](../requirements/microservice-boundaries.md), [communication matrix](../requirements/communication-matrix.md), [sync/async choices](../requirements/sync-async-messaging.md).
- [Trust boundaries](../security/trust-boundaries.md) and [initial STRIDE model](../security/initial-stride-model.md).

## Decisions

Use the [ADR process](decisions/README.md) and [template](decisions/0000-template.md) when a significant decision is actually made. Existing decisions:

1. [Parallel Payment/Inventory flow](decisions/0001-parallel-payment-inventory.md).
2. [Monorepo and independent builds](decisions/0002-monorepo.md).
3. [Kafka/KRaft](decisions/0003-kafka-kraft.md).
4. [Java/Spring Boot version decision](decisions/0004-java-spring-versions.md).
5. [Maven](decisions/0005-maven.md).
6. [PostgreSQL](decisions/0006-postgresql.md).
7. [Compose](decisions/0007-compose.md).
8. [Kubernetes](decisions/0008-kubernetes.md).
9. [Progressive security](decisions/0009-progressive-security.md).
10. [Observability](decisions/0010-observability.md).
11. [Windows checkout and WSL runtime](decisions/0011-wsl-development-runtime.md).
12. [WSL container runtime](decisions/0012-wsl-container-runtime.md).
13. [Tooling-only build verification](decisions/0013-p1-build-verification.md).
14. [CI trust and evidence](decisions/0014-ci-trust-and-evidence.md).
15. [Independent non-web Spring Boot starter](decisions/0015-minimal-spring-boot-starter.md).

Version choices have dated sources and compatibility limits. P1 installs/verifies the WSL development tools and CI tooling module. P2-014 adds a local non-web Spring Boot starter; Kafka broker, business services, database and deployment remain future work. Update affected diagrams and task learning notes when behavior changes; do not silently rewrite the original roadmap. Return to [documentation index](../README.md).
