# ADR-0010: Correlated metrics logs and traces for learning evidence

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted
- **Date:** 2026-11-24
- **Related tasks:** P0-045
- **Decision makers:** Owner baseline direction, formalized during authorized P0 execution.

## Context and decision

Use useful application/Kafka diagnostics from initial implementation, then the baseline Actuator/JMX, Prometheus/Grafana, OpenTelemetry and centralized-log direction for integrated P10 observability. Keep correlation between synthetic request/order/event, producer result, consumer group/progress and local outcome. Select exact backend/exporter/tool versions at P10 with compatibility/security/resource evidence; this ADR does not choose a new log platform.

## Rationale and alternatives

Logs alone give individual detail but insufficient rate/lag/latency context. Dashboards alone can hide missing or failed business effects. Traces alone may be sampled or fail to propagate across asynchronous boundaries. Complementary observations support causal diagnosis when reconciled against known synthetic inputs and effects; they do not replace contract/correctness tests.

## Consequences

Measure attempted/acknowledged/completed/failed work, latency distributions, lag and resource/control-plane state separately. Bound high-cardinality labels, log volume, sampling and retention; do not log secrets, private keys, real data or unreviewed payload/header content. Declare missing signals and sampling blind spots. Alerts need a meaningful failure scenario, corrective action and observed recovery, not only a screenshot.

## Validation and review

P10 follows a known event, stops/slows a branch, observes the unaffected branch and lag/latency/error changes, triggers the scheduled alert, and validates recovery. P11/P12 use these signals to explain capacity and outages. P0 provides documentary review only: no collector, exporter, dashboard, metric, trace, alert or observed runtime behavior is claimed.

The final P0 review checks task/document/evidence completeness, stable roadmap/ledger metadata and publication barriers; it does not certify runtime acceptance or imply separate owner approval of the full planning package. Owner approval of parallel business flow remains specifically documented in ADR-0001.

## Evidence

See [task learning record](../../learning-notes/P0/P0-045.md) and [document review](../../testing/evidence/P0-045-review.md).
