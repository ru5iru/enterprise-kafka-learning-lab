# Contributing

Learning is the product. Keep the simulated commerce domain small so Kafka and enterprise engineering remain visible. Contributions should make one authorized roadmap task understandable, verifiable and reviewable.

## Read first and choose scope

Read [AGENTS.md](AGENTS.md), the [task execution skill](.agents/skills/kafka-task-execution/SKILL.md), [detailed workflow](docs/agent/TASK_EXECUTION_WORKFLOW.md), [Git/review rules](docs/git/CONTRIBUTION_WORKFLOW.md) and [security policy](SECURITY.md). Review the [README](README.md) for current capabilities; architecture diagrams are not deployed systems.

Select the exact ID/title from the [task CSV](docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv). Read its phase, acceptance and verification fields and relevant prior notes/ADRs. Confirm dependencies Done; a phase gate requires evidence for its deliverable, not a fabricated CSV row. Do not clear a blocker by marking someone else's work Done. Use [task/defect issue templates](.github/ISSUE_TEMPLATE/task.md); related defects may have an unknown task, but never invent/renumber an ID.

Work on one task by default. An explicit multi-task request is executed one task at a time with each verified commit/push completed before the next begins when that sequence is authorized. Stop at the requested endpoint. Preserve all 15 phases and 726 stable tasks.

## Start a focused branch

Check for a clean working tree and preserve existing user changes. Normal work starts from up-to-date main. These are illustrative commands, not a record that they were executed for your task; replace the example branch with your actual task:

```text
git status --short --branch
git fetch origin
git switch main
git merge --ff-only origin/main
git switch -c docs/P1-011-contributing
```

Follow `<type>/<TASK-ID>-<short-kebab-description>`. For an explicitly authorized dependent stack, use the published predecessor only after verifying its clean tree/remote tip, and state that parent/base in review. See [stacking and naming rules](docs/git/CONTRIBUTION_WORKFLOW.md). Do not rebase published history, force-push or merge a sequence automatically.

## Study, change and explain

State the learning goal, limited files, risks and checks before implementing. Prefer authoritative references for version/security-sensitive choices. Make the smallest maintainable change; introduce Java services, infrastructure, tools and CI only in their assigned tasks.

Create `docs/learning-notes/<phase>/<TASK-ID>.md` from the [11-section template](docs/learning-notes/TEMPLATE.md). Explain mechanisms, decisions, alternatives, best practices/patterns where relevant, mistakes/vulnerabilities, failure behavior, troubleshooting, verification, limits and lessons. Use N/A with a reason instead of generic boilerplate. Record significant architecture/security decisions in an [ADR](docs/architecture/decisions/README.md) as well as the task note; update affected diagrams.

Respect independent service builds and data ownership when implementation begins. Use [EditorConfig guidance](docs/git/editor-settings.md); do not bulk-format historical roadmap/evidence. Review ignored state and allowed example files: .gitignore does not sanitize content or untrack secrets.

## Verify and record the truth

Run task-appropriate positive and negative/failure checks, or explain why a case is irrelevant. Preserve actual commands, expected/observed results and sanitized excerpts in [verification evidence](docs/testing/evidence/README.md). Distinguish not run, failed and N/A. Documentation-only tasks use documentary/static review; they must not invent a runtime test. If a check fails, record the cause/correction and rerun affected checks before claiming success.

Review staged content for credentials, private keys, personal data, unsafe defaults and unrelated changes. Use synthetic payloads; never publish raw environment dumps. Follow [SECURITY.md](SECURITY.md) for sensitive findings and unavailable-channel handling. No complete scanner coverage is implied by manual review.

```text
git diff --check
git add -- <explicit-task-file-paths>
git diff --cached --check
git diff --cached
```

The path placeholder above is illustrative: select actual intended files, not a broad add-all command. Run any additional task checks before staging/commit.

## Update only legitimate tracking fields

Use [Definition of Done](docs/agent/DEFINITION_OF_DONE.md) before marking Done. Otherwise leave In Progress or Blocked and explain the gap. Set dates/evidence from actual work and owner/effort only when known. Do not claim proficiency from documentation generation.

Preserve CSV header, IDs/order, task text, dependencies, unrelated rows and encoding/layout. The inherited ledger has 18 named columns plus two unnamed empty columns and CRLF in this working checkout; do not resave it through a tool that silently removes/reorders fields. Update only the selected task's legitimate tracking fields. Static phase Markdown checkboxes are not progress tracking. Issue/PR closure does not automatically mean CSV Done.

## Commit, review and hand off

Use a Conventional Commit, for example `docs(contributing): explain the task contribution workflow`, with a separate `Refs: P1-011` footer for this example. Inspect only intended staged files. Agents create commits, push or merge only when authorized by the user; continuing a previously authorized sequence does not require asking again for every routine Git step.

Open a focused PR with the [template](.github/pull_request_template.md), intended base/head, problem/result, decisions, real checks, evidence, rollback and limitations. Explicitly label self-review when no independent review occurred. No configured CI is not green CI. Resolve blockers and review substantive new commits/conflict resolutions before merging; respect protection/required checks and merge authorization.

Handoff states files, learning, decisions, executed checks, residual risks, CSV/evidence, commit/branch if created and the next task boundary. Stop rather than starting an unrequested task. A reversible correction uses a new focused commit; review dependent work before reverting accepted behavior and never rewrite evidence to erase a failure.

For navigation, use the [documentation index](docs/README.md). For non-sensitive questions/defects, use the issue templates. There is no promised response SLA or production support.
