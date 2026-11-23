# P0-019 - Define 100,000-user scenario

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Scenario definition

The population is **100,000 synthetic registered actor identifiers** in the minimal commerce simulation. It represents the possible actor/key space, not simultaneous connections or authenticated real accounts. There is no production customer claim.

Baseline workload represents valid synthetic orders and successful fake Payment/Inventory outcomes under ADR-0001. Rejections, poison messages, duplicates and faults are separate named scenarios so their altered record/effect counts do not silently change the baseline. Notifications remain local observations, not external provider calls.

P0-020 estimates simultaneous active actors; P0-021 defines order frequency and events/order; P0-022 derives rates; P0-023-P0-025 specify peaks, payload and retention. Do not fill missing values by assuming all population members act once per second. Key distribution initially aims at uniform synthetic actors; skew/hot-key scenarios must be labeled separately in later experiments.

Record population, active concurrency, action schedule, outcome mix, ordering/key rules, duration and seed/fixture definition in a future run manifest. Actual field schemas and generator implementation remain later tasks. A smaller hardware-constrained run must disclose its scale instead of claiming the full hypothesis passed.

## Evidence

See [task learning record](../learning-notes/P0/P0-019.md) and [document review](../testing/evidence/P0-019-review.md).
