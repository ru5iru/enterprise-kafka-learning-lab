# ADR-0008: Progressive supported operator-managed Kubernetes deployment

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted
- **Date:** 2026-11-24
- **Related tasks:** P0-043
- **Decision makers:** Owner baseline, formalized during authorized P0 execution.

## Context and decision

Introduce Kubernetes/Helm and a supported Kafka operator in P13, after local Compose, Kafka internals, security, observability and recovery learning. Do not create manifests, acquire cloud resources or choose an operator version in P0.

## Rationale and alternatives

Operator-managed stateful lifecycle is useful advanced enterprise learning. Starting with it would conceal client/broker fundamentals and multiply early variables. Remaining forever on Compose would omit the agreed advanced deployment goal. A local Kubernetes lab can teach orchestration but does not establish multi-host/region production availability.

## Consequences

At P13 select mutually supported Kubernetes/operator/Kafka/Helm/storage versions and pins, with an explicit resource/failure-domain model. Protect administrative and workload identities with scoped RBAC, network policy and secret handling. Validate persistent identity/storage, probes, resource limits, safe upgrades/rollback and recovery. Do not treat a green pod as proof of state correctness or an enforced network policy without a denied case.

## Validation and review

Future evidence includes deployment state, independent rollout, broker restart with retained data/identity, useful synthetic operations, forbidden access and recovery observations. No cluster or runtime policy exists in P0. Revisit on support changes or measured platform constraints.

## Evidence

See [task learning record](../../learning-notes/P0/P0-043.md) and [document review](../../testing/evidence/P0-043-review.md).
