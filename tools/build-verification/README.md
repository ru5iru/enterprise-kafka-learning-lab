# Toolchain verification module

This module exists only to exercise P1 compiler, test, quality and CI gates before the P2 Spring starter. It is not a deployable service, business library or Kafka/database integration. Its one source fixture exposes the runtime Java feature for later tests.

Use `bash scripts/wsl/lab.sh mvn clean compile` from root, or `bash scripts/wsl/lab.sh mvn -f tools/build-verification/pom.xml clean compile` independently. The parent is resolved via relativePath from a clean checkout, not a previously installed local snapshot. Root aggregation is convenience, not future service lockstep.

Compiler 3.16.0 uses release 25, UTF-8, parameter metadata, no annotation processors and all lint warnings as errors. Enforcer guards Java [25,26), Maven [3.10.2,3.11) and release dependencies while allowing this unreleased local parent snapshot. Clean/resources/jar and diagnostic plugin versions are explicit. No preview feature or Spring app/starter/plugin is added.

[P1-033 evidence](../../docs/testing/evidence/P1-033-review.md) records real root/standalone compilation, class major 69 and unsupported-release rejection. Tests and quality gates are added in P1-034/P1-035; no test/CI success is claimed by compile alone. Generated target files are ignored. Rollback requires checking later tool tests, then correcting POM/source normally rather than removing user caches or unrelated modules.
