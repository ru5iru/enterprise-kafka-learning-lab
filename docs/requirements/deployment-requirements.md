# P0-016 - Define deployment requirements

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Deployment requirements

| ID | Requirement | Future verification |
|---|---|---|
| DEP-01 | Reproduce setup with declared tool/runtime versions and resource prerequisites | Clean-checkout setup with sanitized environment manifest |
| DEP-02 | Use isolated local Compose first, with only required host exposure | Inspect listeners/networks/volumes and test intended connectivity |
| DEP-03 | Validate configuration, distinguish liveness/readiness, and bound startup/failure behavior | Invalid/missing config and unavailable-dependency cases |
| DEP-04 | Persist required broker/database state across the documented restart path | Restart and verify identities, records, offsets and database state |
| DEP-05 | Keep secrets outside Git/images and apply progressive identities/permissions | Secret hygiene plus later allowed/denied tests |
| DEP-06 | Document migration, upgrade, rollback, backup and teardown consequences | Safe rehearsal, explicit data-loss warning for destructive cleanup |
| DEP-07 | Use supported operator/Helm Kubernetes only in P13 with resource, storage, RBAC and network controls | Deployment/restart/rollout and negative-policy evidence |
| DEP-08 | Build and deploy services independently using reviewed pins | Focused build/artifact provenance and deployment checks |

## Progression and limits

P0 defines plans only. P1 establishes tools, P2-P3 starts local workloads, P5 expands Kafka topology, and P13 studies Kubernetes. No cloud provider, public hostname, operator product, image tag, volume path or manifest is selected here. The lab is not a production hosting commitment.

A passing start command cannot prove durable recovery or network protection. Exact configuration and support compatibility must be checked when implemented. Document reduced-resource experiments honestly; do not create public insecure endpoints to simplify client access.

## Evidence

See [task learning record](../learning-notes/P0/P0-016.md) and [document review](../testing/evidence/P0-016-review.md).
