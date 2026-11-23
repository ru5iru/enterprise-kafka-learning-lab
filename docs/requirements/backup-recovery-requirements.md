# P0-017 - Define backup and recovery requirements

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Recovery requirements

| ID | Requirement | Verification direction |
|---|---|---|
| DR-01 | Inventory Kafka records/configuration/identity, service PostgreSQL data including Outbox, contract/config versions and required recovery metadata | Asset-specific backup/restore and retention matrix in P12 |
| DR-02 | Distinguish broker loss, quorum loss, database loss, bad change and whole-cluster loss | State which scenario replication, restart, backup or cross-cluster recovery addresses |
| DR-03 | Define recovery points consistent with local database transactions and publication intent | Entity/outbox reconciliation and duplicates/gaps accounted for |
| DR-04 | For the later isolated durable-lab restore exercise, target RPO <= 5 minutes and RTO <= 30 minutes provisionally | Timestamped recovery-point and useful-flow measurements; disclose unmet targets |
| DR-05 | Protect backup access, sensitive material and destructive restore operations | Isolated restore destination, least privilege, redacted evidence and key/secret recovery plan |
| DR-06 | Test restoration rather than merely backup creation | Restart restored services, process known synthetic events, compare state/counts/identifiers |
| DR-07 | Document bounded replay, duplicate effects, dependency order, rollback and residual loss | Runbook rehearsal with expected/observed outcomes |

## Assumptions and consequences

The numerical RPO/RTO values are planning choices for a learning exercise, not achieved service guarantees. They assume durable stages exist, a small synthetic dataset and available isolated restore resources. They do not apply to the intentionally transient P3/P4 starter or imply cross-region disaster readiness. Revisit them in P12 if hardware or the chosen recovery class makes them unsuitable; record the revised decision and actual results.

Replication is not a substitute for backup or restore validation. Database ownership remains local; no global cross-service consistent snapshot is promised. Certificate/secret recovery must not place private material in Git or raw evidence. No backup, restore, replication or recovery command is executed by P0.

## Evidence

See [task learning record](../learning-notes/P0/P0-017.md) and [document review](../testing/evidence/P0-017-review.md).
