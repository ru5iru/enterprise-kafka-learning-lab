# Enterprise Kafka Learning Lab

> **Repository state: planning scaffold only — no application or infrastructure has been implemented.**

An incremental learning lab for Apache Kafka (KRaft), native Java Kafka clients, Spring Boot/Spring Kafka, PostgreSQL, progressive TLS/mTLS/SASL/ACL security, observability, resiliency, and eventual Kubernetes deployment. The simulated commerce domain is intentionally simple. The target **100,000-user scenario** is a *capacity-planning hypothesis*, not a benchmark claim.

## Start here

1. Read [AGENTS.md](AGENTS.md) and [SKILL.md](SKILL.md) before assigning work to a coding agent.
2. Read the [master roadmap](docs/roadmap/ROADMAP.md), [system architecture](docs/roadmap/ARCHITECTURE.md), and [SSDLC handbook](docs/roadmap/SSDLC_AND_VERIFICATION.md).
3. Open [the CSV task ledger](docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv) — **726 tasks across 15 phases**; initial status is `Not Started`.
4. Begin with **P0-001**. Execute **one task per agent invocation** by default. No infrastructure or application code should be added before its scheduled task.
5. For each completed task, create `docs/learning-notes/P0/P0-001.md` (or its matching ID), including what was learned, decisions, trade-offs, best practices, security pitfalls, failure cases, verification evidence, and next steps.
6. Follow [task execution workflow](docs/agent/TASK_EXECUTION_WORKFLOW.md) and [Git conventions](docs/git/CONTRIBUTION_WORKFLOW.md).

## Source of truth

| Concern | Source |
|---|---|
| Scope and tasks | `docs/roadmap/` and the task CSV |
| Task completion status | CSV `Status` column only; phase Markdown checkboxes are a static roadmap |
| Agent behavior | `AGENTS.md` + `.agents/skills/kafka-task-execution/SKILL.md` |
| Task-level educational record | `docs/learning-notes/<phase>/<task-id>.md` |
| Architecture decisions | `docs/architecture/decisions/` (ADRs, when a decision is actually made) |
| Verification evidence | `docs/testing/evidence/` (sanitized, small artifacts only) |

## Agreed decisions

- Monorepo; independently deployable Maven Java/Spring Boot services introduced progressively.
- Apache Kafka in KRaft mode; learn the native client first, then Spring Kafka.
- Docker Compose local first; Kubernetes and Helm later.
- PostgreSQL when persistence / Outbox / CDC work begins.
- Progressive security with explicit trust boundaries from the outset.
- Small, verified steps with SSDLC practice and learning documentation for **every** task.

## Repository layout

```text
.
├── AGENTS.md                         # Mandatory agent rules
├── SKILL.md                          # Shortcut to the detailed skill
├── .agents/skills/kafka-task-execution/SKILL.md
├── docs/
│   ├── roadmap/                     # Original plan, diagrams, 15 phases, CSV
│   ├── agent/                       # Agent task protocol and hand-off
│   ├── git/                         # Branching and conventional commits
│   ├── architecture/decisions/      # ADR template and future ADRs
│   ├── learning-notes/              # One document per completed task
│   ├── requirements/                # Planned requirements artifacts
│   ├── security/                    # Threat-model and security templates
│   ├── testing/                     # Verification templates and evidence
│   └── operations/                  # Planned runbooks
├── .github/                          # PR and issue templates
└── .editorconfig, .gitattributes, .gitignore
```

The `applications/`, `infrastructure/`, `shared/`, `testing/`, `scripts/`, and `tools/` directories described in the [target architecture](docs/roadmap/ARCHITECTURE.md) are **not created yet**. Introduce them during their assigned tasks; do not mistake roadmap diagrams for deployed components.

## Task command to give a coding agent

> Execute **P0-001** only. Follow `AGENTS.md` and `.agents/skills/kafka-task-execution/SKILL.md`. Read the matching CSV row and phase document. Implement only that task, produce its learning note and evidence, update the CSV accurately, then summarize changes and propose a Conventional Commit. Do not start the next task.

## Key references

[Documentation index](docs/README.md) · [Contributing](CONTRIBUTING.md) · [Security policy](SECURITY.md) · [Learning-note template](docs/learning-notes/TEMPLATE.md) · [ADR template](docs/architecture/decisions/0000-template.md)

**No claims of completed tasks, test results, or security controls are made by this scaffold.**
