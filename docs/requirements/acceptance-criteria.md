# P0-018 - Define measurable acceptance criteria

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Acceptance matrix

All runtime criteria below are **not run**. Their planning definition is complete; system acceptance requires future evidence.

| ID | Requirement link | Trigger and expected measurable result | Evidence / milestone |
|---|---|---|---|
| AC-01 | FR-01/02 | Valid input yields a traceable accepted event under the documented send policy; invalid input yields zero accepted-order events | Request/producer/topic counts and negative tests; P3/P4 |
| AC-02 | FR-03/04, AV-02 | Stop Payment; Inventory can consume OrderCreated independently; no false global completion | Group offsets, outcome IDs, lag and errors; P4/P6 |
| AC-03 | FR-05 | Known successful branch outcomes yield corresponding synthetic notifications, not external delivery claims | Correlated input/outcome/notification records; P4 |
| AC-04 | FR-06/07 | Duplicate, crash-window and poison cases obey declared commit/retry/DLT/replay policy with bounded attempts | Records/offsets/side-effect accounting and recovery; P6 |
| AC-05 | FR-08, DR-03 | Local entity/outbox transaction and restart preserve documented publication intent; gaps/duplicates reconciled | Database rows/events/consumer effects; P8 |
| AC-06 | FR-09 | Compatible schema change passes the selected compatibility matrix; incompatible/malformed inputs take the defined rejection path | Contracts/versions/CI results; P7 |
| AC-07 | SEC-03/04/07 | Intended identity succeeds; forbidden operation and invalid/expired/untrusted credential cases fail at the expected layer; correction retested | Sanitized identity/permission/lifecycle results; P9 |
| AC-08 | OBS-01/06 | Known event/fault is traceable; lag/latency/error signals identify the affected branch and alert recovery | Correlated telemetry and runbook action; P10 |
| AC-09 | PERF/SC | Sustained baseline and peak tests meet P0-022/023 rate and P0-026 latency definitions without unbounded lag; failures/resources reported | Workload/environment/histogram/counter/lag report; P11 |
| AC-10 | AV, DR-04 | Availability uses the P0-027 definition; isolated restore targets RPO <= 5 min and RTO <= 30 min with reconciled state | Timestamped outage/restore/useful-flow report; P12 |
| AC-11 | DEP/SEC-09 | Clean deployment, persistent restart, independent rollout and forbidden network/permission case behave as specified | State/identity/storage/policy and recovery evidence; P13 |
| AC-12 | MAIN, SEC-08 | Independent builds and required gates execute; intended failing fixture rejects release and corrected fixture passes | CI/test/scan/SBOM/artifact results with finding disposition; P14 |

## Pass/fail rules and pending numeric definitions

Record expected and observed behavior, environment/version/configuration, sample size/duration, failure counts, limits, and evidence path for each executed criterion. A missing gate or unspecified threshold is not a pass. A learning experiment can expose an unmet target and teach a lesson without demonstrating the target.

P0-019-P0-025 define population, concurrency, event frequency/rate, peak, payload and retention. P0-026/P0-027 define latency and availability objectives. Those tasks supply numerical parameters referenced above; this task does not preempt their decisions or invent test outcomes. Requirements are the previously published FR/PERF/AV/SC/SEC/OBS/MAIN/DEP/DR identifiers; review them with the corresponding task artifacts and preserve scope exclusions.

## Evidence

See [task learning record](../learning-notes/P0/P0-018.md) and [document review](../testing/evidence/P0-018-review.md).
