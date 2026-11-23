# P0-033 - Inventory Kafka infrastructure

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Infrastructure inventory

| Item | Introductory P3 | Advanced P5 onward | Evidence obligation |
|---|---|---|---|
| Broker/data plane | One broker serving the first topic | Baseline conceptual three-broker replicated lab | Topic metadata, leadership/ISR, record and restart observations |
| KRaft metadata plane | Simplified local role arrangement when configured | Odd controller quorum and reviewed role placement; baseline diagram shows three controllers | Quorum membership, majority-loss/recovery and identity evidence |
| Topics/partitions/groups/offsets | One explicit topic and named test group | Reviewed partitions, replicas, policies, retries/DLT and consumers | No unreviewed auto-creation; describe configuration and semantics |
| Storage/identity | Persist where the exercise requires it; explicit reset warning | Stable node/cluster identity and record/metadata storage | Restart/recovery, retention and corruption/loss boundaries |
| Listeners/network | Isolated reachable lab addresses | Separate reviewed client/inter-broker/controller paths | Connectivity and later trust/authorization tests |
| Administration | CLI/AdminClient scoped to the exercise | Reviewed privileged operations and audit/recovery procedures | No routine application superuser assumption |
| Contracts/integration | Not required for the first record | Registry P7; Connect/CDC P8 | Independent product/compatibility/security verification |
| Security/operations | Hygiene and useful diagnostics | P9 identities/TLS/ACLs; P10 telemetry; P12 recovery | Planned protection is not current protection |

The existing target diagram is retained. Precise broker/controller co-location, static/dynamic quorum provisioning, log paths, ports, replica/minimum-ISR settings, images and hardware are not configured in P0. Kafka documentation notes that combined roles simplify development but reduce controller isolation; critical deployment assumptions must not be copied from a small combined lab.

Three-copy storage in P0-025 is a sensitivity estimate, not a deployment or unconditional durability guarantee. Multiple local processes still share host failure risk. Capture actual topology and version-specific behavior when P3/P5 executes; no broker or infrastructure file is created now.

## Evidence

See [task learning record](../learning-notes/P0/P0-033.md) and [document review](../testing/evidence/P0-033-review.md).
