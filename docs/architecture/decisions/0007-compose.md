# ADR-0007: Docker Compose for local learning first

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted
- **Date:** 2026-11-24
- **Related tasks:** P0-042
- **Decision makers:** Owner baseline, formalized during authorized P0 execution.

## Context and decision

Use Docker Compose for the initial local application/Kafka environment and later bounded local multi-process experiments. P0 creates no YAML, broker configuration, volume or container. P1 verifies the actual supported host tooling; P2/P3 introduces the scheduled runtime.

## Rationale and alternatives

Compose keeps service/network/volume lifecycle inspectable for one learner and avoids Kubernetes complexity before native Kafka fundamentals. Undocumented manual processes are harder to reproduce. Kubernetes remains the advanced P13 target rather than an excluded option or initial requirement.

## Consequences

Choose exact compatible Engine/Compose/image pins at host setup; record resources and platform behavior. Separate startup from readiness/useful operations. Preserve required identities/state across declared restarts, isolate listeners, keep secrets outside Git/images, and warn before destructive volume teardown. Same-host broker replicas/controllers do not provide independent physical fault domains. Never infer security or capacity from container count.

## Validation and review

Future evidence must demonstrate clean setup, expected connectivity, negative/missing configuration, restart/state recovery, controlled faults and safe teardown. No installation/startup/recovery command ran in P0. Revisit if host constraints or the advanced deployment milestones require a documented change.

## Evidence

See [task learning record](../../learning-notes/P0/P0-042.md) and [document review](../../testing/evidence/P0-042-review.md).
