# Continuous integration and failure diagnosis

[Lab CI](../../.github/workflows/ci.yml) builds the tooling module and independently selected P2 Spring Boot starter on GitHub-hosted Ubuntu. Develop in the existing Windows checkout and run locally in [Ubuntu WSL](wsl-setup.md). The starter is non-web; no Kafka broker or PostgreSQL server exists yet.

## Local and hosted execution

Inside WSL at repository root:

```bash
bash scripts/wsl/lab.sh mvn clean verify
python3 scripts/ci/verify-test-reports.py
bash scripts/wsl/lab.sh sh mvnw -f applications/lab-starter/pom.xml clean verify
bash scripts/wsl/lab.sh python3 scripts/ci/verify-starter.py
```

Hosted steps check source identity and credential persistence, verify Ubuntu x86_64, install checksum-pinned Oracle JDK 25.0.5.1/Maven 3.10.2, test compiler rejection paths, then run the same clean verify and report guard. The tooling suite is one unit test and one integration test. The starter adds one context smoke test, executable-JAR layout/dependency checks and bounded positive/negative packaged startup checks. All test reports must have zero failures/errors/skips and nonempty suites. The root reactor intentionally excludes the application; CI invokes its POM separately through the checksum-pinned Maven 3.10.2 wrapper. See [starter commands](../../applications/lab-starter/README.md) and [ADR-0015](../architecture/decisions/0015-minimal-spring-boot-starter.md). Formatting, Checkstyle, compiler lint and dependency convergence also run. These gates do not test Kafka behavior or scan vulnerabilities.

Push path filters cover workflow, POM, .mvn, wrapper scripts, applications, tools and scripts. Documentation-only completion commits intentionally skip push builds. Pull requests are unfiltered; the PR merge-test SHA differs from a branch head. A full-commit checkout pin and HEAD/GITHUB_SHA check establish the actual revision tested. No workflow_dispatch is required while the workflow is still on topic branches.

## Failure and artifact behavior

Start with the first failed step. A Maven failure keeps the job failed; no continue-on-error or skip-test escape is used. After report preparation, the one-minute-bounded failure() step writes a static annotation and summary with run/revision and the local command; no PR title, payload or environment dump is interpolated. The same Markdown is retained alongside sanitized JUnit XML. Checkout/setup failures can have no tests; checkout failure still receives the inline summary but cannot upload through the checkout-dependent artifact step.

Reports reconstruct only suite counters, testcase name/class/time and failure/error/skipped type. Properties, captured output and exception text are removed. Names/types and console logs still need source review: sanitization is not general DLP. The `lab-test-reports-<run>-<attempt>` artifact contains sanitized reports from both build targets. Artifacts retain seven days, use run/attempt identity, and exclude hidden files/caches. A missing upload warns so early build failure remains the diagnosis; the independent report guard rejects missing suites after a successful build. Artifact upload failures use GitHub native step reporting because the custom summary precedes upload. Cancellation/runner loss may prevent summaries/artifacts altogether.

## Recovery and residual risks

Reproduce in WSL, repair the source/tool pin under review and rerun. Never disable TLS, hashes or test failure to force green. Oracle latest URL can move; a changed hash fails closed. Maven uses project-scoped HTTPS Central mirror and strict checksums. Current Spotless/JDK Unsafe warning is documented; local Ubuntu defaults to root and was not changed. Hosted tests run under the normal runner account after sudo tool installation.

Read-only token, pinned actions, no secrets and ephemeral hosted runner reduce exposure. They do not enable branch protection, private reporting, SCA/SBOM, TLS/ACLs or HTTP authentication/authorization. The starter exposes no application server; later additions must reassess that boundary. See [ADR-0014](../architecture/decisions/0014-ci-trust-and-evidence.md), [review checklist](review-checklist.md) and the task evidence for actual run results. P1-043 includes an intentionally failing isolated probe branch and successful normal branch; no failure injection is retained in the normal workflow.
