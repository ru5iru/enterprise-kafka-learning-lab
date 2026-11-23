# P0-022 - Define baseline events per second

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Derived baseline

Using P0-020/P0-021: 5,000 active actors / 300 seconds = 50/3 orders/s. Multiply by three produced records/order to obtain **50 Kafka records/s**. The four relevant deliveries/order imply **200/3 consumer deliveries/s**, approximately 66.667.

Payment and Inventory each process 50/3 OrderCreated deliveries/s; Notification processes 100/3 outcome deliveries/s. At 1,800 seconds of ideal steady load, the model produces 30,000 orders and 90,000 Kafka records. These are expected scheduling/model counts, not observed results.

The baseline excludes replication, retry/replay/DLT/CDC overhead and telemetry. P0-024/P0-025 add byte and retention assumptions. Round only presentation values; preserve fractions in calculations. A zero-active-actor input produces zero modeled load; a zero action interval is invalid and must never be treated as zero traffic.

Future acceptance requires sustaining the declared arrival rate while accounting for acknowledged/completed/failed work, latency and backlog. A producer hitting 50 sends/s with a growing consumer backlog does not demonstrate the model is sustainably supported.

## Evidence

See [task learning record](../learning-notes/P0/P0-022.md) and [document review](../testing/evidence/P0-022-review.md).
