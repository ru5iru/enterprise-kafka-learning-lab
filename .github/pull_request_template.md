<!-- Keep secrets, private keys, personal data and sensitive exploit details out of this public body. Follow SECURITY.md for private reporting. Replace prompts with actual facts; unchecked boxes do not mean a check passed. -->

## Task and scope

- Exact task ID/title and phase:
- Dependency IDs and current CSV statuses:
- Head branch/commit and intended base branch/commit:
- Included files/behavior and excluded later work:
- One task by default; if an explicitly authorized sequence/package, state that scope and the parent/base used to isolate each task:

## Problem and resulting behavior

Describe the concrete problem and what a learner/developer sees after this change. Distinguish implemented behavior, planning targets and unchanged assumptions. Include a before/after example when useful.

## Design and trade-offs

- Chosen approach and why:
- Alternatives and consequences:
- Architecture/contract/trust-boundary effects; linked ADR if needed:
- Reliability, performance and security implications:

## Verification and evidence

Record only executed checks as executed. For every applicable skipped check, state the gap; use N/A with a reason for irrelevant checks. A documentation task does not need a fabricated runtime test.

| Command or review | Expected | Actual result and exit/outcome | Evidence path/link |
|---|---|---|---|
| Replace with an executed check, or Not run / N/A plus reason | | | |

- Positive case:
- Negative/failure case and observed correction, or N/A with reason:
- CI state: passed / failed / pending / not configured (include actual run link when one exists):
- Review type: self-review or independent review; reviewer and reviewed head if applicable (do not invent an approval):

## Documentation and tracker

- [ ] Scoped acceptance criteria met and relevant dependencies Done
- [ ] `docs/learning-notes/<phase>/<TASK-ID>.md` includes decisions, alternatives, patterns, risks and lessons
- [ ] Sanitized verification evidence linked; planned work is not described as executed
- [ ] Applicable ADR/diagrams/documentation updated, or N/A explained
- [ ] Only legitimate task tracking fields changed; all IDs/order/dependencies and unrelated CSV rows preserved
- [ ] Staged/final diff checked for secrets, private data, unintended files and whitespace errors

## Risks and rollback

- Known limitations, unverified assumptions and deferred controls with owning task/phase:
- Safe rollback/recovery and effects on dependent tasks or data:
- Remaining blocking findings (resolve before merge):

## Commit and merge review

- Proposed/actual Conventional Commit: `type(scope): imperative subject`
- Task footer: `Refs: P#-###` (exact existing task, no invented issue closure)
- [ ] Final head/base and affected verification rechecked after substantive updates
- [ ] Blocking findings resolved; required checks/protection respected
- [ ] Merge action is authorized; selected merge method preserves needed evidence/history

[Contribution/review rules](https://github.com/ru5iru/enterprise-kafka-learning-lab/blob/main/docs/git/CONTRIBUTION_WORKFLOW.md) · [Definition of Done](https://github.com/ru5iru/enterprise-kafka-learning-lab/blob/main/docs/agent/DEFINITION_OF_DONE.md) · [Security policy](https://github.com/ru5iru/enterprise-kafka-learning-lab/blob/main/SECURITY.md)
