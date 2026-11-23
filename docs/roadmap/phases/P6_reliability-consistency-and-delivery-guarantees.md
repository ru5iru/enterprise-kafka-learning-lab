# Phase 6 — Reliability, consistency and delivery guarantees

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Observe duplicates and failures; implement bounded retries, DLTs, idempotency and transactions.

## Expected exit deliverable

Failure-tested delivery/retry/DLT, transaction and deduplication demonstrations

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (55 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P6-001** — Understand producer acks _(depends on: P5-GATE)_
- [ ] **P6-002** — Experiment with acks=0 _(depends on: P6-001)_
- [ ] **P6-003** — Experiment with acks=1 _(depends on: P6-002)_
- [ ] **P6-004** — Experiment with acks=all _(depends on: P6-003)_
- [ ] **P6-005** — Understand producer retries _(depends on: P6-004)_
- [ ] **P6-006** — Configure delivery.timeout.ms _(depends on: P6-005)_
- [ ] **P6-007** — Configure request.timeout.ms _(depends on: P6-006)_
- [ ] **P6-008** — Enable idempotent producer _(depends on: P6-007)_
- [ ] **P6-009** — Understand producer sequence IDs _(depends on: P6-008)_
- [ ] **P6-010** — Cause duplicate publish attempts _(depends on: P6-009)_
- [ ] **P6-011** — Compare idempotent behavior _(depends on: P6-010)_
- [ ] **P6-012** — Verify graceful close _(depends on: P6-011)_
- [ ] **P6-013** — Compare offset commit strategies _(depends on: P6-012)_
- [ ] **P6-014** — Implement manual acknowledgement _(depends on: P6-013)_
- [ ] **P6-015** — Crash after processing before commit _(depends on: P6-014)_
- [ ] **P6-016** — Commit before processing as controlled demonstration _(depends on: P6-015)_
- [ ] **P6-017** — Crash consumer mid-processing _(depends on: P6-016)_
- [ ] **P6-018** — Observe redelivery _(depends on: P6-017)_
- [ ] **P6-019** — Demonstrate at-most-once caveat _(depends on: P6-018)_
- [ ] **P6-020** — Demonstrate at-least-once _(depends on: P6-019)_
- [ ] **P6-021** — Understand exactly-once boundaries _(depends on: P6-020)_
- [ ] **P6-022** — Make handler idempotent _(depends on: P6-021)_
- [ ] **P6-023** — Implement event ID deduplication _(depends on: P6-022)_
- [ ] **P6-024** — Persist deduplication keys _(depends on: P6-023)_
- [ ] **P6-025** — Classify transient/permanent errors _(depends on: P6-024)_
- [ ] **P6-026** — Implement simple retry _(depends on: P6-025)_
- [ ] **P6-027** — Configure backoff _(depends on: P6-026)_
- [ ] **P6-028** — Set max attempts _(depends on: P6-027)_
- [ ] **P6-029** — Configure retry topic _(depends on: P6-028)_
- [ ] **P6-030** — Implement exponential retry _(depends on: P6-029)_
- [ ] **P6-031** — Introduce dead-letter topic _(depends on: P6-030)_
- [ ] **P6-032** — Preserve original headers _(depends on: P6-031)_
- [ ] **P6-033** — Capture failure metadata _(depends on: P6-032)_
- [ ] **P6-034** — Build DLT replay utility _(depends on: P6-033)_
- [ ] **P6-035** — Inject poison message _(depends on: P6-034)_
- [ ] **P6-036** — Inject malformed payload _(depends on: P6-035)_
- [ ] **P6-037** — Simulate downstream outage _(depends on: P6-036)_
- [ ] **P6-038** — Document error routing _(depends on: P6-037)_
- [ ] **P6-039** — Define ordering guarantees _(depends on: P6-038)_
- [ ] **P6-040** — Enforce ordering by key _(depends on: P6-039)_
- [ ] **P6-041** — Increase listener concurrency _(depends on: P6-040)_
- [ ] **P6-042** — Observe ordering impact _(depends on: P6-041)_
- [ ] **P6-043** — Explain partition concurrency _(depends on: P6-042)_
- [ ] **P6-044** — Throttle consumer processing _(depends on: P6-043)_
- [ ] **P6-045** — Inspect consumer lag _(depends on: P6-044)_
- [ ] **P6-046** — Alert on lag _(depends on: P6-045)_
- [ ] **P6-047** — Explain Kafka transactions _(depends on: P6-046)_
- [ ] **P6-048** — Configure transactional producer _(depends on: P6-047)_
- [ ] **P6-049** — Publish batch transaction _(depends on: P6-048)_
- [ ] **P6-050** — Abort failing transaction _(depends on: P6-049)_
- [ ] **P6-051** — Implement Kafka-to-Kafka transaction _(depends on: P6-050)_
- [ ] **P6-052** — Set read_committed _(depends on: P6-051)_
- [ ] **P6-053** — Observe transactional fencing _(depends on: P6-052)_
- [ ] **P6-054** — Test exactly-once scope _(depends on: P6-053)_
- [ ] **P6-055** — Document transaction limitations _(depends on: P6-054)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
