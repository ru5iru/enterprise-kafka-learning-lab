# P0-020 - Estimate concurrent users

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Baseline assumption

Use **5,000 simultaneously active synthetic actors**, calculated as 100,000 population x 5%. This is a chosen workload input with no real customer telemetry behind it. Active means participating in the run's action schedule; it does not mean 5,000 simultaneous in-flight HTTP requests or Kafka connections.

Keep the population at 100,000 while varying activity ratio in sensitivity studies. P0-021 supplies the time between actions, P0-022 derives rates, and P0-023 defines the peak mechanism. Do not multiply concurrency by an arbitrary requests/second constant.

Later generators must bound threads, outstanding operations and connection pools independently of logical actor count. If host resources cannot sustain this model, run and label a smaller proportional scenario and report the bottleneck. No memory, broker count or service replica estimate follows directly from 5,000 active actors.

Domain guards are 0 <= active actors <= population, with positive activity for a load run. The arithmetic and invalid-range examples are checked in evidence; no users, connections or load test are created here.

## Evidence

See [task learning record](../learning-notes/P0/P0-020.md) and [document review](../testing/evidence/P0-020-review.md).
