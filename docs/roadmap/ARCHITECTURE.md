# System and Repository Architecture

> Source: Enterprise Kafka Learning Lab master roadmap (23 November 2026). Diagrams below are **conceptual planning diagrams**, not claims that any system is already deployed.

## Architecture principles

- Keep business logic minimal to focus on Kafka internals and engineering practices.
- Producer and consumer are application capabilities, not automatically microservices.
- Topics, partitions, consumer groups and dead-letter topics are Kafka resources.
- Evolve from one broker and one message to independently deployable services and a multi-broker KRaft cluster.
- Design trust boundaries early; implement controls progressively.
- Avoid sharing business-specific libraries across service boundaries.

## Logical end-to-end event flow

```mermaid
flowchart LR
  U[User / Load Generator] --> O[Order Service REST API]
  O -->|OrderCreated| KT[(Kafka order topic)]
  KT --> P[Payment Service Consumer]
  KT --> I[Inventory Service Consumer]
  P -->|PaymentCompleted| KP[(Kafka payment topic)]
  I -->|InventoryUpdated| KI[(Kafka inventory topic)]
  KP --> N[Notification Service Consumer]
  KI --> N
  O --> DO[(Order PostgreSQL)]
  P --> DP[(Payment PostgreSQL)]
  I --> DI[(Inventory PostgreSQL)]
```


## Event and infrastructure topology

```mermaid
flowchart TB
  subgraph Clients[Independent Java / Spring Boot Applications]
    O[Order Producer]
    P[Payment Consumers and Producer]
    I[Inventory Consumers and Producer]
    N[Notification Consumer]
  end
  subgraph Cluster[Apache Kafka Cluster — advanced milestone]
    B1[Broker 1]
    B2[Broker 2]
    B3[Broker 3]
    T[Topics / Partitions / Replicas]
    C[KRaft Controller Quorum]
    B1 --- T
    B2 --- T
    B3 --- T
    C -.metadata control.-> B1
    C -.metadata control.-> B2
    C -.metadata control.-> B3
  end
  O --> T
  T --> P
  T --> I
  T --> N
  subgraph Operations[Supporting infrastructure introduced later]
    S[Schema Registry]
    KC[Kafka Connect / Debezium]
    Obs[Prometheus / Grafana / OpenTelemetry]
    PKI[CA / Secrets / mTLS / ACLs]
  end
  T --- KC
  T --- S
  T --- Obs
  PKI -.secures.-> T
```


In the initial milestone, only a single Kafka broker, one simple application, one producer, one consumer and one topic are required. The remaining components are learning targets introduced later.

## Architecture layers

| Layer | Components |
|---|---|
| Business services | Order, Payment, Inventory, Notification, event generator |
| Kafka data plane | Brokers, producers, consumers, partitions, replicas, consumer groups, topics, DLT |
| Kafka control plane | KRaft metadata and controllers, AdminClient |
| Data and integration | PostgreSQL, Flyway, transactional Outbox, Kafka Connect, Debezium |
| Security | CA, certificate issuance and rotation, mTLS, SASL, ACLs, application identity, secrets |
| Observability | Actuator, JMX exporter, Prometheus, Grafana, tracing and log aggregation |
| Delivery | Compose, Kubernetes, Helm, CI/CD, quality and security gates |

## Repository blueprint

```text
enterprise-kafka-learning-lab/
├── README.md
├── docs/
│   ├── requirements/
│   ├── architecture/
│   │   └── decisions/
│   ├── kafka/
│   ├── security/
│   ├── operations/
│   ├── testing/
│   └── learning-notes/
├── applications/
│   ├── order-service/
│   ├── payment-service/
│   ├── inventory-service/
│   ├── notification-service/
│   ├── event-generator/
│   └── event-monitor/
├── shared/
│   ├── event-contracts/
│   ├── common-test-utils/
│   └── observability-starter/
├── infrastructure/
│   ├── docker/
│   ├── compose/
│   ├── kafka/
│   ├── postgres/
│   ├── schema-registry/
│   ├── kafka-connect/
│   ├── security/
│   ├── observability/
│   ├── kubernetes/
│   ├── helm/
│   └── terraform/
├── testing/
├── scripts/
├── .github/workflows/
└── tools/
```


Create directories as they become useful. Prefer independently built Maven applications. Secrets and private keys must not be version controlled.

## Technology decisions recorded in source roadmap

| Decision | Selected approach |
|---|---|
| Codebase | Monorepo, independent Maven modules and independently deployable services |
| Applications | Java and Spring Boot; minimal order/payment/inventory/notification simulation |
| Kafka | Apache Kafka in KRaft mode; native Java client first, Spring Kafka second |
| Persistence | PostgreSQL, later Outbox/CDC and Saga experiments |
| Deployment | Docker Compose first, Kubernetes with maintained operator later |
| Security | Progressive SSDLC: TLS, mTLS, SASL/SCRAM, Kafka ACLs, PKI and secret management |
| Quality | JUnit, Mockito, Testcontainers, security scans and contract testing |
| Operations | Prometheus, Grafana, OpenTelemetry, centralized logs and failure injection |
| Workload | Model up to 100,000 users; quantify concurrency, events/s, payloads, retention and SLOs |
| Delivery | Task-sized work, repeatable verification, ADRs, CI/CD and evidence capture |

## Security boundaries to experiment with

- Java application ↔ Kafka broker: TLS, mTLS, SASL and Kafka ACLs as separate learning exercises.
- Broker ↔ broker, KRaft controller ↔ broker: protected Kafka communications.
- Service ↔ service over HTTP: mTLS and, when required, application-level authorization.
- Service ↔ PostgreSQL: TLS, database roles and independent service ownership.
- Developer/CI ↔ infrastructure: limited administrative privileges and managed secrets.

## Architecture evolution and work dependencies

```mermaid
flowchart TD
 P0[P0 Planning] --> P1[P1 Repository]
 P1 --> P2[P2 Java / Spring]
 P2 --> P3[P3 First Kafka]
 P3 --> P4[P4 Microservices]
 P3 --> P5[P5 Kafka Internals]
 P4 --> P6[P6 Reliability]
 P5 --> P6
 P6 --> P7[P7 Schemas]
 P4 --> P8[P8 PostgreSQL / Outbox]
 P7 --> P8
 P5 --> P9[P9 Security]
 P4 --> P10[P10 Observability]
 P6 --> P10
 P8 --> P11[P11 Performance]
 P10 --> P11
 P9 --> P12[P12 Resilience]
 P11 --> P12
 P12 --> P13[P13 Kubernetes]
 P9 --> P13
 P13 --> P14[P14 SSDLC / CI-CD]
```


The graph indicates learning prerequisites. It is not a strict prohibition on adding early unit tests, logging, secure defaults or repository scanning.
