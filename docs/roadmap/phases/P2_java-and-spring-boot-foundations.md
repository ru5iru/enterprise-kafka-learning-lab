# Phase 2 — Java and Spring Boot foundations

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Refresh essential Java skills and establish clean, testable Spring Boot application conventions.

## Expected exit deliverable

Tested and containerized Spring Boot starter application

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (34 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P2-001** — Review Java project structure _(depends on: P1-GATE)_
- [ ] **P2-002** — Review Maven dependency scopes _(depends on: P2-001)_
- [ ] **P2-003** — Review interfaces and abstractions _(depends on: P2-002)_
- [ ] **P2-004** — Review dependency inversion _(depends on: P2-003)_
- [ ] **P2-005** — Review collections and generics _(depends on: P2-004)_
- [ ] **P2-006** — Review streams and lambdas _(depends on: P2-005)_
- [ ] **P2-007** — Review records and immutability _(depends on: P2-006)_
- [ ] **P2-008** — Review checked and unchecked exceptions _(depends on: P2-007)_
- [ ] **P2-009** — Review Java concurrency _(depends on: P2-008)_
- [ ] **P2-010** — Review thread pools _(depends on: P2-009)_
- [ ] **P2-011** — Review CompletableFuture _(depends on: P2-010)_
- [ ] **P2-012** — Review JVM memory basics _(depends on: P2-011)_
- [ ] **P2-013** — Review SLF4J logging _(depends on: P2-012)_
- [ ] **P2-014** — Create Spring Boot application _(depends on: P2-013)_
- [ ] **P2-015** — Understand application lifecycle _(depends on: P2-014)_
- [ ] **P2-016** — Implement dependency injection _(depends on: P2-015)_
- [ ] **P2-017** — Configure application properties _(depends on: P2-016)_
- [ ] **P2-018** — Implement environment profiles _(depends on: P2-017)_
- [ ] **P2-019** — Create REST endpoint _(depends on: P2-018)_
- [ ] **P2-020** — Validate REST requests _(depends on: P2-019)_
- [ ] **P2-021** — Add global exception handler _(depends on: P2-020)_
- [ ] **P2-022** — Implement structured logging _(depends on: P2-021)_
- [ ] **P2-023** — Enable Actuator health _(depends on: P2-022)_
- [ ] **P2-024** — Expose application metrics _(depends on: P2-023)_
- [ ] **P2-025** — Write JUnit unit tests _(depends on: P2-024)_
- [ ] **P2-026** — Write controller integration tests _(depends on: P2-025)_
- [ ] **P2-027** — Implement layered separation _(depends on: P2-026)_
- [ ] **P2-028** — Apply SOLID _(depends on: P2-027)_
- [ ] **P2-029** — Separate domain and infrastructure _(depends on: P2-028)_
- [ ] **P2-030** — Separate DTOs from domain _(depends on: P2-029)_
- [ ] **P2-031** — Validate typed configuration _(depends on: P2-030)_
- [ ] **P2-032** — Run dependency vulnerability scan _(depends on: P2-031)_
- [ ] **P2-033** — Document service _(depends on: P2-032)_
- [ ] **P2-034** — Build Docker image _(depends on: P2-033)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
