# P0-023 - Define peak multiplier

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Peak definition

The peak is **4x baseline**, or **200 produced Kafka records/s**, for **10 minutes**. Keep 5,000 active actors and three records per successful order, changing only the average action interval from 300 to 75 seconds. This gives 200/3 orders/s and 800/3 relevant consumer deliveries/s.

Use a declared five-minute warm-up, a 30-minute baseline observation, the ten-minute peak, then return to baseline and observe backlog recovery. These durations are planning inputs, not completed measurements. Peak-only ideal publications are 200 x 600 = 120,000 records; transitional effects must be reported, not forced to match an ideal count.

Preserve payload, key distribution, outcome mix and topology for the controlled comparison. Separate experiments may vary those factors, but must be labeled. Record input/acknowledgement/completion rates, errors, latency, resource use and lag before/during/after the peak. Bound the generator to the isolated host's safe resources; if it saturates, report the reduced scale and bottleneck rather than expanding infrastructure without review.

This peak is not assumed to run all day, and it does not prove the 100,000 population is concurrently active. Retention sizing may use an all-peak-duration bound explicitly as a conservative sensitivity case.

## Evidence

See [task learning record](../learning-notes/P0/P0-023.md) and [document review](../testing/evidence/P0-023-review.md).
