# Branching, reviews and Conventional Commits

## Strategy

Use **GitHub Flow**, appropriate for one-person/agent-supported incremental learning: keep `main` stable; create short-lived topic branches from `main`; open focused PRs; review/verify; squash or merge intentionally. Avoid long-lived `develop`, `release/*`, or per-microservice branches unless a later ADR establishes a real need.

- Branch examples: `docs/P0-001-project-objectives`, `chore/P1-003-gitignore`, `feat/P3-034-first-producer`, `test/P6-017-consumer-crash`.
- Format: `<type>/<TASK-ID>-<short-kebab-description>`; keep one task per branch by default.
- Do not push directly to protected `main`; never force-push others' work.
- Agent must not automatically create commits/push/merge unless authorized by the user.

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
