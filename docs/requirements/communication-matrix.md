# P0-031 - Create communication matrix

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Planned communication matrix

| Source -> destination | Data / purpose | Coupling | Target control and milestone |
|---|---|---|---|
| Learner/generator -> Order | Validated synthetic request and explicit result | Synchronous HTTP boundary | Input bounds and isolated exposure; application/transport policy as introduced |
| Order -> Kafka | OrderCreated | Asynchronous publication with explicit acknowledgement/error policy | Producer identity, TLS/authentication and write ACL at P9 |
| Kafka -> Payment group | OrderCreated | Independent subscription | Read/group privileges scoped to need |
| Kafka -> Inventory group | OrderCreated | Independent subscription, not payment-gated | Separate read/group identity policy |
| Payment/Inventory -> Kafka | Own successful outcomes and later specified failure contracts | Asynchronous | Truthful contract, producer identity/write permission |
| Kafka -> Notification | Branch outcomes | Independent outcome consumption | Restricted read/group rights; fake local effects |
| Each stateful service -> own PostgreSQL | Local data/migrations/outbox | Local transaction over DB protocol | Dedicated ownership/role and protected transport as introduced |
| Publisher/Connect -> Kafka | Owned publication intent/change capture | Eventual publication | Scoped connector/database/topic rights P8/P9 |
| Brokers/controllers <-> Kafka peers | Record replication and metadata consensus | Data/control infrastructure | Explicit listener trust/identity policies P5/P9 |
| Clients -> registry | Governed schemas/compatibility | Contract support | Product/protocol/permissions selected P7/P9 |
| Operator/CI -> infrastructure/artifacts | Administrative lifecycle | Privileged management | Least privilege, audit/secret/provenance review |
| Services/cluster -> telemetry | Metrics/logs/traces | Supporting observations | Redaction, bounded volume/access P10 |

This is a conceptual interface inventory, not deployed routes, port assignments, credentials or ACL configuration. No implicit Payment-to-Inventory business call or cross-service SQL interface is permitted. TLS, authentication and authorization remain distinct controls, and every target protection is unimplemented until its scheduled verification.

Review normal event delivery and a forbidden cross-service database/administrative action. Add a new crossing only after documenting its ownership, data, threat, protocol, coupling and test consequences. P0-032 formalizes sync/async decisions; P0-035/P0-036 assess the trust boundaries and threats.

## Evidence

See [task learning record](../learning-notes/P0/P0-031.md) and [document review](../testing/evidence/P0-031-review.md).
