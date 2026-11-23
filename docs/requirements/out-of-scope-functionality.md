# P0-005 - Identify out-of-scope functionality

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Excluded baseline functionality

| Exclusion | Reason | Teaching substitute / implication |
|---|---|---|
| Live payments, card handling, settlement, refunds with real money | Financial effects and sensitive data are unnecessary for Kafka experiments | Deterministic synthetic payment outcomes; later compensation has fake effects only |
| Real customer accounts, personal data, email/SMS delivery | Adds privacy, identity, provider, and abuse concerns | Synthetic IDs and local recorded notifications |
| Full storefront, product catalogue, cart, recommendations, promotions, tax/shipping/accounting | Business breadth distracts from Kafka mechanisms | Minimal synthetic order data and quantities |
| Real stock, warehouses, fulfilment, external ERP/CRM | Adds external consistency boundaries outside the baseline | Synthetic inventory outcomes with bounded deterministic rules |
| Public production hosting, commercial SLA, on-call operation | Lab evidence does not certify real customer service | Isolated local and later Kubernetes experiments with explicit limits |
| Multi-tenant billing, marketplace, geographic business routing | No required learning need in the agreed simulation | Workload variation through synthetic identifiers, not new services |
| Alternative broker/database/framework adoption or mandatory cloud, mesh, Terraform platform | Not part of the selected core stack or required initial experiment | Consider only through justified, dated amendments; diagrams are not installation permission |
| Unbounded replay, destructive public tests, real credentials or private keys in Git | Unsafe and non-reproducible | Bounded isolated failure experiments and sanitized evidence |

## Retained learning capabilities

Simulated payment/inventory failure, duplicate/reordered event observations, retry/DLT handling, controlled replay, idempotency, Outbox/CDC, Saga compensation, schema evolution, layered security, observability, performance, recovery, and advanced deployment remain in scope at their scheduled tasks. Security review and secret hygiene are never excluded merely because runtime security comes later. Kubernetes is deferred to P13; it is not removed.

## Decision examples

- A request to integrate a live card processor is excluded; use synthetic success/rejection/timeout cases.
- A request to inject a duplicate synthetic payment event is in scope for P6/P8 when its safeguards and evidence are defined.
- A full identity provider or storefront needs a separate demonstrated learning need and explicit scope amendment; the current plan creates neither.
- A scheduled TLS rejection or recovery drill remains required learning work, even though production operation is excluded.

## Consequences and changes

The lab cannot demonstrate commercial compliance or end-to-end behavior of external providers. Its experiments can still explain messaging and consistency limits under controlled synthetic effects. Review an extension against scope admission gates, learning value, affected task dependencies, security/cost, alternatives, and verification before changing the baseline. Preserve task IDs and historical roadmap files.

P0-006 defines the minimal simulation next; this exclusion list supplies its outer boundary rather than implementing business rules.

## Evidence

See [task learning record](../learning-notes/P0/P0-005.md) and [document review](../testing/evidence/P0-005-review.md).
