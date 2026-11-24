# Documentation index

P0 planning is complete. Repository foundation tasks have task-specific P1 learning and evidence records; consult the [CSV](roadmap/Kafka_Learning_Lab_Task_Checklist.csv) for exact status on this branch. No application or infrastructure runtime is implemented. Planning artifacts, operational procedures and executed experiments are distinct kinds of documentation.

## Navigate by purpose

| Area | Entry point and responsibility |
|---|---|
| Roadmap | [Master plan](roadmap/ROADMAP.md), [15 phase documents](roadmap/phases/), [original complete plan](roadmap/COMPLETE_ROADMAP.md); preserve historical baseline |
| Requirements | [Charter, objectives, scope, workload and acceptance](requirements/README.md) |
| Architecture | [Target diagrams and decision index](architecture/README.md); source blueprint stays in roadmap |
| Kafka | [Kafka learning navigation](kafka/README.md); experiment records appear only when executed |
| Security | [Security navigation](security/README.md), policy, trust boundaries and open STRIDE risks |
| Git/editor | [Contribution/review rules](git/CONTRIBUTION_WORKFLOW.md), [repository baseline](git/repository-baseline.md), [editor settings](git/editor-settings.md) |
| Agent protocol | [Task workflow](agent/TASK_EXECUTION_WORKFLOW.md), [Definition of Done](agent/DEFINITION_OF_DONE.md), [handoff](agent/HANDOFF_TEMPLATE.md) |
| Testing | [Verification guidance and evidence](testing/README.md); distinguish review from runtime tests |
| Operations | [Runbook scope](operations/README.md); no tested runtime procedures yet |
| Learning | [Journal rules/template](learning-notes/README.md), [P0 review/index](testing/evidence/P0-phase-review.md), [P1-001 through P1-012 journal](learning-notes/P1/README.md) |

Start at the [root README](../README.md) for onboarding or [CONTRIBUTING.md](../CONTRIBUTING.md) before proposing changes. The [P1 foundation review/index](testing/evidence/P1-001-012-review.md) links this authorized sequence; it is not a P1 phase-gate completion claim.

## Where new material belongs

- Put a task's educational explanation in `learning-notes/<phase>/<TASK-ID>.md`, using all [11 template sections](learning-notes/TEMPLATE.md).
- Put small sanitized observations/reproducible checks in `testing/evidence/<TASK-ID>-review.md` and link them from the note/CSV.
- Put durable requirements in `requirements/`, diagrams in `architecture/` and significant decisions in numbered [ADRs](architecture/decisions/README.md). Preserve prior evidence and document superseding decisions explicitly.
- Put Kafka explanations/experiment navigation in `kafka/`, security policy/design in `security/`, and tested operating procedures in `operations/` only when their components exist.
- Use relative links between repository documents; copied issue/PR bodies use explicit repository URLs because their rendering context differs. Link the owning source rather than copying its changing content.

Use descriptive lowercase hyphenated filenames for new topic documents, exact uppercase task IDs for task records and existing numbered ADR conventions. Keep one canonical task note; do not pre-create empty future task records or move historical evidence to make a new tree look complete. An index is navigation, not an implementation or test result.

## Verify documentation changes

Check local file/directory targets, task-ID/evidence consistency, CSV scope and `git diff --check`. Exclude fenced example code when scanning prose links. Heading fragments, external uptime and rendered Mermaid/UI behavior require separate checks; do not claim them from a filesystem link scan. Follow the [security policy](../SECURITY.md) before sharing findings or excerpts.
