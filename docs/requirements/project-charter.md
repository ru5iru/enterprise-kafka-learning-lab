# Project charter — project objectives

**Task:** P0-001 — Define project objectives
**Baseline date:** 23 November 2026
**Review state:** Objectives and the completed P0 planning package were self-reviewed through P0-045 on 2026-11-24. See the [phase review and artifact index](../testing/evidence/P0-phase-review.md). Owner approval of the parallel flow is recorded in ADR-0001; separate owner approval of the full planning package is not claimed.
**System state:** Planning scaffold; no application or infrastructure is implemented.

## Purpose and intended value

Build an incremental, reproducible Apache Kafka learning lab that makes distributed-system behavior observable and engineering decisions explainable. Learning is the product: the repository should let its learner implement a small capability, verify it, deliberately exercise relevant failures, and explain the outcome with evidence.

The commerce simulation provides familiar events and interactions for experiments. Its business sophistication is subordinate to understanding Kafka and the engineering needed around it. The intended beneficiary is the learner/developer using this repository; no external customer, production operator, delivery deadline, or production-readiness commitment is assumed.

Kafka supports publishing, storing, and consuming event streams, giving the lab a concrete basis for studying asynchronous interactions. This conceptual motivation follows the [Apache Kafka introduction](https://kafka.apache.org/intro/); it does not establish any delivery, availability, or performance guarantee for this lab.

## Project objectives and rationale

These objectives describe the outcomes the project should produce. The evidence column indicates how later work can substantiate each outcome; it does not define workload thresholds or claim that the outcome has been achieved.

| ID | Project objective | Why it matters | Implication and eventual evidence | Roadmap alignment |
|---|---|---|---|---|
| OBJ-01 | Establish a Kafka-first experimental foundation, progressing from a single message flow to deeper Kafka behavior. | Starting small makes the relationship between an action and its effect easier to explain before framework abstractions and multiple services complicate it. | Begin with one broker, producer, consumer, and topic; study native Java clients before Spring Kafka. Later task notes must connect configuration, observations, and explanations. | P2–P3, P5 |
| OBJ-02 | Produce a reproducible lab that evolves in verified increments. | A result is useful for learning only when another run can reproduce the setup and expose its assumptions. | Keep task-sized changes, setup instructions, verification commands, sanitized evidence, and rationale. Evolve local Compose work toward Kubernetes only at the scheduled milestones. | P1, P3, P13–P14 |
| OBJ-03 | Make distributed correctness and data-consistency trade-offs demonstrable. | A successful message on the happy path does not explain behavior under retries, duplicate processing, crashes, or partial failures. | Use the minimal simulation to compare expected and observed delivery, ordering, schema, and persistence behavior through applicable positive and failure experiments. Do not promise blanket exactly-once business processing. | P4, P6–P8 |
| OBJ-04 | Apply security and SSDLC throughout the learning process, with explicit maturity limits. | Security requirements and review belong in planning even when the corresponding runtime controls arrive later. | Use synthetic data, protect secrets and evidence, and document threats and deferred controls. Later milestones must demonstrate both permitted and denied operations. Enterprise-level study does not imply production security. | P0, P9, P13–P14 |
| OBJ-05 | Produce observable explanations of operation, failure, and recovery. | A failure experiment without observations cannot show why behavior changed or whether recovery worked. | Collect relevant logs, metrics, traces, and recovery findings as those capabilities are introduced. Preserve expected-versus-observed evidence and limitations. | P5–P6, P10, P12 |
| OBJ-06 | Base scalability conclusions on an explicit workload model and measurements. | A user count alone does not specify concurrency, message volume, or resource demand. | Treat approximately 100,000 users as a capacity-planning hypothesis. Later work must state workload assumptions, test environment, measured results, and limits before making capacity claims. | P0-019–P0-027, P11 |

## Existing decisions this charter respects

The [master roadmap](../roadmap/ROADMAP.md) and [architecture baseline](../roadmap/ARCHITECTURE.md) already establish:

- A monorepo, independently built Maven Java/Spring Boot services, and simple simulated commerce behavior.
- Apache Kafka in KRaft mode; native Java clients before Spring Kafka.
- PostgreSQL when persistence and consistency patterns are introduced.
- Docker Compose locally, followed by Kubernetes in the advanced deployment phase.
- Progressive security and enterprise-level depth in verification, operations, resilience, and SSDLC, on a flexible schedule.

P0-001 adopts these constraints without selecting versions, changing topology, adding technologies, or making a new architecture/security decision. Consequently, no ADR is introduced here; the scheduled ADR tasks remain pending.

## Implications, assumptions, and limits

Prefer the smallest experiment that teaches the scheduled concept. A new service or component should have a learning or architecture purpose; feature richness and service count are not measures of project success. The cost of this approach is slower visible feature delivery and continued documentation effort, in exchange for interpretable results and traceable decisions.

Progress means verified outcomes with learning records, not generated files or untested diagrams. The [CSV ledger](../roadmap/Kafka_Learning_Lab_Task_Checklist.csv) remains authoritative for task status. The 15-phase, 726-task roadmap and its static Markdown checklists remain unchanged. One task is executed at a time.

Only synthetic development data is intended. No endpoints, trust boundaries, credentials, certificates, authentication, authorization, or encrypted channels are implemented by this document. Follow the [security baseline](../security/SECURITY_BASELINE.md): Kafka TLS/mTLS/SASL/ACL exercises are deferred to P9, Kubernetes hardening to P13, and full release security gates to P14, with hygiene and review starting now. Security integrated into the lifecycle is also the premise of [NIST's SSDF overview](https://csrc.nist.gov/Projects/ssdf); this charter does not assert SSDF compliance.

Hardware capacity, exact compatible software versions, workload rates, latency targets, availability objectives, recovery objectives, and implementation results remain unknown. They must be established by their assigned tasks and evidence. The flexible schedule supplies no basis for inventing a completion date for the overall project.

## Relationship to remaining P0 work

P0-002 will translate these project outcomes into learner competencies. P0-003–P0-008 will elaborate scope, technologies, simulation, components, and target architecture. P0-009–P0-018 will define detailed requirements and measurable acceptance criteria; P0-019–P0-027 will model workload and service objectives. P0-028–P0-036 will develop diagrams, boundaries, and threats, and P0-037–P0-045 will record the scheduled architecture decisions.

Those tasks are future work. This objectives document is one component of the eventual phase-P0 project charter and deliverables; it is not approval of the full phase gate.

## P0-001 review and evidence

The task acceptance criterion is to document the concept/decision, rationale, and implications in a relevant project file. Its verification method permits self-review against the phase objectives. The six objectives above provide that work product; see the [task learning record](../learning-notes/P0/P0-001.md) and [document review and integrity evidence](../testing/evidence/P0-001-review.md) for the actual review, limitations, and checks. No independent peer approval is claimed.
