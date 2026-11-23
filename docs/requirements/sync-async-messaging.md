# P0-032 - Define sync versus async messaging

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Interaction choices

| Interaction | Choice | Reason / limit |
|---|---|---|
| Learner/generator -> Order | Bounded synchronous request/result | Validate input and report explicit acceptance/publication result or error; not final checkout |
| Order -> Kafka | Asynchronous event publication with explicit send-result policy | Decouple processing; acknowledge/error/uncertain outcomes must be visible |
| OrderCreated -> Payment and Inventory | Asynchronous distinct subscriptions | Owner-approved parallel independence under ADR-0001 |
| Branch outcomes -> Notification | Asynchronous per-outcome consumption | Fake individual notifications; no barrier implying all-or-nothing completion |
| Service -> own database | Local transactional interaction when P8 is introduced | Atomic local state/publication intent as designed; not global multi-system atomicity |
| Administrative/schema/telemetry support | Explicit task-level protocol and failure policy | No hidden business dependency or unlimited startup/retry loop |

## Failure and consistency implications

A slow or stopped consumer accumulates pending work within retention and resource limits; producer success alone does not establish downstream success. Rebalances, retries, duplicate delivery and poison events require explicit P6 experiments. Local PostgreSQL and Kafka publication are separate boundaries; P8 studies Outbox/CDC and compensation rather than assuming a distributed commit.

Do not implement a synchronous Payment-to-Inventory call or wait for PaymentCompleted to trigger Inventory. Request timeouts and uncertain producer outcomes must be reported and reconciled using stable identifiers and the later bounded idempotency/retry design. Per-partition ordering must not be promoted to global event ordering.

Exact request timeouts, send acknowledgements, commit/retry settings and event contracts are implementation decisions with their own evidence. P0-026 gives measurement objectives rather than hard-coded client configuration. Positive/negative review checks truthful request results and independent branch progress; no messaging runtime has been executed here.

## Evidence

See [task learning record](../learning-notes/P0/P0-032.md) and [document review](../testing/evidence/P0-032-review.md).
