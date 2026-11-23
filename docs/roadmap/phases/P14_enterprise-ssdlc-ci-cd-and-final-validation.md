# Phase 14 — Enterprise SSDLC, CI/CD and final validation

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Automate secure build, tests, scans, release verification, operational runbooks and final validation.

## Expected exit deliverable

Secured CI/CD pipeline, final test evidence, operational handbook and learning report

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (52 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P14-001** — Design CI/CD workflow _(depends on: P13-GATE)_
- [ ] **P14-002** — Build services independently _(depends on: P14-001)_
- [ ] **P14-003** — Run unit tests in CI _(depends on: P14-002)_
- [ ] **P14-004** — Run Testcontainers integration tests _(depends on: P14-003)_
- [ ] **P14-005** — Run event contract tests _(depends on: P14-004)_
- [ ] **P14-006** — Check schema compatibility _(depends on: P14-005)_
- [ ] **P14-007** — Run SAST _(depends on: P14-006)_
- [ ] **P14-008** — Run SCA _(depends on: P14-007)_
- [ ] **P14-009** — Run secret detection _(depends on: P14-008)_
- [ ] **P14-010** — Build Docker images _(depends on: P14-009)_
- [ ] **P14-011** — Scan images _(depends on: P14-010)_
- [ ] **P14-012** — Generate SBOM _(depends on: P14-011)_
- [ ] **P14-013** — Publish signed artifacts _(depends on: P14-012)_
- [ ] **P14-014** — Automate deployment _(depends on: P14-013)_
- [ ] **P14-015** — Run smoke tests _(depends on: P14-014)_
- [ ] **P14-016** — Automate rollback plan _(depends on: P14-015)_
- [ ] **P14-017** — Explain supply-chain risks _(depends on: P14-016)_
- [ ] **P14-018** — Set dependency update rules _(depends on: P14-017)_
- [ ] **P14-019** — Pin dependency versions _(depends on: P14-018)_
- [ ] **P14-020** — Capture provenance _(depends on: P14-019)_
- [ ] **P14-021** — Sign OCI image _(depends on: P14-020)_
- [ ] **P14-022** — Define vulnerability policy _(depends on: P14-021)_
- [ ] **P14-023** — Define remediation timeline _(depends on: P14-022)_
- [ ] **P14-024** — Verify provenance at deploy _(depends on: P14-023)_
- [ ] **P14-025** — Write service runbooks _(depends on: P14-024)_
- [ ] **P14-026** — Write Kafka runbooks _(depends on: P14-025)_
- [ ] **P14-027** — Write security incident runbook _(depends on: P14-026)_
- [ ] **P14-028** — Write certificate rotation runbook _(depends on: P14-027)_
- [ ] **P14-029** — Write backup/recovery runbook _(depends on: P14-028)_
- [ ] **P14-030** — Produce capacity report _(depends on: P14-029)_
- [ ] **P14-031** — Publish SLOs _(depends on: P14-030)_
- [ ] **P14-032** — Define incident severities _(depends on: P14-031)_
- [ ] **P14-033** — Document change control _(depends on: P14-032)_
- [ ] **P14-034** — Document release flow _(depends on: P14-033)_
- [ ] **P14-035** — Verify event lifecycle _(depends on: P14-034)_
- [ ] **P14-036** — Verify producer reliability _(depends on: P14-035)_
- [ ] **P14-037** — Verify consumer reliability _(depends on: P14-036)_
- [ ] **P14-038** — Verify retries and DLT _(depends on: P14-037)_
- [ ] **P14-039** — Verify schema compatibility _(depends on: P14-038)_
- [ ] **P14-040** — Verify data consistency _(depends on: P14-039)_
- [ ] **P14-041** — Verify Outbox/CDC _(depends on: P14-040)_
- [ ] **P14-042** — Verify TLS _(depends on: P14-041)_
- [ ] **P14-043** — Verify mTLS _(depends on: P14-042)_
- [ ] **P14-044** — Verify ACLs _(depends on: P14-043)_
- [ ] **P14-045** — Verify certificate rotation _(depends on: P14-044)_
- [ ] **P14-046** — Verify metrics/logs/traces _(depends on: P14-045)_
- [ ] **P14-047** — Verify performance SLOs _(depends on: P14-046)_
- [ ] **P14-048** — Verify failure recovery _(depends on: P14-047)_
- [ ] **P14-049** — Verify Kubernetes _(depends on: P14-048)_
- [ ] **P14-050** — Verify CI security gates _(depends on: P14-049)_
- [ ] **P14-051** — Publish final system architecture _(depends on: P14-050)_
- [ ] **P14-052** — Write learning retrospective _(depends on: P14-051)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
