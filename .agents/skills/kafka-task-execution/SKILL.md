---
name: kafka-task-execution
description: Execute exactly one task from the Enterprise Kafka Learning Lab roadmap, verify its work, document learning and security trade-offs, and update the CSV ledger without jumping ahead.
---

# Kafka Learning Lab — task execution skill

## Trigger

Use this skill whenever asked to plan, implement, review, test, document or complete a `P0-001` through `P14-052` task in this repository.

## Essential references

- `AGENTS.md` — mandatory global agent rules.
- `docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv` — canonical task ledger.
- `docs/roadmap/phases/` — phase scopes and task sequence.
- `docs/agent/TASK_EXECUTION_WORKFLOW.md` — detailed procedure.
- `docs/learning-notes/TEMPLATE.md` — mandatory educational record.
- `docs/git/CONTRIBUTION_WORKFLOW.md` — Git and Conventional Commits.
- `docs/security/SECURITY_BASELINE.md` — progressive SSDLC guardrails.

## Procedure for exactly one task

1. Parse the requested task ID and retrieve its exact CSV row and phase Markdown. Do not infer tasks from filenames.
2. Check prerequisites, acceptance criteria and verification method. If a dependency is incomplete, explain the blocker without changing unrelated task statuses.
3. Restate in a short working plan: learning goal, files to touch, risks, tests.
4. Perform just this task. For planning tasks: produce real planning artifacts; for implementation tasks: produce small functioning changes with tests.
5. Verify outcomes. Capture only *real* commands and observed results. Negative/failure tests and security review are expected when relevant; explicitly label deferred checks.
6. Write `docs/learning-notes/<P#>/<TASK-ID>.md`. Use all template sections, but tailor details; explain not just **what** but **why**, **trade-offs**, **pattern choices**, **pitfalls**, **vulnerabilities avoided**, **failure behavior** and **lessons learned**.
7. When decisions materially alter architecture, create an ADR in `docs/architecture/decisions/` and link it from the note.
8. Update only the task's tracking fields in the CSV. Preserve BOM/encoding, column order, all other rows and task IDs. Use `Done` only if the definition of done is met.
9. Propose branch name and Conventional Commit message. Commit only when requested/authorized; never push by default.
10. Return a compact handoff with task status, changed files, verification, key learning, documentation links, issues and next task. Stop before the next task.

## Learning note quality gate

Every note must answer:

- What concept did this task teach and how does it connect to Kafka/distributed systems?
- Why were the selected design and configuration chosen? Which alternatives were rejected and why?
- Which production best practices apply, and which are deliberately deferred in the learning lab?
- Which patterns, data semantics, or security trust boundaries matter?
- Which errors, operational failure modes, performance pitfalls and vulnerabilities were avoided or discovered?
- What tests or document reviews ran, what were the actual results and where is sanitized evidence?
- What is still unknown, unverified or risky, and what task addresses it next?

A note with generic textbook paragraphs but no task-specific reasoning **fails** this gate.

## Prohibited behaviors

- Inventing successful test output, references, vulnerability scan findings, evidence links or completed tasks.
- Implementing later phases while working an early planning task.
- Copying real credentials, certificates or keys into docs, tests, logs or version control.
- Updating the Markdown roadmap's static checklist as if it were the live tracker.
- Automatically pushing/merging or generating many commits for a single small task.
