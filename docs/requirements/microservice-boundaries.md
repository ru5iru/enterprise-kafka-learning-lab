# P0-030 - Identify microservice boundaries

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Boundary matrix

| Domain | Owns | Inputs / outputs | Must not own or access |
|---|---|---|---|
| Order | Synthetic input validation, order identity, later Order data and publication intent | Request -> OrderCreated | Payment/Inventory tables or hidden global transaction |
| Payment | Fake payment decision, later Payment data and local publication intent | OrderCreated -> truthful payment outcome | Real provider effects, Inventory state, shared checkout commit |
| Inventory | Fake stock decision, later Inventory data and local publication intent | OrderCreated -> truthful inventory outcome | Payment dependency or direct Payment database access |
| Notification | Local per-outcome synthetic notification records | PaymentCompleted / InventoryUpdated -> local observation | Real recipient delivery or unproven global completion |

## Dependency and evolution rules

Payment and Inventory consume OrderCreated in distinct groups under ADR-0001. They can each be unavailable without creating a synchronous dependency in the other. Notification observes each branch outcome; it is not a new saga coordinator. P8 owns the explicit compensating workflow experiment and its residual-state reasoning.

Build/package/deploy services independently using Maven. Keep event schemas and compatibility policy reviewable; do not share mutable business model libraries to evade contract evolution. Shared test/technical conventions need a concrete stable use case and explicit impact review. Domain data may use the same local database infrastructure for learning only if separate ownership/credentials/access remain enforced; no shared business table contract follows.

A producer or consumer is a capability and does not by itself require a separate service. Exact APIs, schemas, migrations, identities and storage configuration remain assigned to implementation tasks. Review rejects any cross-service SQL access and traces partial failures without claiming atomic multi-service checkout.

## Evidence

See [task learning record](../learning-notes/P0/P0-030.md) and [document review](../testing/evidence/P0-030-review.md).
