# P0-026 - Define latency objectives

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Provisional learning objectives

| Regime | Boundary | Objective |
|---|---|---|
| Baseline 50 records/s | Valid synthetic request start to explicit accepted/publication result under the chosen send policy | p95 <= 250 ms |
| Baseline | Request start to observation of both successful branch outcome events | p95 <= 2 s; p99 <= 5 s |
| Peak 200 records/s | Same both-outcome boundary, reported separately | p95 <= 5 s; p99 <= 10 s |

Both-outcome observation is a measurement over correlated events, not an added synchronous service dependency or a global business transaction. Local notification timing may be reported separately. Use a monotonic clock within the generator/observer when possible; disclose clock synchronization and sampling limits for cross-process timestamps.

Measure after five-minute warm-up across the modeled 30-minute baseline and ten-minute peak windows. Record sample counts, histogram/percentile method, missed/failed/timed-out operations, errors, lag and environment. A single observed outlier is not itself a calculated p99; the numerical boundary fixture only checks threshold comparisons. Do not exclude failed/missing outcomes from the report or manufacture a finite completion time for them.

These targets are chosen lab hypotheses, not measured results, customer SLAs or proof that current hardware can meet them. P11 must measure feasibility and record justified changes before claiming acceptance. Existing ordering, correctness and security obligations remain applicable; performance does not justify weakening them.

## Evidence

See [task learning record](../learning-notes/P0/P0-026.md) and [document review](../testing/evidence/P0-026-review.md).
