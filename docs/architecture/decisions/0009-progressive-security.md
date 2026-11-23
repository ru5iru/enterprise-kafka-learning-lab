# ADR-0009: Progressive security with honest maturity boundaries

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

- **Status:** Accepted
- **Date:** 2026-11-24
- **Related tasks:** P0-044
- **Decision makers:** Owner progressive-security baseline; formalized during P0 execution.

## Context and decision

Use the security requirements, TB-01-TB-07 boundaries and initial STRIDE findings to guide progressive verification. From day one use synthetic data, isolated lab access, secret/private-key hygiene, bounded experiments, explicit errors and truthful evidence. No advanced runtime control is implemented by planning it.

## Rationale and alternatives

Deferring all security thinking until P9 would miss early trust/data/configuration risks. Building every control before the first message would obscure the intended progression. The selected approach makes residual risk and isolation explicit while adding controls when the underlying mechanism can be studied and tested.

## Consequences and milestones

| Stage | Target evidence / limit |
|---|---|
| P0 onward | Requirements/threat review and sanitized evidence; all runtime protection still absent |
| P6-P8 | Bounded retry/replay, contracts, owned data/roles and local consistency evidence |
| P9 | TLS/mTLS trust, SASL identity, ACL least privilege and certificate/credential lifecycle; allowed and denied cases |
| P10/P12 | Redacted useful telemetry, access/retention and tested recovery safeguards |
| P13 | Scoped workload/admin identity, network and secret controls with denial tests |
| P14 | Full SAST/SCA/SBOM/artifact/release gates with finding disposition; basic hygiene/CI starts earlier |

Transport protection, identity and permission are distinct; do not weaken certificate checks or grant broad privileges to make tests pass. Do not publish intentionally insecure lab services. The learner/operator roles own follow-up, but no personal assignee, credential or production security commitment is invented.

## Validation and review

Every STRIDE finding stays open until its implementation test, correction/retest and residual-risk review exist. Reassess on new components, exposure, identity, version or replay/persistence changes. P0 contains documentary review, not scans, penetration tests or a compliant deployed system.

## Evidence

See [task learning record](../../learning-notes/P0/P0-044.md) and [document review](../../testing/evidence/P0-044-review.md).
