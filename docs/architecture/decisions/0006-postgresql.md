# ADR-0006: PostgreSQL with exclusive service data ownership

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted
- **Date:** 2026-11-24
- **Related tasks:** P0-041
- **Decision makers:** Owner baseline, formalized during authorized P0 execution.

## Context and decision

Use PostgreSQL when P8 introduces persistence. Order, Payment and Inventory exclusively own their data, migrations, credentials and publication intent. No service directly reads/writes another service's tables. Notification remains a local synthetic outcome observer; this ADR does not add a mandatory shared Notification database.

Use local transactions for entity/Outbox state as designed, then study eventual publication through the scheduled publisher/CDC path. Kafka publication and independent consumer effects do not acquire global atomicity from that local transaction.

## Rationale and alternatives

PostgreSQL is already selected and supports the relational transaction/migration/Outbox experiments. A shared business database simplifies queries but violates the desired service boundaries. Additional database products add unrelated operational learning. A presumed database/Kafka distributed transaction hides the exact failure windows the lab must explain.

## Consequences

Select exact supported PostgreSQL, JDBC, Flyway, Connect and Debezium versions together at P8 with official compatibility evidence and pins; do not treat a current manual heading as tested connector support. Dedicated roles, safe migrations, protected access, backups and restore validation are required when implemented. Co-located infrastructure does not grant cross-service table permissions.

## Validation and review

P8/P9 test local transaction success/rollback, publisher restart, CDC replay, forbidden cross-service access and compensation. P12 restores and reconciles owned data/publication intent. None of those runtime tests or database configurations exists in P0. Revisit on consistency, support or capture-compatibility changes.

## Evidence

See [task learning record](../../learning-notes/P0/P0-041.md) and [document review](../../testing/evidence/P0-041-review.md).
