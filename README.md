# Enterprise Kafka Learning Lab

A learning-first monorepo for Apache Kafka in KRaft mode, native Java clients, Spring Boot/Spring Kafka, PostgreSQL and enterprise engineering. Simple simulated commerce provides experiments; learning Kafka is the product.

## Current state

P0 planning is complete and merged. P1 is complete on this topic branch: repository standards, WSL development tools and passing hosted CI. See the [P1 phase review](docs/testing/evidence/P1-phase-review.md). P2 has not started. See the [authoritative task CSV](docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv) for status on this branch; the 15 phase Markdown checklists are the historical plan, not live tracking.

**No Java application, broker, Compose stack, database or Kubernetes deployment is implemented.** A tooling-only Maven module now verifies compiler, unit/integration tests, formatting and static checks locally; it is not a business application. Hosted CI runs the same tooling build and retains sanitized test reports; see the [CI guide](docs/development/continuous-integration.md). See the [quality gate guide](docs/development/quality-gates.md). The [P0 review](docs/testing/evidence/P0-phase-review.md) distinguishes planning evidence from future runtime verification. The 100,000-user scenario is a workload hypothesis, not a benchmark claim.

## Start learning

Git and a Markdown reader are enough to inspect the current documentation. Reading the documentation needs no runtime dependencies. Building the tooling probe uses the verified [WSL environment](docs/development/wsl-setup.md); installation/verification evidence is recorded per P1 task.

```text
git clone https://github.com/ru5iru/enterprise-kafka-learning-lab.git
cd enterprise-kafka-learning-lab
```

1. Read [AGENTS.md](AGENTS.md) and the [task execution skill](.agents/skills/kafka-task-execution/SKILL.md) before changing files.
2. Review the [charter](docs/requirements/project-charter.md), [learning objectives](docs/requirements/learning-objectives.md) and [scope](docs/requirements/scope-boundaries.md).
3. Select the authorized task from the [roadmap](docs/roadmap/ROADMAP.md) and CSV, then check its dependencies and [Definition of Done](docs/agent/DEFINITION_OF_DONE.md).
4. Study, make one scoped change, verify positive/negative cases where applicable, record a [learning note](docs/learning-notes/TEMPLATE.md) and sanitized evidence, then update only that task's tracking fields.
5. Follow [contribution instructions](CONTRIBUTING.md) and [Git conventions](docs/git/CONTRIBUTION_WORKFLOW.md). Agents commit, push or merge only with authorization. A multi-task request is executed sequentially, not by bulk-marking tasks Done.

## Learning path and decisions

Learn native Kafka clients before Spring Kafka. Begin with one broker/topic/producer/consumer in P3; introduce services in P4, internals and reliability in P5/P6, contracts and persistence in P7/P8, security and observability in P9/P10, and measured scale, recovery, Kubernetes and delivery in P11-P14.

The [target architecture](docs/architecture/target-architecture.md) uses parallel Payment and Inventory consumers of OrderCreated, as recorded in [ADR-0001](docs/architecture/decisions/0001-parallel-payment-inventory.md). These are planned components. [ADR-0002](docs/architecture/decisions/0002-monorepo.md) retains independent service builds in one repository. [Version decisions](docs/architecture/decisions/) record dated choices and future compatibility checks; reading them does not install the tools.

## Find the documentation

| Need | Location |
|---|---|
| Roadmap, 15 phases, 726 stable tasks | [docs/roadmap](docs/roadmap/ROADMAP.md) |
| Requirements and workload assumptions | [docs/requirements](docs/requirements/README.md) |
| Diagrams and architecture decisions | [docs/architecture](docs/architecture/README.md) |
| Per-task learning and verification | [Learning notes](docs/learning-notes/README.md), [evidence](docs/testing/evidence/README.md) |
| Agent workflow and completion rules | [docs/agent](docs/agent/TASK_EXECUTION_WORKFLOW.md) |
| Git and verified repository settings | [Workflow](docs/git/CONTRIBUTION_WORKFLOW.md), [baseline](docs/git/repository-baseline.md) |
| Security and SSDLC | [Security policy](SECURITY.md), [baseline](docs/security/SECURITY_BASELINE.md), [handbook](docs/roadmap/SSDLC_AND_VERIFICATION.md) |
| Full navigation | [Documentation index](docs/README.md) |

Application and infrastructure directories in the [source blueprint](docs/roadmap/ARCHITECTURE.md) are future structure. Create them only during assigned tasks, not merely to resemble the diagram.

## Safety and help

Use synthetic data only. Never commit credentials or private keys, and never expose an intentionally unsecured lab to untrusted networks. TLS/mTLS, SASL/ACLs, scanning and recovery remain progressive learning work, not implemented guarantees.

For roadmap questions or sanitized defects, use the repository [issue templates](.github/ISSUE_TEMPLATE/task.md). For a suspected vulnerability, follow [SECURITY.md](SECURITY.md) and avoid public exploit details. The repository owner maintains this learning project; no response-time or production-support commitment is implied.
