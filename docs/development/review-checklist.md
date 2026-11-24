# Change review checklist

Use this checklist with the [contribution workflow](../git/CONTRIBUTION_WORKFLOW.md), [Definition of Done](../agent/DEFINITION_OF_DONE.md) and [PR template](../../.github/pull_request_template.md). Record the reviewed base/head and actual evidence. Agent/author self-review is acceptable here when disclosed; it is not independent approval.

## Scope and learning

- Confirm the exact CSV task, completed dependency and acceptance criteria; compare the diff with the preceding published task for a stack and with main for consolidation.
- Include all 11 tailored learning-note sections, decisions and alternatives, commands/results, residual risks and rollback. Add an ADR for a significant architecture/security change.
- Update only legitimate tracking fields on this task; preserve 726 IDs/order, 15 phases and dependencies. Do not mark Done for generated files alone.
- Confirm that no later task or premature service, broker, database or deployment stack slipped into the change.

## Java and configuration

- Follow [package](package-naming.md), [class](class-naming.md), [exception](exception-handling.md), [logging](logging.md), [configuration](configuration.md) and [dependency](dependency-management.md) policies.
- Check service ownership, immutable data, explicit errors and interrupt handling. Avoid broad catches, silent failures, unbounded retries, uncontrolled replay and hidden commits when messaging code exists.
- Require typed configuration validation before client creation, bounded values, clear precedence and allowlisted logs. An environment variable does not make a secret safe to log.
- Review resolved dependency/plugin versions, compatibility, repository provenance and transitive changes. Convergence is not a vulnerability scan.

## Verification and security

- Develop in the existing Windows checkout; execute Java, Maven and containers in Ubuntu WSL using [setup](wsl-setup.md). Windows Git remains the publisher; avoid concurrent Git mutations.
- For changed Java/build files run `bash scripts/wsl/lab.sh mvn clean verify` inside WSL from the repository root. Confirm one tooling unit test and one tooling integration test currently run; these are not Kafka integration tests.
- For changes to gates, run `bash scripts/wsl/verify-test-gates.sh` and/or `bash scripts/wsl/verify-quality-gates.sh` as relevant. Include failed experiments and successful restoration. Documentation-only edits require documentary review, not unrelated runtime tests.
- Inspect `git diff --check`, staged file scope, local links and added content for secrets, private data, generated outputs and unexpected network exposure. Never paste credentials or full environment dumps into evidence.
- Distinguish actual CLI/CI results from suggested checks. Hosted CI is scheduled for P1-037 onward; this checklist does not assert it exists yet.
- Current limits: Ubuntu defaults to root, though ordinary-user development is recommended; no account change was made. Spotless emits a JDK Unsafe deprecation warning. Private vulnerability reporting remains disabled; use the documented security-policy fallback. No SCA/SBOM/runtime-security assurance is implied by the current gates.

## Decision and recovery

- Record blocking findings separately from suggestions. Failed applicable tests, missing learning evidence, sensitive data or unmet dependency block completion; fix and recheck the final head.
- Confirm Conventional Commit plus exact `Refs:` task footer, review staged files, and push/merge only within user authorization. Never force-push shared work or bypass required checks.
- Explain safe rollback and dependent-task effects. Published corrections are new commits; do not rewrite evidence to hide failures.
- Record the actual review outcome and reviewer role in task evidence. Branch protection and independent approval are separate controls; this document does not enable either.

## Applied review examples

A documentation-only policy change with valid links, tailored rationale and unchanged runtime can pass a documented self-review. A green formatting check with an empty test suite cannot satisfy an implementation test requirement. A failed broad-catch probe is useful negative evidence only after the fixture is removed and the full build passes again. A leaked credential blocks publication even if Maven passes.
