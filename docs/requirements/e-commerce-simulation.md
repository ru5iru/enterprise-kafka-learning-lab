# P0-006 - Define e-commerce simulation

**Date:** 2026-11-24
**State:** Reviewed planning decision; parallel flow approved by the project owner on 2026-11-24. No runtime implementation or measured results.

## Actors, data, and invariants

The actors are a learner/load generator and the conceptual Order, Payment, Inventory, and Notification services already in the roadmap. Use synthetic order IDs, event IDs, item references, positive quantities, and a fake amount/unit. Real names, addresses, cards, stock, accounts, and recipients are excluded. Exact field schemas, amount representation, validation limits, and serialization belong to their requirements/contract tasks.

- Every experiment identifies its synthetic order and inputs so observations can be reconciled.
- Payment and Inventory consume OrderCreated independently in distinct consumer groups. Neither completion implies cross-service atomicity.
- A notification records one received branch outcome locally. It does not claim global checkout completion or actual delivery to a person.
- Initial behavior is transient unless its phase explicitly adds persistence; database durability, retries, deduplication, and compensation are not assumed.

## Selected normal flow - parallel branches

1. The learner submits a minimal synthetic order; Order validates it and emits the planned `OrderCreated` event when accepted. Exact API/acknowledgement behavior is defined in the requirements tasks.
2. Independent Payment and Inventory consumer groups receive the event. A configured successful fake payment produces `PaymentCompleted`; a successful fake inventory update produces `InventoryUpdated`.
3. Notification observes those branch events and records separate synthetic notifications with their source identifiers. It makes no synchronous dependency on both branches completing together.

These are the existing architecture's conceptual event names, not new topic names or schemas. P7 governs contracts; P8 studies durable local transactions, Outbox/CDC, and compensating workflows.

## Deterministic scenario catalogue

| Scenario | Controlled input/fault | Expected observation to verify later |
|---|---|---|
| S1 normal | Both branch outcomes configured successful | Order event, independent branch results, two local outcome notifications |
| S2 invalid order | Invalid quantity or required identifier absent | Rejection before an accepted-order event; actual validation policy/test later |
| S3 payment rejection | Fake payment policy rejects | No successful payment-completion claim; Inventory can still succeed independently. Explicit rejected outcome/error handling must be designed in its task |
| S4 inventory unavailable | Fake stock outcome rejects | No successful inventory-update claim; payment may already have succeeded |
| S5 consumer interruption | Stop one branch after baseline | The other branch can progress independently. Inspect pending/replayed records after recovery |
| S6 duplicate delivery | Replay a known event under controlled policy | Count record deliveries separately from fake effects; later idempotency work compares outcomes |
| S7 malformed/poison record | Inject invalid contract input in its isolated test | Distinguish transport/contract failure from expected business rejection; bounded retry/DLT behavior only once introduced |
| S8 late compensation | Trigger the scheduled P8 workflow failure | Observe fake compensating actions and residual states; no global database rollback assumption |

Expected business rejections need explicit outcome contracts in their implementation task. Do not overload `PaymentCompleted` with a rejected payment or invent a final success status merely to close the flow. The catalogue defines questions and invariants, not an early event-schema implementation.

## Teaching progression and consequences

P3 first demonstrates a single producer/consumer message without splitting services. P4 adds this minimal independent flow; P6 measures failures, retries, and duplicate effects; P7 governs contracts; P8 introduces local persistence/Outbox/CDC/compensation. The cost is deliberately incomplete commerce behavior, with the benefit of interpretable experiments and no real financial or communication effects. P0-007 inventories the logical components next.

## Evidence

See [task learning record](../learning-notes/P0/P0-006.md) and [document review](../testing/evidence/P0-006-review.md).

## Resolved source conflict

The owner selected the parallel-flow recommendation on 2026-11-24. [ADR-0001](../architecture/decisions/0001-parallel-payment-inventory.md) records the alternatives, consequences, and interpretation of P4-019/P4-020. The original roadmap is preserved; its task prerequisite chain describes study order, while runtime Inventory consumes OrderCreated independently of Payment.
