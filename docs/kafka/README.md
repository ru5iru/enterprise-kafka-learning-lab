# Kafka learning navigation

This directory is a documentation entry point, not a running Kafka installation or a set of completed experiments. Native clients precede Spring Kafka, as established in the roadmap.

| Learning concern | Owning roadmap |
|---|---|
| First broker/topic/CLI/native producer/consumer and Spring progression | [P3](../roadmap/phases/P3_first-kafka-producer-and-consumer.md) |
| KRaft, partitions, replicas, groups and administration | [P5](../roadmap/phases/P5_kafka-internals-and-administration.md) |
| Offsets, delivery, retries, DLT and failure behavior | [P6](../roadmap/phases/P6_reliability-consistency-and-delivery-guarantees.md) |
| Event contracts and schema governance | [P7](../roadmap/phases/P7_event-contracts-and-schema-management.md) |
| TLS/mTLS, authentication and authorization | [P9](../roadmap/phases/P9_security-tls-mtls-sasl-and-acls.md) |

Current planning sources: [Kafka/KRaft ADR](../architecture/decisions/0003-kafka-kraft.md), [infrastructure requirements](../requirements/kafka-infrastructure.md), [learning objectives](../requirements/learning-objectives.md). Add topic/experiment navigation only when work is performed, link the canonical task learning note and evidence, and distinguish broker resources from application services. Commands here must identify prerequisites and safety/rollback before future execution. No CLI test or broker behavior has been verified by creating this directory.

Return to [documentation index](../README.md).
