# P0-003 - Define scope boundaries

**Date:** 2026-11-24  
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Purpose and scope rule

Learning is the product. Admit work only when it (1) supports a charter objective and learner competency, (2) belongs to a named roadmap task, (3) fits that task's prerequisites and milestone, (4) can be studied and verified with bounded, reproducible evidence, and (5) can run safely with synthetic data in an isolated lab. If any gate fails, defer or propose a documented amendment; do not silently expand implementation.

## Boundaries

| Dimension | Included in the overall lab | Boundary / implication |
|---|---|---|
| Learning | Kafka/KRaft, native Java then Spring Kafka, correctness, schemas, persistence, security, observability, performance, resilience, deployment, SSDLC | Follow the 15-phase/726-task sequence; no runtime work during P0 |
| Domain | Minimal order/payment/inventory/notification simulation that produces useful events | Deterministic synthetic outcomes; commercial feature completeness is not a goal |
| Engineering | Independent Maven service builds in a monorepo; reproducible local experiments | Add services only for a named learning/architecture purpose; no shared service-owned database access |
| Deployment | Local Compose learning followed by advanced Kubernetes work | No public or production deployment commitment; infrastructure remains conceptual until assigned tasks |
| Security | Early requirements/threat reasoning and progressive runtime controls | Hygiene and isolation from day one; TLS/mTLS/SASL/ACLs are later implementations, not existing protection |
| Scale | Evidence-based modeling of the approximately 100,000-user scenario | No proven capacity, fixed rates, SLOs, hardware budget, or production SLA yet |
| Evidence | Task notes, relevant ADRs, tests/failure cases, sanitized observations | Generated code or a green happy path alone is not completion |
| Schedule | Flexible, task-sized progression | No fixed project completion date or invented effort estimate |

## Current milestone boundary

P0 produces planning artifacts: objectives, scope, requirements, workload assumptions, conceptual diagrams, trust boundaries, threat model, and ADRs. It creates no Java services, Compose stacks, broker configuration, or Kubernetes manifests. Later phases implement and validate those plans. The CSV is authoritative; Markdown roadmap checkboxes remain a historical view.

## Admission examples

- Admit studying native producer errors and consumer offset behavior under P3: directly supports OBJ-01/OBJ-03 and LO-02.
- Admit bounded duplicate/replay and Outbox experiments under P6/P8: supports distributed-correctness learning, with synthetic side effects.
- Defer a Kubernetes broker deployment to P13: overall scope does not override prerequisites.
- Reject integrating a live payment processor or real customer data: a deterministic simulator teaches the assigned concepts without that external trust and data exposure.
- Reject a new service whose only justification is realism: state the missing learning need before reconsideration.

## Change control and consequences

For a proposed scope change, record the motivation, charter/LO mapping, affected tasks/dependencies, alternatives, safety/resource implications, verification plan, and whether an ADR is needed. Preserve the original roadmap; propose a dated amendment and obtain direction for material changes. This task does not grant approval to rewrite task IDs or add technologies opportunistically. The trade-off is limited commercial realism in exchange for controlled experiments and traceable decisions.

Technology inventory, detailed exclusions, and simulation behavior follow in P0-004-P0-006. Functional/non-functional requirements and numeric targets follow their assigned P0 tasks. No new architecture/security selection is made here.

## Evidence

See [task learning record](../learning-notes/P0/P0-003.md) and [document review](../testing/evidence/P0-003-review.md).
