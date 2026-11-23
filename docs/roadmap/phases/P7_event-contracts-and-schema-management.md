# Phase 7 — Event contracts and schema management

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Establish interoperable event contracts, schema compatibility rules and contract tests.

## Expected exit deliverable

Governed event schema library and CI compatibility verification

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (37 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P7-001** — Define event naming _(depends on: P6-GATE)_
- [ ] **P7-002** — Define event envelope _(depends on: P7-001)_
- [ ] **P7-003** — Define unique event ID _(depends on: P7-002)_
- [ ] **P7-004** — Define correlation ID _(depends on: P7-003)_
- [ ] **P7-005** — Define causation ID _(depends on: P7-004)_
- [ ] **P7-006** — Define event timestamp _(depends on: P7-005)_
- [ ] **P7-007** — Define schema versioning _(depends on: P7-006)_
- [ ] **P7-008** — Define metadata fields _(depends on: P7-007)_
- [ ] **P7-009** — Assign schema owners _(depends on: P7-008)_
- [ ] **P7-010** — Assign topic owners _(depends on: P7-009)_
- [ ] **P7-011** — Compare serialization formats _(depends on: P7-010)_
- [ ] **P7-012** — Compare JSON and Avro _(depends on: P7-011)_
- [ ] **P7-013** — Compare Avro and Protobuf _(depends on: P7-012)_
- [ ] **P7-014** — Implement JSON codec _(depends on: P7-013)_
- [ ] **P7-015** — Implement Avro codec _(depends on: P7-014)_
- [ ] **P7-016** — Implement Protobuf codec _(depends on: P7-015)_
- [ ] **P7-017** — Measure payload sizes _(depends on: P7-016)_
- [ ] **P7-018** — Benchmark codecs _(depends on: P7-017)_
- [ ] **P7-019** — Explain schema registry _(depends on: P7-018)_
- [ ] **P7-020** — Choose Apache-compatible registry _(depends on: P7-019)_
- [ ] **P7-021** — Deploy registry _(depends on: P7-020)_
- [ ] **P7-022** — Configure registry-aware serializer _(depends on: P7-021)_
- [ ] **P7-023** — Register first schema _(depends on: P7-022)_
- [ ] **P7-024** — Retrieve schema versions _(depends on: P7-023)_
- [ ] **P7-025** — Set compatibility mode _(depends on: P7-024)_
- [ ] **P7-026** — Test backward compatibility _(depends on: P7-025)_
- [ ] **P7-027** — Test forward compatibility _(depends on: P7-026)_
- [ ] **P7-028** — Test full compatibility _(depends on: P7-027)_
- [ ] **P7-029** — Evolve a schema _(depends on: P7-028)_
- [ ] **P7-030** — Reject incompatible schema _(depends on: P7-029)_
- [ ] **P7-031** — Document schema policy _(depends on: P7-030)_
- [ ] **P7-032** — Design contract tests _(depends on: P7-031)_
- [ ] **P7-033** — Implement producer contract test _(depends on: P7-032)_
- [ ] **P7-034** — Implement consumer contract test _(depends on: P7-033)_
- [ ] **P7-035** — Run compatibility check in CI _(depends on: P7-034)_
- [ ] **P7-036** — Exercise schema evolution _(depends on: P7-035)_
- [ ] **P7-037** — Document breaking changes _(depends on: P7-036)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
