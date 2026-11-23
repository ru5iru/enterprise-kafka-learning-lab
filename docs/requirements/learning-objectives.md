# Learning objectives

**Task:** P0-002 — Define learning objectives  
**Date:** 2026-11-23  
**Basis:** [P0-001 project charter](project-charter.md), objectives OBJ-01–OBJ-06.  
**State:** Learning targets defined and self-reviewed. Proficiency has not been assessed; all hands-on experiments below are planned for their assigned roadmap tasks, not executed in P0-002.

## Purpose and use

Translate the project's outcomes into capabilities the learner should demonstrate. Each objective combines knowledge, practical skills, concepts, experiments, verification, and an observable proficiency target. Familiar commerce events provide the test context; business feature breadth does not determine mastery.

The catalogue groups the existing roadmap into thirteen major learning objectives. LO identifiers are local references, not replacement task IDs or additional tasks. Phase mappings indicate where evidence will be developed; the [CSV dependencies and acceptance criteria](../roadmap/Kafka_Learning_Lab_Task_Checklist.csv) continue to govern execution. Native Java Kafka clients precede Spring Kafka, and Compose precedes Kubernetes. Assess each target after its mapped work, without advancing another task's status merely because related knowledge was discussed.

## Proficiency and assessment rubric

These levels are project-specific assessment labels, not an external certification or a claim of production expertise. They are cumulative and apply within the documented lab environment.

| Level | Observable capability | Evidence needed |
|---|---|---|
| L1 — Explain | Explain the mechanism and vocabulary in the learner's own words; predict a normal result and a relevant failure or limit. | Written explanation or teach-back with a checked prediction; terminology alone is insufficient. |
| L2 — Apply independently | Meet L1, build or configure the assigned capability using official documentation, and reproduce positive and negative results without copying an unexplained recipe. | Repeatable commands/setup, applicable tests, expected versus observed results, and explanation of configuration choices. |
| L3 — Diagnose and evaluate | Meet L2, form a hypothesis, isolate a fault or constraint using evidence, compare a justified alternative, and demonstrate recovery or explain the unresolved limit. | Failure/tuning comparison, observations tied to a cause, recovery/retest where applicable, trade-offs, and a defensible conclusion. |

Consulting documentation is allowed at every level. A reviewer or documented self-review must check the explanation, prediction, experiment evidence, and limitations. For each later assessment, record LO ID, associated task IDs, environment/version information, attempted level, expected/observed result, evidence path, and a result of **demonstrated**, **needs practice**, or **not assessed** in that task's learning record. A failed experiment can teach a useful lesson, but does not demonstrate a target until the learner explains it and supplies the missing evidence. P0-002 completion means this plan is defined; every learner proficiency remains **not assessed** here.

## Alignment with project objectives

| Learning objective | Capability | Charter alignment | Roadmap evidence location | Target |
|---|---|---|---|---|
| LO-01 | Build and reproduce a testable Java lab | OBJ-01, OBJ-02 | P1–P2 | L2 |
| LO-02 | Explain and operate native and Spring Kafka message flows | OBJ-01, OBJ-03 | P3 | L3 |
| LO-03 | Design and test independent event-driven services | OBJ-02, OBJ-03 | P4 | L2 |
| LO-04 | Diagnose Kafka storage, replication, and KRaft behavior | OBJ-01, OBJ-05 | P5 | L3 |
| LO-05 | Reason about delivery, retries, and processing correctness | OBJ-03, OBJ-05 | P6 | L3 |
| LO-06 | Evolve event contracts safely | OBJ-03 | P7 | L2 |
| LO-07 | Demonstrate persistence and distributed consistency patterns | OBJ-03 | P8 | L3 |
| LO-08 | Configure and diagnose layered security | OBJ-04 | P0 security design; P9 | L3 |
| LO-09 | Explain system behavior through telemetry | OBJ-05 | P10 | L3 |
| LO-10 | Model and measure workload and capacity | OBJ-06 | P0 workload tasks; P11 | L3 |
| LO-11 | Diagnose failures and demonstrate recovery | OBJ-05 | P12 | L3 |
| LO-12 | Operate the lab on Kubernetes with explicit state and security | OBJ-02, OBJ-04, OBJ-05 | P13, following Compose work | L3 |
| LO-13 | Produce reviewable engineering and SSDLC evidence | OBJ-02, OBJ-04 | P0–P1; reinforced throughout; P14 | L3 |

## Detailed objectives

### LO-01 — Build and reproduce a testable Java lab

- **Knowledge:** Explain Java event/value modeling, dependency injection, application configuration, Maven build lifecycle, test isolation, and repeatable local setup.
- **Practical skills:** Build an independent Maven application, validate configuration and input, write meaningful unit/integration tests, package the starter, and reproduce the documented setup from a clean checkout.
- **Concepts:** Separation of concerns, immutable data, explicit errors, dependency/version control, GitHub Flow, and containerized development.
- **Planned experiments:** Build and test the P2 starter after P1 setup; exercise invalid input or missing required configuration and verify its documented failure rather than silent fallback.
- **Learning verification:** A documented clean setup/build and applicable positive/negative tests pass; explain test boundaries and dependency choices. Inspect that errors are observable without leaking sensitive values.
- **Expected proficiency:** L2 by the end of P2; demonstrate an independently reproducible starter, not merely a successful IDE run.

### LO-02 — Explain and operate native and Spring Kafka message flows

- **Knowledge:** Distinguish broker, KRaft controller, topic, partition, record key, offset, producer, consumer, and consumer group; explain client configuration and the difference between position and committed progress.
- **Practical skills:** Use Kafka CLI, publish/consume keyed synthetic events with native Java clients, handle send/consume errors explicitly, then reproduce the basic flow with Spring Kafka and explain its abstractions.
- **Concepts:** Publish/subscribe, partition-local order, retained records, group membership, serialization, acknowledgement, and offset management. The [Kafka introduction](https://kafka.apache.org/intro/) provides the conceptual starting point.
- **Planned experiments:** Run one broker/topic/producer/consumer and inspect records and offsets; stop/restart the consumer to compare continuation with the recorded commit policy, and attempt a send with unavailable broker connectivity to inspect failure behavior. Compare native and Spring flows only after the native tasks.
- **Learning verification:** Correlate event keys, partition/offset output, committed offsets, restart observations, and client errors. Explain why an acknowledged publication alone does not prove successful business processing, and diagnose a connection/configuration failure with a successful retest.
- **Expected proficiency:** L3 by the end of P3, within the single-broker introductory lab; advanced delivery guarantees are LO-05.

### LO-03 — Design and test independent event-driven services

- **Knowledge:** Explain narrow service responsibilities, synchronous versus asynchronous interactions, independent deployment, and ownership of event contracts.
- **Practical skills:** Implement the scheduled simple order/payment/inventory/notification flows; keep service builds independent and compare separate consumer groups with instances in the same group.
- **Concepts:** Publish/subscribe versus competing consumption within a group, eventual consistency, domain boundaries, and avoidance of shared mutable business contracts.
- **Planned experiments:** Publish a synthetic order to independent subscriptions; add/remove a consumer instance and observe assignment/rebalance. Stop a downstream consumer and inspect which stages continue and what remains pending.
- **Learning verification:** Build/deploy services independently, correlate emitted/received events and group membership, and explain the observed subscription and interruption behavior without inventing cross-service atomicity.
- **Expected proficiency:** L2 by the end of P4; implement and explain the minimal distributed flow without enlarging the commerce domain.

### LO-04 — Diagnose Kafka storage, replication, and KRaft behavior

- **Knowledge:** Explain partitions, leaders/followers, replicas, in-sync replicas, retention/compaction, group rebalances, and KRaft metadata quorum responsibilities.
- **Practical skills:** Inspect topic/cluster metadata and storage, administer the scheduled multi-broker lab, and distinguish a data-plane problem from a metadata-plane problem.
- **Concepts:** Replication, leadership, durability/availability trade-offs, partition placement, and separation of broker and controller roles.
- **Planned experiments:** Inspect replica/leader state in normal operation; stop a broker and separately exercise the scheduled quorum-loss scenario, recording pre-failure, failure, and recovery states.
- **Learning verification:** Use administrative output and logs to explain leadership/availability changes and recovery; relate conclusions to the actual replication, acknowledgement, and quorum configuration rather than claim universal loss-free failover.
- **Expected proficiency:** L3 by the end of P5; diagnose the demonstrated topology and state what the single-broker lab could not establish.

### LO-05 — Reason about delivery, retries, and processing correctness

- **Knowledge:** Distinguish at-most-once, at-least-once, producer idempotence, consumer deduplication, and Kafka transaction boundaries. Explain why retrying or replaying an event can repeat an external side effect.
- **Practical skills:** Implement explicit commit/error handling, bounded retries, dead-letter handling and controlled replay, idempotent processing, and the scheduled Kafka transaction experiment.
- **Concepts:** Idempotent consumer, delivery versus processing semantics, poison messages, retry budgets, transaction isolation, and read/process/write atomicity. [Spring Kafka's EOS documentation](https://docs.spring.io/spring-kafka/reference/kafka/exactly-once.html) is a reference for the Kafka transaction scope, not a guarantee for database or external effects.
- **Planned experiments:** Crash a consumer before and after its recorded commit/side-effect boundaries; inject a duplicate and a poison event; compare retry exhaustion/DLT behavior and transaction commit/abort visibility using the scheduled configurations.
- **Learning verification:** Account for input records, output records, offsets, duplicates, and business side effects; explain each replay window and show bounded failure handling and a controlled recovery/retest. State explicitly which effects the transaction covers.
- **Expected proficiency:** L3 by the end of P6; justify semantics from observed failures, not a configuration label.

### LO-06 — Evolve event contracts safely

- **Knowledge:** Explain serialization, schema ownership, compatibility direction, defaults, event metadata, and why syntactic validity alone does not prove semantic compatibility.
- **Practical skills:** Define the scheduled event contracts, configure the selected registry's compatibility policy when that task occurs, and run producer/consumer contract and CI compatibility checks.
- **Concepts:** Contract testing, backward/forward/full compatibility, schema governance, and controlled evolution across independently deployed services.
- **Planned experiments:** Run old/new producer and consumer combinations for an intended compatible change; submit an incompatible schema and a malformed event and inspect the expected rejection/error path.
- **Learning verification:** Preserve the schema versions, compatibility settings, test matrix, permitted/rejected results, and explanation of the affected readers/writers. Do not select a format or registry in this planning task.
- **Expected proficiency:** L2 by the end of P7; independently demonstrate a governed evolution and a failing incompatible case.

### LO-07 — Demonstrate persistence and distributed consistency patterns

- **Knowledge:** Explain database-per-service, local transactions versus cross-system dual writes, transactional Outbox, change data capture (CDC), and Saga compensation versus rollback.
- **Practical skills:** Use the scheduled PostgreSQL stores, atomically record an entity and its outbox entry, operate the later publisher/CDC path, and implement the assigned simple compensating workflow.
- **Concepts:** Local ACID boundaries, eventual consistency, at-least-once publication, deduplication, write-ahead-log-based capture, and compensating actions. [PostgreSQL logical decoding concepts](https://www.postgresql.org/docs/current/logicaldecoding-explanation.html) explain why capture consumers must consider repeated changes after a crash.
- **Planned experiments:** Compare normal entity/outbox processing with a stopped publisher and a restart after publication; observe the scheduled CDC recovery case and force the Saga's assigned failure/compensation path.
- **Learning verification:** Correlate database rows, outbox state, captured/published events, consumer effects, and compensation results. Explain any duplicate window and demonstrate recovery without treating compensation as an automatic global rollback.
- **Expected proficiency:** L3 by the end of P8; diagnose the implemented consistency boundary, with independent service data ownership preserved.

### LO-08 — Configure and diagnose layered security

- **Knowledge:** Distinguish TLS transport protection, mTLS certificate authentication, SASL authentication, Kafka ACL authorization, and application authorization; explain certificate trust, expiry, and least privilege.
- **Practical skills:** Follow the scheduled trust-boundary/threat-model work, configure lab identities and trust, apply a minimal permission matrix, and exercise certificate/credential lifecycle procedures with synthetic data and disposable lab credentials.
- **Concepts:** Assets and trust boundaries, STRIDE, identity versus permission, PKI, secret hygiene, rotation, and auditable denial. Use the project's [security baseline](../security/SECURITY_BASELINE.md) for progression and restrictions.
- **Planned experiments:** Demonstrate one permitted operation per intended identity and a denied operation outside its permissions; test untrusted/expired certificates, invalid credentials, and scheduled rotation behavior in the isolated lab. Do not disable verification to turn a denial into a success.
- **Learning verification:** Map each observed success/denial to the expected transport, authentication, or authorization layer using sanitized evidence; demonstrate the approved correction/retest without granting broad privileges. Keep keys, tokens, and sensitive certificate material out of the repository and logs.
- **Expected proficiency:** L3 after P9, with design foundations from P0. Runtime controls remain unimplemented until their assigned tasks; studying them is not a security assessment of a deployed system.

### LO-09 — Explain system behavior through telemetry

- **Knowledge:** Explain the different questions logs, metrics, and traces answer; distinguish producer/request latency, end-to-end processing latency, throughput, consumer lag, and health signals.
- **Practical skills:** Instrument the scheduled services, correlate an event across processing stages, build the planned dashboards/alerts, and use evidence to test a fault hypothesis.
- **Concepts:** Observability, correlation, trace propagation, cardinality/cost, sensitive-data minimization, and actionable alerting.
- **Planned experiments:** Trace a normal synthetic event; slow or stop a consumer and compare input rate, lag, processing latency, and alerts before and after recovery. Inspect whether the expected signal is actually emitted.
- **Learning verification:** Link the dashboard/log/trace observations to the injected cause and recovery; explain blind spots and why an isolated metric cannot establish business correctness. Review captured fields for sensitive data.
- **Expected proficiency:** L3 by the end of P10; produce an evidence-supported diagnosis rather than only a dashboard screenshot.

### LO-10 — Model and measure workload and capacity

- **Knowledge:** Explain population versus active/concurrent users, events per user, arrival/processing rates, payload size, retention demand, percentiles, backlog, and bottlenecks.
- **Practical skills:** Develop the scheduled workload assumptions, run a reproducible baseline, vary one tuning factor at a time, and calculate capacity implications with explicit units and environment limits.
- **Concepts:** Workload modeling, benchmarking, controlled comparisons, latency/throughput/resource trade-offs, and evidence-based scaling.
- **Planned experiments:** In the assigned P0 workload tasks, construct and challenge a model for the approximately 100,000-user hypothesis; in P11, compare baseline and peak/slow-consumer cases and the scheduled tuning alternatives.
- **Learning verification:** Preserve model inputs, concurrency/rates, payloads, test duration, hardware/configuration, throughput/latency/lag/resource observations, and a justified comparison. Explain why a user count or brief peak alone cannot establish sustainable capacity.
- **Expected proficiency:** L3 by the end of P11; no numeric workload, SLO, capacity result, or hardware selection is established by P0-002.

### LO-11 — Diagnose failures and demonstrate recovery

- **Knowledge:** Distinguish availability, resilience, replication, backup, restore, recovery point objective (RPO), and recovery time objective (RTO); explain which failures each recovery mechanism addresses.
- **Practical skills:** Execute the assigned broker/service/database/network or quorum failure cases, follow recovery runbooks, and record outage/recovery timings and data reconciliation.
- **Concepts:** Fault isolation, controlled failure injection, disaster recovery, data-loss windows, and operational reproducibility.
- **Planned experiments:** Establish a healthy baseline, inject a scheduled fault, and recover; execute the assigned backup/restore or cross-cluster recovery exercise and inspect missing, replayed, or duplicated data.
- **Learning verification:** Compare the observed interruption, recovered state, and timings with the objectives defined in their later tasks; explain unmet targets and retest a justified correction. Preserve a recovery report rather than infer restore success from a backup file.
- **Expected proficiency:** L3 by the end of P12; qualify conclusions to the demonstrated failure scope and lab environment.

### LO-12 — Operate the lab on Kubernetes with explicit state and security

- **Knowledge:** Explain desired-state reconciliation, workload identity, persistent storage, service discovery, probes, RBAC, network policies, and the roles of an operator and Helm.
- **Practical skills:** Move the established lab from Compose to the scheduled supported operator-managed Kubernetes deployment, configure persistent state and constrained access, and perform documented rollout/recovery procedures.
- **Concepts:** Declarative operations, stateful workload lifecycle, stable identity/storage, least privilege, and independent deployment. [Kubernetes StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) provide background for reasoning about identity and storage; this is not an early manifest or operator choice.
- **Planned experiments:** Deploy and verify the scheduled event flow; restart a broker pod and inspect identity, storage, and recovery; exercise an intended network/permission denial using the configured security controls.
- **Learning verification:** Capture deployment state, permitted/denied connectivity, persistent data checks, rollout and recovery observations, and the explanation of operator versus application responsibilities. A recreated pod alone is insufficient proof of data recovery.
- **Expected proficiency:** L3 by the end of P13, following local Compose learning; no production cluster qualification is implied.

### LO-13 — Produce reviewable engineering and SSDLC evidence

- **Knowledge:** Explain requirement-to-test traceability, threat modeling, ADRs, task Definition of Done, test layers, dependency risk, security findings, SBOMs, and release gates.
- **Practical skills:** Maintain focused Git changes, task notes and accurate tracking; automate the scheduled independent builds, tests, contract/security scans, and release checks; triage findings and document unresolved risk.
- **Concepts:** Secure development lifecycle, supply-chain integrity, reproducible evidence, review discipline, and continuous improvement. [NIST SSDF](https://csrc.nist.gov/Projects/ssdf) provides lifecycle context, not a certification requirement.
- **Planned experiments:** Review a task from requirement through evidence and completion decision; in the assigned CI/CD tasks, run a passing pipeline and demonstrate rejection of the scheduled failing test/incompatible contract or harmless synthetic security fixture, then correct and rerun it. Use no real secret as test data.
- **Learning verification:** Show that the appropriate gate fails for the intended reason and later passes after correction; review finding disposition, artifact provenance/SBOM evidence, and residual risk. A green pipeline with omitted gates does not demonstrate those controls.
- **Expected proficiency:** L3 by the end of P14, with documentation and hygiene practiced from P0 and basic CI from P1. Full SAST/SCA/SBOM release gates remain deferred to P14.

## Experiment discipline and implications

At the assigned task, study the official documentation for the versions actually selected, state a hypothesis and expected result, establish a baseline, change one relevant condition, observe, restore/retest, and document the explanation. Use synthetic events, bounded retries/load/replay, isolated disposable lab resources, and sanitized small evidence. Agree the failure scope and recovery procedure within that task before disrupting a running lab; these descriptions authorize no new environment changes now.

Require both a working case and a relevant rejection/failure case. Do not weaken certificate verification, use broad permissions, swallow errors, or silently reset offsets merely to make a demonstration pass. If observations contradict a prediction, record that result and investigate it; do not relabel it a success.

The plan prioritizes explainable behavior over a vocabulary checklist and uses L2 for bounded construction skills and L3 where diagnosis/comparison is central. This takes more effort than following tutorials and makes environment limitations explicit. It does not add services, select versions, fix deadlines, define detailed scope (P0-003), or replace system acceptance criteria (P0-018). No new architecture/security decision or ADR is required.

## Review and references

The [P0-002 learning note](../learning-notes/P0/P0-002.md) records decisions and lessons; the [review evidence](../testing/evidence/P0-002-review.md) records actual checks. P0-001's completed [learning record](../learning-notes/P0/P0-001.md) and charter remain unchanged. The objectives follow the [master roadmap](../roadmap/ROADMAP.md), its linked phase descriptions, the [architecture baseline](../roadmap/ARCHITECTURE.md), and the [SSDLC handbook](../roadmap/SSDLC_AND_VERIFICATION.md).

Official pages linked above were consulted on 2026-11-23 for concepts. Their moving documentation versions are not software selections for this lab; compatibility and exact version choices remain assigned to later tasks. Individual experiments require renewed version-specific review when executed.
