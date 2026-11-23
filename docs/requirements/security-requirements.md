# P0-013 - Define security requirements

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Security requirements

| ID | Obligation | Verification / milestone |
|---|---|---|
| SEC-01 | Use synthetic data and isolated lab resources; never commit operational secrets, keys, keystores or sensitive logs | Manual evidence review now; automated secret scans as tooling arrives |
| SEC-02 | Identify assets, flows and trust boundaries before choosing identity/permission rules | P0-035/P0-036 diagrams and STRIDE cases |
| SEC-03 | Protect network transport and validate peer trust with the selected TLS/mTLS policies | P9 permitted connections and untrusted/expired-certificate rejection |
| SEC-04 | Authenticate Kafka clients and restrict each identity to required topic/group/admin operations | P9 identity/ACL matrix, permitted and denied operations |
| SEC-05 | Separate service-owned database identities and permissions | P8/P9 owned data access and rejected cross-service access |
| SEC-06 | Bound retries, replay, payloads, concurrency and exposed administration | P6/P11/P13 abuse/failure cases and resource limits |
| SEC-07 | Manage certificate/credential issuance, expiration, rotation and recovery without repository secrets | P9 lifecycle drill with sanitized evidence |
| SEC-08 | Pin reviewed compatible dependencies/images and evaluate findings | Foundational hygiene during builds; full SAST/SCA/SBOM/release gates P14 |
| SEC-09 | Limit Kubernetes workload/network/administrative privileges | P13 RBAC/network/secret and negative-policy tests |
| SEC-10 | Redact logs, headers, traces, errors and evidence; retain useful diagnostic identity without secret disclosure | Telemetry/evidence review across phases |

## Current versus target state

No endpoint, identity, broker, certificate, authorization policy or encrypted channel exists yet. Hygiene and document review apply now; runtime controls are progressively implemented, with Kafka security concentrated in P9, Kubernetes hardening in P13, and full release security gates in P14. Earlier phases must state their unimplemented controls and cannot expose an intentionally insecure lab to untrusted networks.

Negative tests must fail at the intended layer. Do not disable certificate checks, use broad permissions, print credentials, or use real secrets to make a test convenient. Keep findings and residual risk visible; this plan is not a vulnerability scan or compliance assessment.

## Evidence

See [task learning record](../learning-notes/P0/P0-013.md) and [document review](../testing/evidence/P0-013-review.md).
