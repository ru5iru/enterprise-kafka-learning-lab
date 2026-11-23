# AGENTS.md — Enterprise Kafka Learning Lab

This file governs **all** coding agents operating in this repository. It is authoritative for the project unless the user explicitly changes a rule. Read it before modifying any file.

## Mission and boundaries

- **Learning is the product.** Kafka and its ecosystem matter more than simulated e-commerce features.
- Work on **one specified task ID at a time** (`P0-001`, etc.) unless explicitly instructed otherwise. **Never** opportunistically complete the next task.
- Current state is a **pre-development planning scaffold**. Do not generate Java services, Docker Compose stacks, broker configs or Kubernetes manifests to 'help' with planning tasks.
- Preserve the **15-phase, 726-task** roadmap and stable task IDs. Never renumber, bulk-mark Done, or silently rewrite the plan.
- User decisions: monorepo; Apache Kafka/KRaft; Java + Spring Boot; Maven; PostgreSQL; Compose → Kubernetes; progressive security; thorough enterprise-level learning; flexible schedule.
- Do not pretend an implementation exists. State assumptions, unknowns, skipped tests and deferred controls explicitly.

## Mandatory reading before each task

1. `README.md` and this file.
2. `.agents/skills/kafka-task-execution/SKILL.md` (the executable task workflow).
3. `docs/roadmap/ROADMAP.md` and matching `docs/roadmap/phases/P*.md`.
4. The precise row for the task in `docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv` (task, dependency, priority, acceptance, verification).
5. `docs/roadmap/ARCHITECTURE.md`, `docs/roadmap/SSDLC_AND_VERIFICATION.md`, and relevant ADRs / prior notes.
6. `docs/git/CONTRIBUTION_WORKFLOW.md` and `docs/security/SECURITY_BASELINE.md`.

## Task execution contract — mandatory

1. **Identify** the requested task ID. Confirm dependencies from the CSV. If a dependency is not Done, do not mark it Done; report the blocker or request direction.
2. **Plan briefly**: learning objectives, limited files to change, risk and tests. Prefer minimal changes.
3. **Learn before implementing**: identify the concept, why it exists, design trade-offs, expected failure modes, security implications and relevant official references.
4. **Implement only in scope**, at the smallest maintainable increment. Do not gold-plate or introduce technologies prematurely.
5. **Verify** positive, negative and failure scenarios when applicable. Record commands and sanitized output, differentiating executed checks from suggested checks. Never invent tests or evidence.
6. **Write a new task learning record** at `docs/learning-notes/<phase>/<TASK-ID>.md`, using `TEMPLATE.md`. It must explain **best practices followed, decisions and why, alternatives and trade-offs, design patterns, avoided errors and vulnerabilities, observable behavior, troubleshooting, tests, limitations, and what to study next**. If a section is not relevant, say why.
7. **Create/update an ADR** if the task makes a significant architecture or security decision; do not substitute an ADR for the task note.
8. **Update the task CSV** safely: preserve header, original task IDs/order, dependencies, rows and UTF-8 encoding; change only the relevant fields. Mark `Done` **only when** acceptance and evidence criteria are actually met. Otherwise use `In Progress` or `Blocked` and explain the gap.
9. **Git discipline**: small focused changes, branch names and Conventional Commit format per contribution workflow. Do not automatically push, force-push, merge, rebase shared branches, or create a commit unless the user has authorized Git actions. Suggest the exact commit message in the handoff.
10. **Handoff**: list files changed, concepts learned, decisions, test results, security concerns, CSV status, evidence link, and precise next task. Stop.

## Documentation is non-negotiable

A task is not complete without its learning note and applicable verification. Code without explanation is an unfinished learning task. Don't copy generic boilerplate without tailoring it to what was *actually* implemented or studied. For a documentation-only planning task, record reviewed sources, assumptions, validation approach and decisions instead of inventing runtime evidence.

## Coding and architecture standards (when coding phases begin)

- Prefer current stable, **mutually compatible** versions and record exact choices in an ADR; do not guess compatibility.
- Keep service builds independent; prefer narrow domain boundaries; no cross-service database access or shared mutable business contracts.
- Native Kafka client first, Spring Kafka next; distinguish broker, controller, topic, partition, consumer group, producer and consumer.
- Prefer clear immutable event models, explicit error handling and configuration validation; respect ordering and delivery semantics.
- Avoid `catch(Exception)` swallowing, unbounded retries, uncontrolled message replay, hidden offset commits, unreviewed automatic topic creation and ambiguous timeouts.
- Tests: fast unit tests and integration tests (Testcontainers where appropriate), negative cases, and failure experiments with observable evidence.
- Security: no production credentials, private keys, real tokens or secrets in repo/logs; least privilege, pinned dependencies, reasonable defaults; document progressive mitigations as not yet implemented.
- Update diagrams, docs and changelog-style task notes when behavior changes.

## Files that must not be modified casually

- `docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv` except to update legitimate task tracking fields.
- `docs/roadmap/phases/` and original roadmap: preserve historical baseline; propose amendments and record rationale instead of silently editing prior agreed content.
- Security findings/evidence: redact keys, personal data, tokens, connection strings and sensitive environment output.

## Definition of done

See `docs/agent/DEFINITION_OF_DONE.md`. Never state completion based only on code generation. The CSV is the authoritative tracker; Markdown checkboxes in the roadmap are not live progress indicators.
