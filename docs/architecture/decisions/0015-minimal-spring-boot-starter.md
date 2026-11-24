# ADR-0015: Independent non-web Spring Boot learning starter

- **Status:** Accepted, 2026-11-25.
- **Task:** P2-014.
- **Scope:** Initial application bootstrap; no business service or deployed infrastructure.

## Context

P2-001 through P2-013 reviewed Java foundations. P2-014 now needs a real, tested Spring Boot application. ADR-0002 requires independent application builds; ADR-0013's root reactor intentionally verifies only tooling. Later P2 tasks introduce lifecycle experiments, DI, configuration, REST, health, tests and containerization individually.

## Decision

Create `applications/lab-starter` with its own POM and package `io.github.ru5iru.kafkalab.starter`. Its only production dependency is the base `spring-boot-starter`. The annotated main class delegates to `SpringApplication.run`; no custom beans, endpoints, properties or business layers are introduced. With this classpath Boot deduces a non-web application. Successful startup followed by normal JVM exit is expected: there is no server or ongoing consumer work to keep it alive.

Inherit the repository parent through `../../pom.xml` for Java 25, UTF-8, the Boot **4.2.0** BOM and pinned quality/test plugins. Do not add the application to the root reactor. Build it explicitly with `-f applications/lab-starter/pom.xml`; the local parent needs no prior `mvn install`. This is independent selection/packaging within one checkout, not a standalone source distribution detached from shared build conventions.

Activate the existing formatter, Checkstyle, compiler and Surefire gates in the application. Add one real-context smoke test using JUnit; a dedicated later testing lesson remains uncompleted. Activate Boot Maven plugin **4.2.0** with an explicit `repackage` execution and main class because importing a BOM does not inherit Boot's parent plugin executions. Test libraries must stay out of the executable JAR.

Complete the wrapper deferral from ADR-0013 using Apache Maven Wrapper **3.3.4**, generated in `only-script` mode for Maven **3.10.2**. Preserve upstream scripts and license notices. The ZIP URL is HTTPS Central and its SHA-256 is pinned in `.mvn/wrapper/maven-wrapper.properties`. The ZIP was independently downloaded over validated HTTPS and matched against the publisher's SHA-512 before calculating this SHA-256. No wrapper JAR/downloader binary is committed. Keep the generated Windows companion for upstream consistency, but use only the Linux script through the WSL launcher; no Windows Java/Maven installation is authorized or claimed.

CI explicitly builds the starter and checks the packaged JAR and malformed startup option, alongside the existing tooling build. Keep read-only permissions, full action pins and sanitized report handling. There is no deployment step.

## Alternatives and consequences

| Alternative | Assessment |
|---|---|
| Web starter and example controller | Useful at P2-019, but unnecessary network surface and premature REST work here. |
| Generate every Initializr default | Broader dependencies/files obscure the tiny bootstrap lesson; a hand-reviewed POM is sufficient. |
| Use Boot starter parent | Good standalone default; replacing the existing parent would duplicate or displace established quality rules. Import the BOM and explicitly activate packaging instead. |
| Aggregate every application at root | Convenient bulk build but hides independent build selection. Keep the tooling reactor unchanged. |
| Test only source/context | Misses broken manifests, packaging, test dependency leakage and actual entry-point failure. Also launch the packaged artifact. |
| Defer wrapper again | Existing pinned installer works, but owning bootstrap is the agreed point to make Maven selection repository-local. |

The starter is a learning substrate, not an Order service or shared business library. No dependency on the tooling probe is allowed. Commands run from repository root so `.mvn/settings.xml` and the Checkstyle configuration resolve consistently. The wrapper requires `unzip` and `sha256sum` for its pinned ZIP; without unzip its upstream tar fallback will fail the ZIP checksum rather than weaken verification. A writable wrapper cache is trusted after installation: the upstream script skips rechecking an existing cache directory. Never run builds from untrusted modifications or enable verbose credential-bearing downloads. Re-check sources/pins through a task if versions change.

## Verification and limits

See [P2-014 evidence](../../testing/evidence/P2-014-review.md) and [learning record](../../learning-notes/P2/P2-014.md) for actual WSL results, failure experiments and residual risks. Official Boot requirements on review list Java 17–27 and Maven 3.6.3+, encompassing our existing JDK 25/Maven 3.10.2; local execution establishes this narrower tested combination. Resolution and checksum validation are not SCA, signature verification or an SBOM. Container packaging remains P2-034; the CSV deliverable is phase-wide and does not make this task a full phase gate.

## References

- [Boot requirements](https://docs.spring.io/spring-boot/system-requirements.html).
- [Boot custom-parent build](https://docs.spring.io/spring-boot/maven-plugin/using.html).
- [Executable packaging](https://docs.spring.io/spring-boot/maven-plugin/packaging.html).
- [Root package placement](https://docs.spring.io/spring-boot/reference/using/structuring-your-code.html).
- [Wrapper plugin parameters](https://maven.apache.org/tools/wrapper/maven-wrapper-plugin/wrapper-mojo.html).
- [Maven distribution and publisher SHA-512](https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.10.2/apache-maven-3.10.2-bin.zip.sha512).
- [Independent builds](0002-monorepo.md), [build conventions](0013-p1-build-verification.md), [WSL execution](0011-wsl-development-runtime.md).
