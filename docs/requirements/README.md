# Requirements work products

P0 produced the following reviewed planning artifacts. Numerical requirements are provisional objectives/assumptions, not measurements. The [P0 evidence index](../testing/evidence/P0-phase-review.md) links all 45 task records; the [CSV](../roadmap/Kafka_Learning_Lab_Task_Checklist.csv) is authoritative for completion.

| Topic | Documents |
|---|---|
| Mission and learning | [Charter](project-charter.md), [learning objectives](learning-objectives.md) |
| Scope and simulation | [Boundaries](scope-boundaries.md), [technology inventory](technology-inventory.md), [exclusions](out-of-scope-functionality.md), [commerce simulation](e-commerce-simulation.md), [logical components](logical-components.md) |
| Functional/system qualities | [Functional](functional-requirements.md), [performance](performance-requirements.md), [availability](availability-requirements.md), [scalability](scalability-requirements.md), [security](security-requirements.md), [observability](observability-requirements.md), [maintainability](maintainability-requirements.md) |
| Deployment/recovery/acceptance | [Deployment](deployment-requirements.md), [recovery](backup-recovery-requirements.md), [acceptance](acceptance-criteria.md) |
| Workload inputs | [User scenario](user-scenario.md), [active users](concurrent-users.md), [events per user](events-per-user.md), [baseline rate](baseline-event-rate.md), [peak multiplier](peak-multiplier.md), [payload size](payload-size.md), [retention](event-retention.md) |
| Objectives | [Latency](latency-objectives.md), [availability](availability-objectives.md) |
| Boundaries and communication | [Service boundaries](microservice-boundaries.md), [communication matrix](communication-matrix.md), [sync/async](sync-async-messaging.md), [Kafka infrastructure](kafka-infrastructure.md), [deployment models](deployment-models.md) |

Keep each concern's source here and link it from learning notes/ADRs instead of copying changing assumptions. Revisit goals with measured evidence at the owning implementation/experiment task. Return to [documentation index](../README.md).
