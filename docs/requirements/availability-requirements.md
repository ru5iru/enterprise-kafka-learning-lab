# P0-011 - Define availability requirements

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Availability requirements

| ID | Requirement | Verification direction |
|---|---|---|
| AV-01 | Define useful operation and success/error/timeout boundary for each service and each branch | Review denominators, probes, observation window and excluded periods |
| AV-02 | Preserve independent Payment/Inventory progress under ADR-0001 | Stop either consumer and inspect the other group's progress and accumulated lag |
| AV-03 | Surface unavailable/ambiguous publication as an explicit error or documented uncertain result | Broker connectivity failure with request/send outcome evidence |
| AV-04 | Distinguish process liveness, readiness, broker availability and end-to-end progress | Compare health checks with successful synthetic operations and telemetry |
| AV-05 | Document behavior for broker, controller quorum, database and downstream interruption | Applicable failure/recovery experiments at P5/P6/P8/P12 |
| AV-06 | State recovery, maintenance, data-loss and availability trade-offs of each topology | Record what single-broker and multi-broker environments can actually demonstrate |

## Definitions and limits

A single-broker learning environment has no broker redundancy and is not an HA demonstration. Replication, acknowledgement settings, ISR state, quorum and client behavior jointly affect useful availability; no unconditional loss-free failover is promised. Persistent state and backlog reconciliation must be checked after recovery, not inferred from a green health endpoint.

P0-027 will define a numerical objective and measurement window; P12 will produce observed outage/recovery evidence. Maintenance exclusions must be declared before measurement and both gross and adjusted outcomes disclosed if used. These are planned obligations rather than an SLA or a claim of continuous operation.

## Evidence

See [task learning record](../learning-notes/P0/P0-011.md) and [document review](../testing/evidence/P0-011-review.md).
