# P0-010 - Define performance requirements

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Performance requirements

| ID | Requirement | Planned verification |
|---|---|---|
| PERF-01 | Express workload as concurrent active actors, action rate, events/action, payload, retention and peak shape | Reproduce P0-019-P0-025 calculations with units |
| PERF-02 | Measure attempted, acknowledged, consumed, completed and failed operations separately | Reconcile counters and identifiers; do not equate sends with useful completions |
| PERF-03 | Report request/publication and end-to-end outcome latency distributions with p50/p95/p99, sample size and timing boundaries | Preserve histogram/raw summary and measurement method |
| PERF-04 | Demonstrate sustained processing at the modeled baseline and a separately specified peak | State warm-up, observation period, backlog slope, error counts and recovery |
| PERF-05 | Capture CPU/memory/disk/network constraints, partition/group settings and runtime versions | Record sanitized experiment environment and limiting resource |
| PERF-06 | Compare tuning alternatives under comparable load, changing one relevant factor at a time | Repeat baseline/control, explain variance and trade-offs |
| PERF-07 | Bound generator concurrency, retries, replay and test duration | Stop safely at the declared resource/experiment limit; never create uncontrolled load |

## Target ownership and consequences

Approximately 100,000 users remains a population hypothesis. P0-020-P0-025 define concurrency, frequency, events, rates, payload, retention and peaks; P0-026 defines numerical latency objectives. P11 supplies measured feasibility. This task specifies evidence requirements, not a hidden numeric SLO or hardware purchase.

Baseline, peak, and recovery measurements must separate producer acknowledgement from consumer/business completion. If the completion rate is lower than arrival rate and lag keeps growing, the test has not demonstrated sustainable capacity. Include failed/timed-out observations in results rather than dropping them from the latency report. No benchmark or runtime test was executed in P0.

## Evidence

See [task learning record](../learning-notes/P0/P0-010.md) and [document review](../testing/evidence/P0-010-review.md).
