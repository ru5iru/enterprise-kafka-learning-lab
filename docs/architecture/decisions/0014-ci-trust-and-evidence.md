# ADR-0014: Hosted CI trust and failure evidence

- Status: Accepted, 2026-11-24; P1-043 verifies failure and restored-success paths before completion.
- Task: P1-043; consolidates the incremental P1-037 through P1-042 pipeline decisions.

## Decision and rationale

Use GitHub-hosted Ubuntu 24.04 x86_64 with contents-read token, no repository secrets, full-commit-pinned checkout/upload actions, checkout credential persistence disabled, per-ref concurrency and a 20-minute job timeout. Reuse checksum-pinned Oracle JDK 25.0.5.1 and Maven 3.10.2 Linux installers plus the same lab launcher used in WSL. Runner images remain externally maintained; pinning an action does not freeze Ubuntu or all network dependencies.

Run full clean verify plus nonempty clean JUnit-report validation. On build/report/preparation failure, use a one-minute-bounded step to write a static error annotation, a job summary with run/revision and WSL reproduction command, and a retained Markdown copy. Publish only reconstructed JUnit XML and this fixed summary with seven-day retention. Do not upload raw properties, output, failure messages, caches or environment dumps. Test names/types and console output still need source review. Later upload-step failures have GitHub's native failed-step reporting; an abruptly cancelled/timed-out runner cannot guarantee artifact/summary delivery.

Push executable-input changes and unfiltered pull requests trigger checks. Documentation-only completion pushes intentionally skip push CI; final PR validation covers the assembled head. No pull_request_target, write token, deployment, third-party notification, privileged self-hosted runner or repository secret is needed. Branch protection and private vulnerability reporting are separate controls, not configured by this decision.

## Alternatives and consequences

A self-hosted WSL runner would expose a persistent developer machine to PR code; rejected. Hosted Linux gives OS parity without requiring WSL on Linux CI. Runner-preinstalled tool versions drift; reuse reviewed installers instead. Raw report uploads simplify debugging but may export JVM properties/payloads; reconstruct status XML and keep console logging policy explicit. Permanent retention is unnecessary for transient synthetic tests; commit durable sanitized run/evidence references instead.

Failure validation uses a separate same-task probe branch with expectedJava=99, never merged into the normal task branch. Verify real failed conclusion, summary and artifact, then confirm the normal branch is green. Preserve published history and probe branch; no force-push or automatic deletion. No application/Broker/DB is implemented by this pipeline.

## References

- [Workflow](../../../.github/workflows/ci.yml), [CI guide](../../development/continuous-integration.md).
- [Runtime ADR](0011-wsl-development-runtime.md), [build ADR](0013-p1-build-verification.md).
- [GitHub workflow commands](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-commands).
