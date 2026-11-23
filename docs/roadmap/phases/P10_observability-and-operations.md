# Phase 10 — Observability and operations

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Correlate logs, metrics and traces to follow events through the distributed system.

## Expected exit deliverable

Metrics dashboards, centralized logs, end-to-end traces and alert rules

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (44 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P10-001** — Define logging policy _(depends on: P9-GATE)_
- [ ] **P10-002** — Emit structured JSON logs _(depends on: P10-001)_
- [ ] **P10-003** — Standardize severity levels _(depends on: P10-002)_
- [ ] **P10-004** — Propagate correlation ID _(depends on: P10-003)_
- [ ] **P10-005** — Log event ID _(depends on: P10-004)_
- [ ] **P10-006** — Instrument Kafka producer logs _(depends on: P10-005)_
- [ ] **P10-007** — Instrument Kafka consumer logs _(depends on: P10-006)_
- [ ] **P10-008** — Capture processing errors _(depends on: P10-007)_
- [ ] **P10-009** — Redact sensitive log fields _(depends on: P10-008)_
- [ ] **P10-010** — Deploy Loki or equivalent _(depends on: P10-009)_
- [ ] **P10-011** — Understand JVM metrics _(depends on: P10-010)_
- [ ] **P10-012** — Inspect Kafka broker metrics _(depends on: P10-011)_
- [ ] **P10-013** — Inspect producer metrics _(depends on: P10-012)_
- [ ] **P10-014** — Inspect consumer metrics _(depends on: P10-013)_
- [ ] **P10-015** — Track consumer lag _(depends on: P10-014)_
- [ ] **P10-016** — Measure request latency _(depends on: P10-015)_
- [ ] **P10-017** — Measure throughput _(depends on: P10-016)_
- [ ] **P10-018** — Count failed records _(depends on: P10-017)_
- [ ] **P10-019** — Count retry attempts _(depends on: P10-018)_
- [ ] **P10-020** — Count DLT events _(depends on: P10-019)_
- [ ] **P10-021** — Deploy Prometheus _(depends on: P10-020)_
- [ ] **P10-022** — Expose Actuator metrics _(depends on: P10-021)_
- [ ] **P10-023** — Export Kafka JMX metrics _(depends on: P10-022)_
- [ ] **P10-024** — Build Grafana dashboards _(depends on: P10-023)_
- [ ] **P10-025** — Understand distributed traces _(depends on: P10-024)_
- [ ] **P10-026** — Explain span and trace IDs _(depends on: P10-025)_
- [ ] **P10-027** — Deploy OpenTelemetry SDK _(depends on: P10-026)_
- [ ] **P10-028** — Instrument application _(depends on: P10-027)_
- [ ] **P10-029** — Propagate W3C trace context in Kafka headers _(depends on: P10-028)_
- [ ] **P10-030** — Trace Kafka producer calls _(depends on: P10-029)_
- [ ] **P10-031** — Trace Kafka processing _(depends on: P10-030)_
- [ ] **P10-032** — Trace database operations _(depends on: P10-031)_
- [ ] **P10-033** — Deploy Tempo or Jaeger _(depends on: P10-032)_
- [ ] **P10-034** — Review end-to-end trace _(depends on: P10-033)_
- [ ] **P10-035** — Define SLIs _(depends on: P10-034)_
- [ ] **P10-036** — Define SLOs _(depends on: P10-035)_
- [ ] **P10-037** — Choose alert thresholds _(depends on: P10-036)_
- [ ] **P10-038** — Alert on consumer lag _(depends on: P10-037)_
- [ ] **P10-039** — Alert on broker failure _(depends on: P10-038)_
- [ ] **P10-040** — Alert on disk space _(depends on: P10-039)_
- [ ] **P10-041** — Alert on application errors _(depends on: P10-040)_
- [ ] **P10-042** — Alert on DLT spikes _(depends on: P10-041)_
- [ ] **P10-043** — Write alert response notes _(depends on: P10-042)_
- [ ] **P10-044** — Create operations dashboard _(depends on: P10-043)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
