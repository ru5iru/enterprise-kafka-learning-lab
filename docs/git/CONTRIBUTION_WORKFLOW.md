# Branching, reviews and Conventional Commits

## Strategy

Use **GitHub Flow**, appropriate for one-person/agent-supported incremental learning: keep `main` stable; create short-lived topic branches from `main`; open focused PRs; review/verify; squash or merge intentionally. Avoid long-lived `develop`, `release/*`, or per-microservice branches unless a later ADR establishes a real need.

- Branch examples: `docs/P0-001-project-objectives`, `chore/P1-003-gitignore`, `feat/P3-034-first-producer`, `test/P6-017-consumer-crash`.
- Format: `<type>/<TASK-ID>-<short-kebab-description>`; keep one task per branch by default.
- Do not push directly to protected `main`; never force-push others' work.
- Agent must not automatically create commits/push/merge unless authorized by the user.

## Branch naming (P1-005)

Use `<type>/<TASK-ID>-<short-kebab-description>`. The type is one of `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `build`, `ci`, `chore`, `revert`. Preserve the uppercase task ID exactly as it appears in the CSV; use lowercase ASCII letters/digits separated by single hyphens for the description. Use a concrete action/topic, not a person, ticket URL, secret, customer identifier or generic `work` name.

| Example | Review result |
|---|---|
| `docs/P1-005-branch-naming` | Accept: exact task, descriptive lowercase suffix |
| `chore/P1-003-gitignore` | Accept: repository configuration |
| `test/P6-017-consumer-crash` | Accept: experiment verification |
| `feature/P1-005-branch-naming` | Reject: unsupported type alias |
| `docs/p1-005-branch-naming` | Reject: task ID case changed |
| `docs/P1-005-Branch_Naming` | Reject: suffix is not lowercase kebab case |
| `docs/P1-999-branch-naming` | Reject: task ID does not exist in the ledger |

The repository policy is stricter than Git's ref syntax. `git check-ref-format --branch docs/P1-005-branch-naming` checks Git syntax; separately check type, task existence and scope against the CSV. No hook or CI naming enforcement is installed by this documentation task.

Start normal work from current main. For an explicitly authorized sequence whose preceding task is published but unmerged, a new task branch may be stacked on that predecessor: first verify its clean tree and remote tip, then create the next branch. State the parent/base in the handoff or PR and review the task diff against that parent. Do not rebase published branches or merge the sequence automatically. See the [P1 repository baseline](repository-baseline.md) for the currently authorized sequence.

Do not rename historical published branches solely to apply this policy. For an unpublished naming mistake, create a correctly named branch at the intended commit after checking the tree; retain anything needed for recovery. For a published mistake, coordinate a non-destructive correction without force-pushing or deleting someone else's work.

References: [Git ref syntax](https://git-scm.com/docs/git-check-ref-format), [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow).

## Conventional Commits

Format:

```text
<type>(<scope>): <imperative summary>

<optional body explaining why, not only what>

Refs: P3-034
```

Common types: `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `build`, `ci`, `chore`, `revert`. Reserve `!` or `BREAKING CHANGE:` footer for genuinely breaking changes. Use clear lowercase scopes (`kafka`, `order`, `security`, `docs`, `build`, `scope`). Keep subject focused and roughly 72 characters or less where practicable.

**Examples:**

```text
docs(scope): define project objectives

Establish goals, scope constraints and measurable learning outcomes.

Refs: P0-001
```

```text
feat(kafka): publish first order event with native producer

Use explicit serialization and verify the message through Kafka CLI.

Refs: P3-034
```

```text
test(security): verify client certificate rejection

Record expected TLS failure and redacted evidence.

Refs: P9-033
```

### Semantics and local requirements (P1-006)

Use [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/). `feat` introduces a capability; `fix` corrects a defect. Use `docs` for learning/policy documents, `test` for verification behavior, `chore` for repository maintenance, and `build`/`ci` for build/pipeline changes. A task being completed does not make a documentation change a feature. Scope is optional in the specification; when used here, keep it short, lowercase and concrete.

Our local review requires a present-tense imperative description and `Refs: P#-###` for the exact task from the CSV. A body is optional; use it for motivation and consequential trade-offs, separated by a blank line. Keep secrets, private URLs and personal payloads out of subject/body/footer because history is shared. The roughly 72-character subject preference is local guidance, not a limit imposed by the specification.

`!` after type/scope or a `BREAKING CHANGE: ...` footer declares a real incompatible contract change. Explain what breaks and the migration path; do not label ordinary planning progress as breaking. No automated version bump, changelog generator or commitlint hook is installed. The specification's versioning semantics are not a claim this lab has released versioned software.

Examples for review (synthetic messages, not claims of implemented features):

```text
docs(git): define conventional commit semantics

Explain task traceability without enabling release automation.

Refs: P1-006
```

```text
feat(kafka)!: require explicit event schema version

BREAKING CHANGE: consumers must read the new schema version field; migrate
consumers before replaying records using the new contract.
Refs: P7-001
```

```text
revert(git): revert branch policy clarification

Reverts: <full-commit-sha>
Refs: P1-005
```

Reject `Update stuff` (no structured type), `docs(git): ` (empty description), and an otherwise valid `docs(git): clarify policy` without a task footer (missing local traceability). Do not invent an issue number or use closing keywords unless an actual issue is intended to close.

Before committing, inspect the staged diff and intended message. Correct an unpublished message only when authorized and safe; after publication prefer a normal follow-up/revert with an explanation. Do not amend/rebase/force-push shared history merely for cosmetic message consistency. Merge commits may retain the hosting platform's merge metadata; keep task commits traceable and use a Conventional Commit merge title when preparing it deliberately.

## Commit and PR checklist

1. Start from an up-to-date `main` and use a new topic branch.
2. Work on one task; split multiple logically separate changes only if each commit remains reviewable and buildable.
3. Verify `git diff --check`, inspect staged files and run task-relevant checks.
4. Ensure task learning note, needed ADR and CSV updates are included.
5. Ensure no credentials, private certificates, generated data or unrelated files are staged.
6. Use Conventional Commits and reference the task ID.
7. Complete PR template with why, what, tests, learning, risks and docs.
8. Merge only after review/acceptance. Do not claim a task is Done until its acceptance criteria hold.

## Versioning and history

- Prefer small, reversible commits; do not rewrite shared history.
- Keep source roadmap as a baseline; architectural changes are documented in dated ADRs and related tasks.
- Commit lockfiles / Maven version pins where introduced, with rationale.
- Never commit binary test reports, database dumps or keys just to provide 'evidence'. Use redacted lightweight summaries.
