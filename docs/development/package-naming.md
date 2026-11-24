# Java package naming

Use base namespace `io.github.ru5iru.kafkalab`, derived from this repository's hosting account, not an invented company/domain. This local source convention does not establish Maven Central publishing rights. Use lowercase ASCII identifiers separated by dots; no hyphens, underscores, task IDs, dates, secrets or environment names. Do not use java/javax or the unnamed package for project code.

| Example | Review |
|---|---|
| `io.github.ru5iru.kafkalab.order.api` | Order-owned API code when introduced |
| `io.github.ru5iru.kafkalab.payment.messaging` | Payment-owned messaging adapter |
| `io.github.ru5iru.kafkalab.experiments.nativeclient` | Independent native-client exercise |
| `io.github.ru5iru.kafkalab.Order-Service` | Reject: case/hyphen, invalid Java identifier |
| `com.example.shared.business` | Reject: unrelated placeholder/shared mutable business boundary |
| `io.github.ru5iru.kafkalab.order.prod` | Reject: deployment environment is configuration |

Within a service, group by a meaningful capability and add api/application/domain/infrastructure/messaging subpackages only when they clarify real responsibilities. These are examples, not a requirement to create empty layers/ports or a business framework. Keep the application root above its own components when Spring scanning is introduced; do not broaden scanning/imports across services. Align directory hierarchy with package declarations in src/main/java and src/test/java when those sources exist.

A package organizes names and package-private access; it is not an authentication, database or deployment boundary. Preserve ADR-0002 independent builds/data ownership. Do not create a shared mutable business-model package to save typing. Generated event/schema namespaces are reviewed at their owning contract task; do not version all implementation packages speculatively.

Self-review checked accepted/rejected examples against Java qualified-name syntax and service ownership. No Java packages/services were generated and no compiler scan proves architectural separation yet. [Learning/evidence](../learning-notes/P1/P1-027.md) record the scope. A later rename needs import/build/contract review and a deliberate migration; avoid churn of public/generated contracts.
