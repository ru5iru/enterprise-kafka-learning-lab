# Phase 3 — First Kafka producer and consumer

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Learn Kafka with CLI and native clients before adding Spring Kafka abstractions.

## Expected exit deliverable

Working local Kafka single-broker lab with CLI, native Java and Spring Kafka message flows

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (66 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P3-001** — Understand event streaming _(depends on: P2-GATE)_
- [ ] **P3-002** — Understand Kafka architecture _(depends on: P3-001)_
- [ ] **P3-003** — Understand broker role _(depends on: P3-002)_
- [ ] **P3-004** — Understand KRaft _(depends on: P3-003)_
- [ ] **P3-005** — Understand controller role _(depends on: P3-004)_
- [ ] **P3-006** — Understand topics _(depends on: P3-005)_
- [ ] **P3-007** — Understand partitions _(depends on: P3-006)_
- [ ] **P3-008** — Understand offsets _(depends on: P3-007)_
- [ ] **P3-009** — Understand message keys _(depends on: P3-008)_
- [ ] **P3-010** — Understand message headers _(depends on: P3-009)_
- [ ] **P3-011** — Understand record timestamps _(depends on: P3-010)_
- [ ] **P3-012** — Understand producer and consumer _(depends on: P3-011)_
- [ ] **P3-013** — Understand bootstrap servers _(depends on: P3-012)_
- [ ] **P3-014** — Understand cluster metadata _(depends on: P3-013)_
- [ ] **P3-015** — Create Kafka Compose file _(depends on: P3-014)_
- [ ] **P3-016** — Configure one-node KRaft _(depends on: P3-015)_
- [ ] **P3-017** — Start Kafka broker _(depends on: P3-016)_
- [ ] **P3-018** — Inspect container logs _(depends on: P3-017)_
- [ ] **P3-019** — Verify bootstrap connectivity _(depends on: P3-018)_
- [ ] **P3-020** — Create topic with CLI _(depends on: P3-019)_
- [ ] **P3-021** — List topics _(depends on: P3-020)_
- [ ] **P3-022** — Describe topic _(depends on: P3-021)_
- [ ] **P3-023** — Publish using console producer _(depends on: P3-022)_
- [ ] **P3-024** — Consume using console consumer _(depends on: P3-023)_
- [ ] **P3-025** — Inspect offsets _(depends on: P3-024)_
- [ ] **P3-026** — Delete test topic _(depends on: P3-025)_
- [ ] **P3-027** — Document Kafka CLI commands _(depends on: P3-026)_
- [ ] **P3-028** — Create native producer project _(depends on: P3-027)_
- [ ] **P3-029** — Add Kafka clients dependency _(depends on: P3-028)_
- [ ] **P3-030** — Configure bootstrap servers _(depends on: P3-029)_
- [ ] **P3-031** — Configure producer properties _(depends on: P3-030)_
- [ ] **P3-032** — Create event record _(depends on: P3-031)_
- [ ] **P3-033** — Implement StringSerializer _(depends on: P3-032)_
- [ ] **P3-034** — Publish first event _(depends on: P3-033)_
- [ ] **P3-035** — Verify record by CLI _(depends on: P3-034)_
- [ ] **P3-036** — Inspect send acknowledgement _(depends on: P3-035)_
- [ ] **P3-037** — Publish asynchronously _(depends on: P3-036)_
- [ ] **P3-038** — Handle send callback _(depends on: P3-037)_
- [ ] **P3-039** — Handle producer exceptions _(depends on: P3-038)_
- [ ] **P3-040** — Close producer gracefully _(depends on: P3-039)_
- [ ] **P3-041** — Test broker-unavailable behavior _(depends on: P3-040)_
- [ ] **P3-042** — Create native consumer project _(depends on: P3-041)_
- [ ] **P3-043** — Configure consumer bootstrap _(depends on: P3-042)_
- [ ] **P3-044** — Configure consumer properties _(depends on: P3-043)_
- [ ] **P3-045** — Implement deserializer _(depends on: P3-044)_
- [ ] **P3-046** — Subscribe to topic _(depends on: P3-045)_
- [ ] **P3-047** — Implement poll loop _(depends on: P3-046)_
- [ ] **P3-048** — Process polled records _(depends on: P3-047)_
- [ ] **P3-049** — Set consumer group ID _(depends on: P3-048)_
- [ ] **P3-050** — Observe auto commits _(depends on: P3-049)_
- [ ] **P3-051** — Implement manual commits _(depends on: P3-050)_
- [ ] **P3-052** — Handle consumer exceptions _(depends on: P3-051)_
- [ ] **P3-053** — Implement graceful shutdown _(depends on: P3-052)_
- [ ] **P3-054** — Test restart and replay _(depends on: P3-053)_
- [ ] **P3-055** — Add Spring Kafka dependency _(depends on: P3-054)_
- [ ] **P3-056** — Configure Spring Kafka brokers _(depends on: P3-055)_
- [ ] **P3-057** — Configure ProducerFactory _(depends on: P3-056)_
- [ ] **P3-058** — Configure KafkaTemplate _(depends on: P3-057)_
- [ ] **P3-059** — Publish with Spring Kafka _(depends on: P3-058)_
- [ ] **P3-060** — Implement @KafkaListener _(depends on: P3-059)_
- [ ] **P3-061** — Configure Spring group IDs _(depends on: P3-060)_
- [ ] **P3-062** — Configure event serialization _(depends on: P3-061)_
- [ ] **P3-063** — Configure event deserialization _(depends on: P3-062)_
- [ ] **P3-064** — Compare native and Spring clients _(depends on: P3-063)_
- [ ] **P3-065** — Test producer with unit test _(depends on: P3-064)_
- [ ] **P3-066** — Test consumer with Testcontainers _(depends on: P3-065)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
