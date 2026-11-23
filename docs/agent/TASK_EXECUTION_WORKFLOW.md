# Agent task execution workflow

> This is a **repeatable protocol** for every task, including planning and documentation-only tasks.

## Step 1 — Select and validate scope

- Accept one explicit task ID. Fetch the exact CSV row and phase document; check dependency status.
- Read current requirements, architecture and related task notes; list relevant source files.
- If requirements conflict, stop the conflicting change and document the question. Do not silently rewrite the roadmap.
- Present task goal, deliverable, verification and changes expected before implementation.

## Step 2 — Study and reason

- Define the underlying concept and why it matters to Kafka/Java/Spring/distributed systems.
- Compare applicable practices; explain chosen trade-offs in terms of *learning now* vs *production later*.
- Identify SSDLC needs, trust boundaries, data consistency and failure modes.
- Consult authoritative documentation for version-sensitive or security-sensitive claims; record links and version dates if available.

## Step 3 — Implement minimal scope

- Make the smallest change satisfying the task; do not add future features 'for convenience'.
- Preserve service boundaries, independent builds, readable names and configuration safety.
- If a task is documentation-only, deliver a real reviewed document, not scaffolding masquerading as completion.

## Step 4 — Verify and capture evidence

- Run checks appropriate to the task: document cross-review; code formatting/tests; CLI experiment; security negative tests; broker restart/failure exercises, etc.
- Record exact commands, environment, expected vs actual results, and sanitized evidence in the learning note or a linked evidence record.
- Never claim a check passed if it was not executed; identify limitations and blockers.
- Apply security review: secrets, authentication, authorization, input validation, dependency risk, unsafe defaults and sensitive output.

## Step 5 — Document learning **before** completion

Create `docs/learning-notes/<P#>/<TASK-ID>.md` from the mandatory template. Cover:

1. Problem and Kafka context; concepts learned.
2. Implemented artifact, behavior and how it works.
3. Best practices and design patterns actually applied.
4. Decisions made, rationale, alternatives and trade-offs.
5. Errors and security vulnerabilities avoided, found or deferred.
6. Failure/negative scenarios, troubleshooting and operational implications.
7. Verification evidence and limitations.
8. Connections to the next task; questions for further study.

For meaningful architectural choices, create an ADR. For changed flows, update Mermaid diagrams. Do not copy untested guesses into the 'Observed' section.

## Step 6 — Update the tracker

- Keep all 726 IDs, 18 columns, ordering and dependency strings intact.
- Set `In Progress`, `Blocked` or `Done` (existing CSV baseline uses `Not Started`).
- Update `Actual_Hours`, `Completed_Date`, `Notes`, and `Evidence_Link` only from real information. Do not invent an owner, dates or time spent.
- `Done` requires the [definition of done](DEFINITION_OF_DONE.md); **do not update static Markdown phase checkboxes**.

## Step 7 — Git and agent handoff

- Propose a branch and Conventional Commit message containing the task ID in the commit body or footer.
- If Git operations are authorized, inspect `git status` and commit only intended files; never force-push or push without approval.
- Respond using [handoff template](HANDOFF_TEMPLATE.md), including any unresolved risks. Stop after the selected task.

## Example

Task `P0-001` → branch `docs/P0-001-project-objectives` → note `docs/learning-notes/P0/P0-001.md` → documentation work product `docs/requirements/project-charter.md` → document review evidence → CSV row updated only when validated → proposed commit `docs(scope): define project objectives` with footer `Refs: P0-001`.
