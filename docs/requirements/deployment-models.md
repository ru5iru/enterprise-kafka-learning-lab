# P0-034 - Define deployment models

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Deployment models

| Model | Purpose and entry | State/control expectations | Limits |
|---|---|---|---|
| Introductory local Compose | P2/P3 starter and first native/Spring flow | Explicit isolated network, volumes/reset policy, configuration and diagnostic output | One broker has no broker redundancy; runtime security is progressive |
| Advanced local Compose | P5-P12 replication, consistency, security, telemetry, performance and recovery experiments | Reviewed multi-process topology, owned PostgreSQL stores, controlled faults and evidence | Same-host replicas/controllers share a physical failure domain; resource contention affects measurements |
| Kubernetes/operator/Helm | P13 after local capability/security foundations | Supported compatibility, persistent identity/storage, probes, requests/limits, RBAC/network policy/secrets, safe rollout | A local Kubernetes cluster is not a production or multi-region qualification |
| CI verification environment | Basic P1, full P14 | Independent builds, test/scanning/release gates and artifact provenance | A green omitted gate proves nothing; ephemeral environments cannot imply durable operation |

No cloud provider, managed service, paid resource, cluster distribution, operator version, namespace manifest or host sizing is selected here. Exact compatible products and resource prerequisites belong to the deployment tasks.

For every model record setup/start/readiness, synthetic useful operation, restart/state validation, permitted/denied access, rollback, recovery, and explicit destructive teardown consequences. Environment differences must be documented rather than hidden behind a single success label. Failure experiments remain bounded and isolated; intentionally insecure learning services cannot be exposed publicly.

This elaborates the existing Compose-to-Kubernetes decision; scheduled ADRs P0-042/P0-043 record the formal technology rationale. No deployment is performed in P0.

## Evidence

See [task learning record](../learning-notes/P0/P0-034.md) and [document review](../testing/evidence/P0-034-review.md).
