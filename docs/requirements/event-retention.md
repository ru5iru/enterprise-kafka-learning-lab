# P0-025 - Define event retention

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Retention and replay policy

Model **24 hours** of time-based retention for normal OrderCreated, PaymentCompleted and InventoryUpdated streams. P0 does not create topic settings. Broker segment cleanup timing, per-topic overrides and client behavior must be studied when configured. The initial teaching case uses deletion-oriented event history; compaction is a separate P5 experiment and cannot be substituted for a complete time-history guarantee.

| Modeled values only | Logical bytes | Three-copy advanced sensitivity |
|---|---:|---:|
| 50 records/s x 1024 B x 86400 s | 4,423,680,000 | 13,271,040,000 |
| 200 records/s for an entire day (upper sensitivity, not the ten-minute peak profile) | 17,694,720,000 | 53,084,160,000 |

The three-copy calculation illustrates advanced replication cost; the single-broker P3 lab cannot supply three independent replicas. These are decimal byte counts, not provisioned disk sizes. Exclusions include keys/headers/framing, indexes, segment granularity, logs, internal topics, schemas/CDC envelopes, DLT/retry traffic, PostgreSQL, backups, temporary replication/recovery headroom and filesystem overhead. No compression benefit is assumed.

DLT/retry/internal topic retention and sensitive evidence retention require separate task-level policies. A consumer interruption beyond this replay horizon cannot be promised complete recovery from the live log. Retention, replication and backup are distinct; P12 restore drills must validate the selected recovery path. Hardware sizing remains unverified.

## Evidence

See [task learning record](../learning-notes/P0/P0-025.md) and [document review](../testing/evidence/P0-025-review.md).
