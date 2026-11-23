# P0-004 - Identify in-scope technologies

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Inventory and decision status

The [scope boundaries](scope-boundaries.md) and approved roadmap determine admission. Selected means an existing project choice, not a deployed capability. No versions are selected in this task.

| Technology / capability | Learning role | Introduction | Decision status / limit |
|---|---|---|---|
| Git and monorepo documentation | Task-sized history, review, traceability | P0-P1 | Agreed workflow; no new hosting platform |
| Java and Maven | Independent service builds, immutable events, tests | P1-P2; native Kafka P3 | Selected; exact JDK/build-tool versions follow owning tasks |
| Spring Boot and Spring Kafka | Application conventions and framework messaging after native clients | P2 and later P3 | Selected; compatible versions require P0-039 review |
| Apache Kafka in KRaft mode, Kafka CLI/AdminClient | Records, partitions, groups, replication, metadata control | Single broker P3; advanced cluster P5 | Selected; no ZooKeeper deployment, broker topology/config here |
| Docker/Compose | Reproducible isolated local runtime | P1 tooling; runtime P2-P3 onward | Selected local-first approach; no stack generated in P0 |
| JUnit, Mockito, Testcontainers | Unit boundaries and realistic integration evidence | P2 onward as applicable | Roadmap testing approach; test/tool versions selected with builds |
| Schema registry and event serialization/contracts | Compatible independent event evolution | P7 | Capability in scope; format/registry product selected in P7 |
| PostgreSQL and Flyway | Service-owned relational persistence and migrations | P8 | PostgreSQL selected; exact version and migration setup later |
| Kafka Connect and Debezium | Outbox/CDC integration experiments | P8 | Baseline integration direction; compatible connector versions later |
| TLS, mTLS, SASL/SCRAM, Kafka ACLs, lab PKI/secrets | Distinct transport, identity, permission, lifecycle controls | Requirements/design P0; runtime P9 | Progressive controls; no credentials or chosen secret provider here |
| Actuator/JMX, Prometheus/Grafana, OpenTelemetry, logs | Metrics, dashboards, traces, and diagnosis | Basic signals earlier; full P10 | Baseline observability direction; log backend/exporter versions later |
| Load generation and fault/recovery tooling | Workload measurement and controlled disruption | P11-P12 | Capability in scope; tool/resource choices follow experiment tasks |
| Kubernetes, Helm, supported Kafka operator | Declarative advanced deployment and lifecycle | P13 | Kubernetes/Helm direction agreed; operator selected after support review |
| CI builds, SAST/SCA, secret/image scanning, SBOM and release verification | Automated SSDLC evidence and release gates | Basic CI P1; full gates P14 | Capabilities in scope; concrete scanners and pins chosen later |

## Consequences and admission rules

Keep service builds independent; do not create a shared mutable business library just because the repository is shared. Native Kafka learning must precede Spring abstractions. PostgreSQL/CDC appears only when consistency experiments require it. Kubernetes is an advanced milestone, not a replacement for local Compose learning. Security review and secret hygiene start now even though runtime controls are progressive.

An unlisted technology needs a concrete existing learning need, alternatives, maintenance/security cost, compatible versions, and a task-scoped decision before introduction. The architecture blueprint's optional Terraform or service-mesh paths do not mandate early cloud provisioning or mesh installation. No new platform or mandatory product is selected by this inventory. Exact versions, licensing/support applicability, pinned dependencies/images, and supply-chain checks must be verified at implementation.

## Deferred detail

P0-005 elaborates excluded functionality. P0-037-P0-045 record the scheduled core ADRs; P7 owns registry/format selection, and P13 owns supported operator/deployment choices. This file is a planning inventory with no installation, compatibility test, or production readiness claim.

## Evidence

See [task learning record](../learning-notes/P0/P0-004.md) and [document review](../testing/evidence/P0-004-review.md).
