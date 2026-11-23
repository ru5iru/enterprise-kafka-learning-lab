# P0-021 - Estimate events per user

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Action and multiplicity assumptions

Each active actor submits **one synthetic order every 300 seconds** on average, with staggered timing rather than a synchronized burst. Baseline outcomes are successful and use the accepted parallel flow.

| Per successful order | Count | Interpretation |
|---|---:|---|
| OrderCreated records | 1 | Published by Order |
| PaymentCompleted records | 1 | Published by Payment |
| InventoryUpdated records | 1 | Published by Inventory |
| Total produced Kafka records | 3 | Broker ingress before replication |
| Relevant consumer deliveries | 4 | Two OrderCreated subscriptions plus two Notification outcome deliveries |
| Local synthetic notifications | 2 | Observed effects, not additional Kafka publications |

Per active actor, order rate is 1/300 orders/s and Kafka publication rate is 3/300 = 0.01 records/s. A 30-minute steady interval implies six orders per active actor under this deterministic average model; the generator must record warm-up and scheduling effects rather than pretend exact steady counts outside the interval.

Duplicates, retry traffic, rejection contracts, DLT/replay, CDC envelope traffic and telemetry are not included in these normal-path rates. Those scenarios must declare added or missing records and downstream effects. Exact serialization and payload limits are defined separately; no event schema or generator is implemented.

## Evidence

See [task learning record](../learning-notes/P0/P0-021.md) and [document review](../testing/evidence/P0-021-review.md).
