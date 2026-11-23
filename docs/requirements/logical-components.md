# P0-007 - Inventory logical components

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Component inventory

| Class | Component | Responsibility / ownership | Milestone |
|---|---|---|---|
| Actor/tool | Learner and synthetic generator | Submit synthetic scenarios, bound load, collect evidence | P3 then P11 |
| Application | Order | Validate simulated input, publish OrderCreated; own later Order data | P3 starter then P4; DB P8 |
| Application | Payment | Independently consume OrderCreated, simulate payment, publish PaymentCompleted; own later Payment data | P4; DB P8 |
| Application | Inventory | Independently consume OrderCreated, simulate stock change, publish InventoryUpdated; own later Inventory data | P4; DB P8 |
| Application | Notification | Observe branch outcomes and record fake notifications; no real delivery | P4 |
| Kafka resource | Topics, partitions, replicas, groups, offsets, later DLTs | Durable streams, placement, subscriptions, progress and failure handling | P3/P5/P6 |
| Infrastructure | Broker and KRaft controllers | Record storage/serving versus metadata quorum | P3/P5 |
| Data | Independent PostgreSQL ownership and migrations | Local transactions, no cross-service table access | P8 |
| Integration | Outbox publisher, Connect/Debezium | Durable event publication and change capture | P8 |
| Contracts | Schemas and selected registry | Compatibility and independent evolution | P7 |
| Operations | Metrics/logs/traces, dashboards/alerts | Observe experiments and explain recovery | P10 |
| Security | Identities, trust stores, PKI/secrets/ACLs | Progressive transport, authentication, authorization | P9; design P0 |
| Delivery | Compose, later Kubernetes/operator/Helm and CI gates | Reproducible lifecycle and evidence | P1/P3/P13/P14 |

## Relationships and limits

ADR-0001 governs parallel Payment/Inventory subscriptions. A producer/consumer can coexist in one application; neither capability mandates a new deployment. Notification does not acquire another service's database. An observability backend or registry is supporting infrastructure, not a business domain. Event contracts may be versioned centrally without sharing mutable business implementation libraries.

This inventory elaborates the existing architecture, not a new topology choice. No process, table, broker, topic, identity, or deployment is created. P0-008 defines the target composition; sizing, exact products, schema details, and runtime verification remain deferred.

## Evidence

See [task learning record](../learning-notes/P0/P0-007.md) and [document review](../testing/evidence/P0-007-review.md).
