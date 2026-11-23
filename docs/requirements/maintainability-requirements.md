# P0-015 - Define maintainability requirements

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Maintainability requirements

| ID | Requirement | Planned verification |
|---|---|---|
| MAIN-01 | Independently build/test/package service applications using Maven | Demonstrate focused service builds and identify shared tooling impact |
| MAIN-02 | Keep domain boundaries narrow and data ownership exclusive | Review dependencies and reject cross-service table access |
| MAIN-03 | Version and test event/API contracts independently of business implementation | Compatibility/contract matrix and CI evidence |
| MAIN-04 | Validate required configuration and handle errors explicitly | Missing/invalid configuration and failure-path tests; no swallowed exceptions or unbounded retries |
| MAIN-05 | Use clear immutable event/value models and explicit ordering/delivery semantics | Code/contract review plus positive/negative tests |
| MAIN-06 | Provide reproducible setup, focused Git history, relevant ADRs, task learning notes and sanitized evidence | Clean-checkout instructions and per-task Definition of Done |
| MAIN-07 | Pin dependencies, document upgrades and evaluate security/compatibility impact | Supported-version review, scans and regression/rollback plan |
| MAIN-08 | Keep test layers meaningful, fast where possible, and integration-realistic where needed | Test purpose and limits documented; no generated-test count as quality proxy |

## Consequences

Shared repository tooling is appropriate; shared mutable business objects, cross-service database access, hidden offset commits, uncontrolled replay, and ambiguous error handling undermine the learning boundaries. Avoid catch-all exception swallowing. Add shared utilities only for a specific stable technical need with clear consumers, not speculative reuse.

Maintainability remains a target until P1/P2 and subsequent implementations provide build/test evidence. This document does not create code standards packages, service skeletons, new CI workflows, or application modules. The documentation and ledger remain authoritative for current task progress; original roadmap checkboxes are not updated.

## Evidence

See [task learning record](../learning-notes/P0/P0-015.md) and [document review](../testing/evidence/P0-015-review.md).
