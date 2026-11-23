# ADR-0003: Apache Kafka with KRaft metadata

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted
- **Date:** 2026-11-24
- **Related tasks:** P0-038
- **Decision makers:** Project owner baseline; formalized by the executing agent.

## Context

Kafka is the subject of the lab, not interchangeable plumbing behind commerce. The roadmap explicitly chooses Apache Kafka/KRaft and native-client learning before Spring abstractions. Record replication, metadata consensus, client delivery semantics and business side effects need separate evidence.

## Decision

Use Apache Kafka with KRaft, without a ZooKeeper deployment. Start with the small P3 lab and evolve to the documented advanced replicated multi-broker/controller experiments. Study native Java clients before Spring Kafka. Preserve ADR-0001's independent Payment/Inventory subscriptions.

## Rationale and alternatives

| Option | Learning implication | Disposition |
|---|---|---|
| Kafka/KRaft | Teaches target record, partition, group, storage and metadata behavior | Selected, as already agreed |
| ZooKeeper-based Kafka | Adds a separate coordination system outside the selected progression | Rejected for this baseline |
| Another broker or framework-only abstraction | Different semantics or hidden native behavior | Does not satisfy the Kafka-first objective |

## Consequences

Exact Kafka/client versions, supported quorum provisioning mode, image pins and configuration must be checked at implementation. Local combined roles may simplify learning but couple failure/scaling; same-host redundancy is not independent host availability. Retention is not backup, and Kafka transactions do not automatically make external effects exactly once.

## Validation and review

P3 proves first-flow observations; P5 studies broker/replica/quorum failure; P6 verifies delivery and side effects; P9/P12/P13 add security/recovery/deployment evidence. This ADR is documentary selection, not a running cluster or tested compatibility matrix. Revisit on support/compatibility changes or a documented architectural need.

## Evidence

See [task learning record](../../learning-notes/P0/P0-038.md) and [document review](../../testing/evidence/P0-038-review.md).
