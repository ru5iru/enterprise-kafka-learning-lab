# Phase 8 — PostgreSQL and distributed consistency

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Learn DB-per-service, transactional outbox, CDC and compensating distributed workflows.

## Expected exit deliverable

Independent PostgreSQL data stores, Outbox and CDC demonstrations and Saga experiment

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (49 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P8-001** — Deploy PostgreSQL _(depends on: P7-GATE)_
- [ ] **P8-002** — Create separate service databases _(depends on: P8-001)_
- [ ] **P8-003** — Create least-privilege DB accounts _(depends on: P8-002)_
- [ ] **P8-004** — Configure JDBC connection _(depends on: P8-003)_
- [ ] **P8-005** — Integrate Spring Data JPA _(depends on: P8-004)_
- [ ] **P8-006** — Create JPA entities _(depends on: P8-005)_
- [ ] **P8-007** — Implement repositories _(depends on: P8-006)_
- [ ] **P8-008** — Create Flyway migrations _(depends on: P8-007)_
- [ ] **P8-009** — Configure HikariCP _(depends on: P8-008)_
- [ ] **P8-010** — Demonstrate DB transactions _(depends on: P8-009)_
- [ ] **P8-011** — Test DB outage _(depends on: P8-010)_
- [ ] **P8-012** — Expose database health _(depends on: P8-011)_
- [ ] **P8-013** — Explain database per service _(depends on: P8-012)_
- [ ] **P8-014** — Document data ownership _(depends on: P8-013)_
- [ ] **P8-015** — Prevent cross-service table access _(depends on: P8-014)_
- [ ] **P8-016** — Persist service-local state _(depends on: P8-015)_
- [ ] **P8-017** — Demonstrate eventual consistency _(depends on: P8-016)_
- [ ] **P8-018** — Test data convergence _(depends on: P8-017)_
- [ ] **P8-019** — Explain dual-write problem _(depends on: P8-018)_
- [ ] **P8-020** — Reproduce dual-write inconsistency _(depends on: P8-019)_
- [ ] **P8-021** — Design transactional outbox _(depends on: P8-020)_
- [ ] **P8-022** — Create outbox table _(depends on: P8-021)_
- [ ] **P8-023** — Store entity and outbox row atomically _(depends on: P8-022)_
- [ ] **P8-024** — Build polling publisher _(depends on: P8-023)_
- [ ] **P8-025** — Publish pending outbox rows _(depends on: P8-024)_
- [ ] **P8-026** — Mark published rows _(depends on: P8-025)_
- [ ] **P8-027** — Recover polling publisher _(depends on: P8-026)_
- [ ] **P8-028** — Deduplicate publication side effects _(depends on: P8-027)_
- [ ] **P8-029** — Measure polling costs _(depends on: P8-028)_
- [ ] **P8-030** — Explain change data capture _(depends on: P8-029)_
- [ ] **P8-031** — Explain WAL/logical decoding _(depends on: P8-030)_
- [ ] **P8-032** — Deploy Kafka Connect _(depends on: P8-031)_
- [ ] **P8-033** — Introduce Debezium _(depends on: P8-032)_
- [ ] **P8-034** — Enable PostgreSQL logical replication _(depends on: P8-033)_
- [ ] **P8-035** — Configure Debezium connector _(depends on: P8-034)_
- [ ] **P8-036** — Capture outbox rows _(depends on: P8-035)_
- [ ] **P8-037** — Route CDC events to Kafka _(depends on: P8-036)_
- [ ] **P8-038** — Compare polling versus CDC _(depends on: P8-037)_
- [ ] **P8-039** — Restart connector _(depends on: P8-038)_
- [ ] **P8-040** — Validate connector recovery _(depends on: P8-039)_
- [ ] **P8-041** — Explain distributed transactions _(depends on: P8-040)_
- [ ] **P8-042** — Explain Saga pattern _(depends on: P8-041)_
- [ ] **P8-043** — Design order saga _(depends on: P8-042)_
- [ ] **P8-044** — Implement choreography saga _(depends on: P8-043)_
- [ ] **P8-045** — Implement compensation _(depends on: P8-044)_
- [ ] **P8-046** — Simulate payment failure _(depends on: P8-045)_
- [ ] **P8-047** — Simulate inventory failure _(depends on: P8-046)_
- [ ] **P8-048** — Handle saga timeouts _(depends on: P8-047)_
- [ ] **P8-049** — Compare choreography and orchestration _(depends on: P8-048)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
