# ADR-0004: Java 25 and Spring Boot 4.2.0 reference baseline

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted as a documented planning reference; runtime validation pending
- **Date:** 2026-11-24
- **Related tasks:** P0-039
- **Decision makers:** Executing agent under the owner's authorization to complete P0; source-based selection, not a claim of separate owner version review.

## Context

The project selects Java/Spring Boot but needs exact reproducible reference versions. Current official pages were checked on 2026-11-24, rather than recalling compatibility from a prior release. Native Kafka learning still precedes Spring Kafka. No Java service or Maven build exists yet.

## Decision

Use **Oracle JDK 25.0.5.1+4** as the exact reference runtime for the **Java 25** language/release baseline, and **Spring Boot 4.2.0** as the exact Boot reference. Do not enable preview language features. Use the Boot-managed dependency set and record its resolved versions when builds are introduced; do not override Spring Framework/Spring Kafka/Kafka client versions speculatively.

The official Boot 4.2.0 requirements state Java 17 through 27 compatibility, Framework 7.1.0 or later, and Maven 3.6.3 or later. Java 25 satisfies the documented Java range. The JDK release notes identify 25.0.5.1+4, released 2026-11-17. These facts support the selected Java/Boot pair; they do not certify future connectors, drivers, native images or broker/client combinations.

## Rationale and alternatives

| Option | Benefit | Cost / disposition |
|---|---|---|
| Current Java 25 reference plus stable Boot 4.2.0 | Long-term Java line and current documented supported Boot range | Selected; patch/build recorded |
| Java 21 or another supported line | May fit existing tools | Not the chosen reference; any substitution must be explicitly reviewed |
| Snapshot Boot or independently mixed framework/client versions | Access to newer changes | Unnecessary instability/compatibility risk; rejected |

## Consequences

Before installation, verify the chosen distribution's acquisition terms and platform artifact; no support entitlement, redistribution permission, download or checksum verification is assumed. An alternative JDK distribution requires a recorded equivalent version/security review and actual build tests. P0-040 records Maven; P1/P2 record actual java/mvn output, resolved dependency tree, unit/integration/negative tests and build reproducibility. Kafka images/clients, JDBC, registry, CDC and operator versions still require their own compatibility checks when introduced.

## Validation and review

Official-source review is the executed verification; no Java installation, sample compilation, Maven build, integration test or security scan ran. Recheck the pair before implementation and after security/support changes. A changed patch, framework line or dependency override requires updated rationale, source evidence and applicable regression tests. See the task learning note for sources and trade-offs.

## Evidence

See [task learning record](../../learning-notes/P0/P0-039.md) and [document review](../../testing/evidence/P0-039-review.md).
