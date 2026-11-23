# ADR-0002: Monorepo with independent service builds

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted
- **Date:** 2026-11-24
- **Related tasks:** P0-037
- **Decision makers:** Project owner baseline recorded in README/AGENTS; formalized during authorized P0 execution.

## Context

One learner needs coherent history for Kafka experiments, services, contracts, ADRs and verification. The project already selected a monorepo and independent Maven Java/Spring services. Ownership and deployment independence must survive repository convenience.

## Decision

Keep one repository. Introduce service modules/directories only at their assigned tasks, preserving independent build/test/package/deployment. Use focused topic branches, Conventional Commits, task evidence and explicit contract review. Do not share mutable business implementation objects or cross-service tables.

## Rationale and alternatives

| Option | Benefit | Cost / disposition |
|---|---|---|
| Monorepo | One discoverable learning/evidence history; coordinated contract/doc review | Requires focused CI and coupling discipline; selected |
| Polyrepo | Strong repository-level separation | Extra setup, version coordination and scattered evidence; rejected for this learning project |
| Shared business monolith | Simple initial execution | Hides distributed boundaries being studied; rejected as final target |

## Consequences

Repository-wide tooling may be shared deliberately; business state stays exclusively owned. Some technical duplication is preferable to speculative shared business libraries. A change to common tooling must identify all consumers. The roadmap remains 726 tasks, not new service-specific roadmaps.

## Validation and review

Documentary review checks alignment with scope and independent build requirements. P1/P2/P4/P14 later demonstrate build/CI/deployment independence. Revisit if repository size or ownership costs are measured to outweigh learning coherence. No code/build or remote merge is performed by this ADR.

## Evidence

See [task learning record](../../learning-notes/P0/P0-037.md) and [document review](../../testing/evidence/P0-037-review.md).
