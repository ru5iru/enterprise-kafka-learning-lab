# Phase 4 — Microservices and event-driven architecture

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Split a minimal e-commerce simulation into independently deployed event producers and consumers.

## Expected exit deliverable

Independent order/payment/inventory/notification applications exchanging events

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (43 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P4-001** — Define Order domain _(depends on: P3-GATE)_
- [ ] **P4-002** — Define Payment domain _(depends on: P4-001)_
- [ ] **P4-003** — Define Inventory domain _(depends on: P4-002)_
- [ ] **P4-004** — Create Order Service _(depends on: P4-003)_
- [ ] **P4-005** — Expose create-order endpoint _(depends on: P4-004)_
- [ ] **P4-006** — Validate order input _(depends on: P4-005)_
- [ ] **P4-007** — Create Payment Service _(depends on: P4-006)_
- [ ] **P4-008** — Simulate payment processing _(depends on: P4-007)_
- [ ] **P4-009** — Create Inventory Service _(depends on: P4-008)_
- [ ] **P4-010** — Simulate inventory checks _(depends on: P4-009)_
- [ ] **P4-011** — Create Notification Service _(depends on: P4-010)_
- [ ] **P4-012** — Simulate notification sending _(depends on: P4-011)_
- [ ] **P4-013** — Publish from Order Service _(depends on: P4-012)_
- [ ] **P4-014** — Create standalone order consumer _(depends on: P4-013)_
- [ ] **P4-015** — Publish order-created event _(depends on: P4-014)_
- [ ] **P4-016** — Consume order-created event _(depends on: P4-015)_
- [ ] **P4-017** — Trigger payment simulation _(depends on: P4-016)_
- [ ] **P4-018** — Publish payment-completed event _(depends on: P4-017)_
- [ ] **P4-019** — Consume payment-completed event _(depends on: P4-018)_
- [ ] **P4-020** — Trigger inventory operation _(depends on: P4-019)_
- [ ] **P4-021** — Publish inventory-updated event _(depends on: P4-020)_
- [ ] **P4-022** — Trigger notification processing _(depends on: P4-021)_
- [ ] **P4-023** — Verify async communication _(depends on: P4-022)_
- [ ] **P4-024** — Verify independent deployment _(depends on: P4-023)_
- [ ] **P4-025** — Explain event-driven architecture _(depends on: P4-024)_
- [ ] **P4-026** — Identify producers and subscribers _(depends on: P4-025)_
- [ ] **P4-027** — Evaluate loose coupling _(depends on: P4-026)_
- [ ] **P4-028** — Explain choreography _(depends on: P4-027)_
- [ ] **P4-029** — Explain orchestration _(depends on: P4-028)_
- [ ] **P4-030** — Compare sync and async _(depends on: P4-029)_
- [ ] **P4-031** — Explain eventual consistency _(depends on: P4-030)_
- [ ] **P4-032** — Document bounded contexts _(depends on: P4-031)_
- [ ] **P4-033** — Draw event flow _(depends on: P4-032)_
- [ ] **P4-034** — Create sequence diagrams _(depends on: P4-033)_
- [ ] **P4-035** — Run two consumers on topic _(depends on: P4-034)_
- [ ] **P4-036** — Create distinct consumer groups _(depends on: P4-035)_
- [ ] **P4-037** — Observe independent subscription _(depends on: P4-036)_
- [ ] **P4-038** — Run two consumers in one group _(depends on: P4-037)_
- [ ] **P4-039** — Observe partition allocation _(depends on: P4-038)_
- [ ] **P4-040** — Observe group rebalance _(depends on: P4-039)_
- [ ] **P4-041** — Experiment with group ID changes _(depends on: P4-040)_
- [ ] **P4-042** — Explain group coordination _(depends on: P4-041)_
- [ ] **P4-043** — Record group experiments _(depends on: P4-042)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
