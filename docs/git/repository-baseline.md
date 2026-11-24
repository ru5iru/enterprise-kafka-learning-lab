# Repository baseline

Reviewed for P1-001 on 2026-11-24. The repository already existed before this task; it was adopted and verified rather than recreated.

| Setting | Observed value |
|---|---|
| Repository | [ru5iru/enterprise-kafka-learning-lab](https://github.com/ru5iru/enterprise-kafka-learning-lab) |
| Git remote | `https://github.com/ru5iru/enterprise-kafka-learning-lab.git` |
| Default branch | `main` |
| Visibility | Public |
| Archived | No |
| Issues | Enabled |
| Main branch protection | Not enabled at review time |
| P0 baseline | `ce2d8122f91744ddca2a177c6c49b9255e5f9f42`, [merged PR #3](https://github.com/ru5iru/enterprise-kafka-learning-lab/pull/3) |

GitHub API reads confirmed these settings and the completed P0 merge. Git CLI verification checks the remote URL, default HEAD and published main commit. No repository was created, renamed, deleted, made public or reconfigured by this task. Existing visibility was retained; publishing new sensitive information is prohibited.

## Reproduce the baseline check

```text
git remote get-url origin
git ls-remote --symref origin HEAD refs/heads/main
git log -1 --oneline origin/main
```

Do not put credentials in remote URLs. Use the configured credential manager without printing credential output. Fetch the remote before comparing a moving branch with a historical observation.

## Workflow and limitations

Follow [Git conventions](CONTRIBUTION_WORKFLOW.md) and [ADR-0002](../architecture/decisions/0002-monorepo.md): one monorepo, independently introduced service builds, focused task commits. For the explicitly authorized P1-001 through P1-012 sequence, each task is committed and pushed before the next topic branch is created from its completed predecessor. These stacked branches keep dependency work available without merging P1 into main automatically. Review against the preceding branch to isolate a task, or against main to inspect the accumulated package.

Branch protection and automated checks are not enabled by this baseline. Follow review rules manually; CI is scheduled for P1-037 onward. Credentials, membership changes and security settings require their own deliberate review. The P0 gate is supported by 45 Done task rows, the [phase review](../testing/evidence/P0-phase-review.md) and the owner's requested merge. This does not complete the P1 phase gate or any runtime acceptance.

## Recovery

A failed read is not evidence of repository absence: distinguish credential access, network failure and a missing remote. Recheck the configured URL and access without exposing tokens. Revert an incorrect baseline document in a new commit. Do not delete/recreate the repository, reset shared history or force-push as a recovery step.

## References

- [GitHub: creating a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository).
- [P1-001 learning record](../learning-notes/P1/P1-001.md) and [verification](../testing/evidence/P1-001-review.md).
