# Definition of done — per task

A task is `Done` **only if** all applicable items below are satisfied:

- [ ] Exact requested task ID identified; dependencies checked.
- [ ] Task-scoped deliverable exists and matches CSV acceptance criteria.
- [ ] Relevant security and SSDLC review performed; residual risks explicit.
- [ ] Positive and negative checks executed when applicable; no test result fabricated.
- [ ] Evidence includes observed outcome and reproducible verification or documented peer/self-review.
- [ ] Mandatory, **task-specific** learning note created with rationale, best practices, alternatives, patterns, errors/vulnerabilities, failure behavior and references.
- [ ] Relevant ADR and Mermaid/system documentation updated if architecture changed.
- [ ] No secrets, sensitive logs or private certificates committed.
- [ ] Task CSV updated accurately with `Done`, completion date and evidence pointer (if known); other rows unaffected.
- [ ] Appropriate focused Git changes prepared, with Conventional Commit suggested or made only if authorized.

If anything material is missing, leave `In Progress` or mark `Blocked` with reason. A document-only task needs documentary review evidence, not a fake integration test. A task does not need unrelated tests that do not apply.
