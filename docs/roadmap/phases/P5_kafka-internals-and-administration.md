# Phase 5 — Kafka internals and administration

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Understand KRaft, partitions, replication, rebalancing and broker recovery through direct experiments.

## Expected exit deliverable

Multi-broker KRaft lab with replication and recovery findings

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (42 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P5-001** — Create topics via AdminClient _(depends on: P4-GATE)_
- [ ] **P5-002** — Inspect AdminClient APIs _(depends on: P5-001)_
- [ ] **P5-003** — Configure partition count _(depends on: P5-002)_
- [ ] **P5-004** — Inspect partition placement _(depends on: P5-003)_
- [ ] **P5-005** — Publish keyed records _(depends on: P5-004)_
- [ ] **P5-006** — Observe key partition affinity _(depends on: P5-005)_
- [ ] **P5-007** — Experiment with custom partitioner _(depends on: P5-006)_
- [ ] **P5-008** — Verify per-partition ordering _(depends on: P5-007)_
- [ ] **P5-009** — Increase partition count _(depends on: P5-008)_
- [ ] **P5-010** — Observe changed key partition mappings _(depends on: P5-009)_
- [ ] **P5-011** — Inspect log segments _(depends on: P5-010)_
- [ ] **P5-012** — Understand retention _(depends on: P5-011)_
- [ ] **P5-013** — Test time-based retention _(depends on: P5-012)_
- [ ] **P5-014** — Test size-based retention _(depends on: P5-013)_
- [ ] **P5-015** — Test log compaction _(depends on: P5-014)_
- [ ] **P5-016** — Understand replica placement _(depends on: P5-015)_
- [ ] **P5-017** — Understand replication factor _(depends on: P5-016)_
- [ ] **P5-018** — Identify partition leader _(depends on: P5-017)_
- [ ] **P5-019** — Identify followers _(depends on: P5-018)_
- [ ] **P5-020** — Inspect ISR _(depends on: P5-019)_
- [ ] **P5-021** — Understand high watermark _(depends on: P5-020)_
- [ ] **P5-022** — Observe leader election _(depends on: P5-021)_
- [ ] **P5-023** — Evaluate unclean leader election _(depends on: P5-022)_
- [ ] **P5-024** — Inspect broker registration _(depends on: P5-023)_
- [ ] **P5-025** — Understand KRaft quorum _(depends on: P5-024)_
- [ ] **P5-026** — Inspect controller responsibilities _(depends on: P5-025)_
- [ ] **P5-027** — Explore cluster metadata _(depends on: P5-026)_
- [ ] **P5-028** — Expose broker metrics _(depends on: P5-027)_
- [ ] **P5-029** — Design multi-broker conversion _(depends on: P5-028)_
- [ ] **P5-030** — Configure three brokers _(depends on: P5-029)_
- [ ] **P5-031** — Assign broker identities _(depends on: P5-030)_
- [ ] **P5-032** — Configure advertised listeners _(depends on: P5-031)_
- [ ] **P5-033** — Set replication policies _(depends on: P5-032)_
- [ ] **P5-034** — Create replicated topic _(depends on: P5-033)_
- [ ] **P5-035** — Inspect replica assignments _(depends on: P5-034)_
- [ ] **P5-036** — Stop leader broker _(depends on: P5-035)_
- [ ] **P5-037** — Observe new leader _(depends on: P5-036)_
- [ ] **P5-038** — Restart broker _(depends on: P5-037)_
- [ ] **P5-039** — Observe ISR recovery _(depends on: P5-038)_
- [ ] **P5-040** — Stop majority of controllers _(depends on: P5-039)_
- [ ] **P5-041** — Observe quorum failure _(depends on: P5-040)_
- [ ] **P5-042** — Document recovery findings _(depends on: P5-041)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
