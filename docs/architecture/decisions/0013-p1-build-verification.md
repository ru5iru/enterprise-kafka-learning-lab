# ADR-0013: Independent build probe and explicit Maven management

- **Status:** Accepted design, 2026-11-24; actual plugin compatibility is verified incrementally in P1-033 through P1-035 and CI tasks.
- **Task:** P1-032.

## Context and decision

P1 must verify compiler/test/quality plugins and a passing CI before P2 creates a Spring application. Add a small **tooling-only** `tools/build-verification` Maven module in the next implementation task, aggregated by a root packaging=pom parent. It will exercise the toolchain and test discovery, with no HTTP service, business model, Kafka client/broker or database. This resolves the phase dependency without pretending P2/P3 functionality exists.

Use namespace/group `io.github.ru5iru.kafkalab`, source revision `0.1.0-SNAPSHOT` for unreleased local project work, UTF-8 and Java release 25 without preview. Keep the installed Maven 3.10.2/Oracle JDK 25.0.5.1 reference. Import Spring Boot **4.2.0** dependency BOM to manage its library set; the publisher BOM was read and reports JUnit Jupiter **6.1.3**. Do not import a Boot application starter/plugin or independently override its Spring/Kafka/JDBC library versions. Rechecked official Boot requirements still include Java 25 in the documented range; this does not certify all third-party integration.

## Planned explicit pins

Publisher Maven Central metadata was read on 2026-11-24. Stable versions selected for the actual P1 lifecycle/quality checks:

| Tool | Version |
|---|---|
| Compiler (Maven 3 line) | 3.16.0 |
| Surefire / Failsafe | 3.6.1 / 3.6.1 |
| Enforcer | 3.7.0 |
| Clean / Resources / Jar | 3.5.0 / 3.5.0 / 3.5.1 |
| Dependency / Help diagnostic plugins | 3.11.0 / 3.6.0 |
| Spotless | 3.12.0 |
| Google Java Format engine | 2.0.0, AOSP |
| Maven Checkstyle / Checkstyle engine | 3.6.0 / 14.4.0 |

These are source-reviewed pins, not a blanket tested-compatibility claim. Implementation tasks must prove resolution/execution, detect meaningful negative cases and update rationale if a pin changes. Checkstyle's explicit plugin-engine version avoids relying on an older plugin default; plugin classpaths differ from the application BOM's library management.

## Alternatives and consequences

An empty parent-only build could appear green without compiling/testing anything; rejected as final phase evidence. Starting a real Spring service in P1 would complete future tasks prematurely; rejected. A tooling probe provides observable gates without a business architecture. An entirely hand-written library version set duplicates Boot's compatibility work; use its BOM plus explicit reviewed exceptions instead.

Future services retain separate POMs/build/test/package commands and ownership under ADR-0002; an aggregator is a convenience, not a lockstep deployment or shared mutable business library. A local parent is reachable via relativePath from a clean checkout, not an unpublished repository dependency. Do not automatically attach future services/modules just because this root exists.

Pin active build plugins separately: dependencyManagement does not add a dependency, pluginManagement does not execute a plugin, and a BOM does not manage the Maven installation or all plugins. A pinned wrapper is deferred to the owning P2 service bootstrap; the P1 Linux installer/launcher supplies the exact actual Maven runtime. No wrapper is claimed present.

## Verification and security

Use HTTPS Central, strict checksums, no dynamic/LATEST/range or upstream SNAPSHOT dependencies, and no embedded repository credentials. The local project's SNAPSHOT suffix is source identity, not permission to resolve mutable remote snapshots. Review full effective POM/dependency trees and test/plugin results during actual implementation. Supply-chain scans/signatures/SBOM remain their own work; a successful resolve is not a vulnerability audit.

## References

- [Boot system requirements](https://docs.spring.io/spring-boot/system-requirements.html).
- [Boot 4.2.0 BOM](https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-dependencies/4.2.0/spring-boot-dependencies-4.2.0.pom).
- [Compiler metadata](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-compiler-plugin/maven-metadata.xml), [Surefire metadata](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-surefire-plugin/maven-metadata.xml).
- [P1-032 learning](../../learning-notes/P1/P1-032.md), [Maven baseline](0005-maven.md).
