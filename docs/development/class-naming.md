# Java type and class naming

Use descriptive ASCII UpperCamelCase type names and exact-case filenames for public top-level types. Prefer one primary responsibility/type per source file. Java permits more names than this project convention; reject misleading names in review even when they compile. Case differences can be masked by the current Windows-mounted tree and fail on a Linux CI filesystem.

| Responsibility | Example and rationale |
|---|---|
| Domain value | `OrderId`: specific meaning instead of GenericData |
| Recorded fact/event | `OrderCreated`: past-tense fact matching the agreed flow |
| Request/command | `CreateOrderRequest`: intent, not a completed fact |
| Boundary/adapter | `OrderPublisher`, `KafkaOrderPublisher`: intent plus concrete transport only where a real boundary exists |
| HTTP role | `OrderController`: role suffix when the framework role is real |
| Failure | `InvalidOrderException`: failure meaning, not UtilsError |
| Tests | `OrderPublisherTest` for unit, `OrderPublisherIT` for integration; wire discovery in P1-034 |

Avoid `IOrderPublisher`, default `OrderServiceImpl` when a concrete role is clearer, `OrderManager`/`CommonUtils` catch-alls, task/version/environment suffixes and confusable mixed-script identifiers. Do not generate interfaces, abstract bases or layers just to satisfy a naming example. Keep interface names semantic; implementation names identify actual behavior/backend. Acronyms should remain readable (`Http`, `Kafka`, `Json`) rather than all-capital noise.

Prefer immutable value/event models when implementation begins; a record can be suitable after serializer/schema compatibility review. Naming does not prove immutability, event delivery or authorization. Commands and events must not be conflated, and an exception name alone does not authorize retry. Generated schema/type names and externally consumed contracts require owning-task review before renaming.

Review examples against [package ownership](package-naming.md), existing event-flow ADR and future test discovery. No classes, tests, interfaces or immutable models are implemented here. [P1-028 learning](../learning-notes/P1/P1-028.md) records the review. Later renames need compiler/import/reflection/schema/test-discovery checks, not just a file move.
