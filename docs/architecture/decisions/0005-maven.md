# ADR-0005: Maven with an exact reviewed tool baseline

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted planning reference; build validation pending
- **Date:** 2026-11-24
- **Related tasks:** P0-040
- **Decision makers:** Owner-selected Maven baseline; executing agent selects current reference under P0 authorization.

## Context and decision

Use **Apache Maven 3.10.2** with the Java/Boot pair in ADR-0004. Official downloads identify this as current stable on 2026-11-24; its JDK minimum and Boot's Maven minimum are satisfied by the reference pair. This is documentary requirement compatibility, not a tested plugin/integration matrix.

Introduce a pinned wrapper, verified distribution integrity, explicit compiler release and reviewed plugins/dependencies during P1/P2. Preserve independent service builds; a parent/aggregator may share stable build conventions but must not force mutable shared business contracts or lockstep runtime releases.

## Rationale and alternatives

Maven is already owner-selected, with an explicit lifecycle and dependency-management model suited to this Java lab. Gradle would add an unnecessary alternate build language/toolchain; Maven 4 preview is not needed for the planned learning; an unpinned system executable undermines reproducibility. Use Boot management for its dependency set, and review any override.

## Consequences

Record java/mvn versions, wrapper distribution identity, plugin/dependency tree and tests when builds exist. Acquire artifacts only from reviewed official distribution paths and verify their checksums/signatures then; no download/hash or installation is claimed now. Keep repository credentials outside source and output. Changes to tool/runtime/plugin versions need compatibility/security review and meaningful regression checks.

## Validation and review

Official-source review is executed evidence. No pom, Maven wrapper, dependency resolution, unit/integration build or scan ran. P1/P2 verify clean builds and negative configuration cases; P14 verifies independent release gates. Revisit the reference before setup and on support/security changes.

## Evidence

See [task learning record](../../learning-notes/P0/P0-040.md) and [document review](../../testing/evidence/P0-040-review.md).
