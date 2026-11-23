# Phase 12 — Resilience and disaster recovery

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Deliberately break infrastructure and services; document recovery, availability and DR trade-offs.

## Expected exit deliverable

Failure injection report, DR plan, RPO/RTO goals and tested runbooks

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (40 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P12-001** — Stop active Kafka broker _(depends on: P11-GATE)_
- [ ] **P12-002** — Restart stopped broker _(depends on: P12-001)_
- [ ] **P12-003** — Stop multiple brokers _(depends on: P12-002)_
- [ ] **P12-004** — Inject network delay _(depends on: P12-003)_
- [ ] **P12-005** — Inject packet loss _(depends on: P12-004)_
- [ ] **P12-006** — Disconnect a consumer _(depends on: P12-005)_
- [ ] **P12-007** — Kill producer process _(depends on: P12-006)_
- [ ] **P12-008** — Restart PostgreSQL _(depends on: P12-007)_
- [ ] **P12-009** — Inject slow SQL _(depends on: P12-008)_
- [ ] **P12-010** — Simulate full broker disk _(depends on: P12-009)_
- [ ] **P12-011** — Simulate memory pressure _(depends on: P12-010)_
- [ ] **P12-012** — Measure recovery behavior _(depends on: P12-011)_
- [ ] **P12-013** — Define timeout policy _(depends on: P12-012)_
- [ ] **P12-014** — Configure connection timeouts _(depends on: P12-013)_
- [ ] **P12-015** — Set bounded retries _(depends on: P12-014)_
- [ ] **P12-016** — Understand circuit breakers _(depends on: P12-015)_
- [ ] **P12-017** — Apply Resilience4j to eligible calls _(depends on: P12-016)_
- [ ] **P12-018** — Evaluate bulkhead isolation _(depends on: P12-017)_
- [ ] **P12-019** — Implement graceful degradation _(depends on: P12-018)_
- [ ] **P12-020** — Implement SIGTERM shutdown _(depends on: P12-019)_
- [ ] **P12-021** — Configure readiness checks _(depends on: P12-020)_
- [ ] **P12-022** — Configure liveness checks _(depends on: P12-021)_
- [ ] **P12-023** — Test restart continuity _(depends on: P12-022)_
- [ ] **P12-024** — Inspect replica catch-up _(depends on: P12-023)_
- [ ] **P12-025** — Test partition reassignment _(depends on: P12-024)_
- [ ] **P12-026** — Monitor under-replicated partitions _(depends on: P12-025)_
- [ ] **P12-027** — Analyze unclean leader election _(depends on: P12-026)_
- [ ] **P12-028** — Write broker recovery runbook _(depends on: P12-027)_
- [ ] **P12-029** — Recover consumer group _(depends on: P12-028)_
- [ ] **P12-030** — Recover DLT records _(depends on: P12-029)_
- [ ] **P12-031** — Replay topic safely _(depends on: P12-030)_
- [ ] **P12-032** — Define RPO and RTO _(depends on: P12-031)_
- [ ] **P12-033** — Explain replication versus backup _(depends on: P12-032)_
- [ ] **P12-034** — Choose backup approach _(depends on: P12-033)_
- [ ] **P12-035** — Evaluate cross-cluster strategies _(depends on: P12-034)_
- [ ] **P12-036** — Configure MirrorMaker 2 experiment _(depends on: P12-035)_
- [ ] **P12-037** — Simulate entire cluster loss _(depends on: P12-036)_
- [ ] **P12-038** — Practice restoring environment _(depends on: P12-037)_
- [ ] **P12-039** — Write disaster recovery guide _(depends on: P12-038)_
- [ ] **P12-040** — Run DR tabletop exercise _(depends on: P12-039)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
