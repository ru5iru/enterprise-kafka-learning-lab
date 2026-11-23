# Phase 9 — Security: TLS, mTLS, SASL and ACLs

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Implement layered transport, service and Kafka identity security with auditable least privilege.

## Expected exit deliverable

Authenticated encrypted connections, ACL matrix, PKI processes and negative security tests

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (64 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P9-001** — Review OWASP Top 10 _(depends on: P8-GATE)_
- [ ] **P9-002** — Review secure coding _(depends on: P9-001)_
- [ ] **P9-003** — Explain authentication _(depends on: P9-002)_
- [ ] **P9-004** — Explain authorization _(depends on: P9-003)_
- [ ] **P9-005** — Explain encryption _(depends on: P9-004)_
- [ ] **P9-006** — Explore TLS handshake _(depends on: P9-005)_
- [ ] **P9-007** — Inspect X.509 certificates _(depends on: P9-006)_
- [ ] **P9-008** — Explain asymmetric keys _(depends on: P9-007)_
- [ ] **P9-009** — Verify certificate chain _(depends on: P9-008)_
- [ ] **P9-010** — Explain Certificate Authority _(depends on: P9-009)_
- [ ] **P9-011** — Explain certificate expiration _(depends on: P9-010)_
- [ ] **P9-012** — Document trust boundaries _(depends on: P9-011)_
- [ ] **P9-013** — Map Kafka listeners _(depends on: P9-012)_
- [ ] **P9-014** — Generate lab CA _(depends on: P9-013)_
- [ ] **P9-015** — Issue broker certificates _(depends on: P9-014)_
- [ ] **P9-016** — Configure broker keystore _(depends on: P9-015)_
- [ ] **P9-017** — Configure broker truststore _(depends on: P9-016)_
- [ ] **P9-018** — Enable Kafka TLS listener _(depends on: P9-017)_
- [ ] **P9-019** — Configure TLS producer _(depends on: P9-018)_
- [ ] **P9-020** — Configure TLS consumer _(depends on: P9-019)_
- [ ] **P9-021** — Verify traffic encryption _(depends on: P9-020)_
- [ ] **P9-022** — Reject untrusted server certificate _(depends on: P9-021)_
- [ ] **P9-023** — Test expired server certificate _(depends on: P9-022)_
- [ ] **P9-024** — Write TLS troubleshooting guide _(depends on: P9-023)_
- [ ] **P9-025** — Explain mutual TLS _(depends on: P9-024)_
- [ ] **P9-026** — Inspect client-auth exchange _(depends on: P9-025)_
- [ ] **P9-027** — Issue service-specific certificates _(depends on: P9-026)_
- [ ] **P9-028** — Require broker client certificate _(depends on: P9-027)_
- [ ] **P9-029** — Configure Order Service mTLS _(depends on: P9-028)_
- [ ] **P9-030** — Configure Payment Service mTLS _(depends on: P9-029)_
- [ ] **P9-031** — Configure consumer mTLS _(depends on: P9-030)_
- [ ] **P9-032** — Map certificate to Kafka identity _(depends on: P9-031)_
- [ ] **P9-033** — Reject missing client certificate _(depends on: P9-032)_
- [ ] **P9-034** — Reject untrusted certificate _(depends on: P9-033)_
- [ ] **P9-035** — Rotate client certificate _(depends on: P9-034)_
- [ ] **P9-036** — Investigate certificate revocation constraints _(depends on: P9-035)_
- [ ] **P9-037** — Test cert renewal behavior _(depends on: P9-036)_
- [ ] **P9-038** — Document PKI lifecycle _(depends on: P9-037)_
- [ ] **P9-039** — Compare SASL mechanisms _(depends on: P9-038)_
- [ ] **P9-040** — Explain SASL/PLAIN vs SCRAM _(depends on: P9-039)_
- [ ] **P9-041** — Configure SASL/SCRAM over TLS _(depends on: P9-040)_
- [ ] **P9-042** — Authenticate producer via SASL _(depends on: P9-041)_
- [ ] **P9-043** — Authenticate consumer via SASL _(depends on: P9-042)_
- [ ] **P9-044** — Configure StandardAuthorizer _(depends on: P9-043)_
- [ ] **P9-045** — Inspect Kafka ACL syntax _(depends on: P9-044)_
- [ ] **P9-046** — Create producer ACL _(depends on: P9-045)_
- [ ] **P9-047** — Create consumer ACL _(depends on: P9-046)_
- [ ] **P9-048** — Restrict topic access _(depends on: P9-047)_
- [ ] **P9-049** — Restrict consumer group access _(depends on: P9-048)_
- [ ] **P9-050** — Test unauthorized operation _(depends on: P9-049)_
- [ ] **P9-051** — Enforce least-privilege principals _(depends on: P9-050)_
- [ ] **P9-052** — Protect administrator credentials _(depends on: P9-051)_
- [ ] **P9-053** — Secure REST endpoints _(depends on: P9-052)_
- [ ] **P9-054** — Add OAuth2/JWT experiment _(depends on: P9-053)_
- [ ] **P9-055** — Evaluate Keycloak _(depends on: P9-054)_
- [ ] **P9-056** — Encrypt PostgreSQL connections _(depends on: P9-055)_
- [ ] **P9-057** — Restrict database grants _(depends on: P9-056)_
- [ ] **P9-058** — Introduce secret store _(depends on: P9-057)_
- [ ] **P9-059** — Evaluate Vault PKI _(depends on: P9-058)_
- [ ] **P9-060** — Exclude secrets from Git _(depends on: P9-059)_
- [ ] **P9-061** — Run secret scanning _(depends on: P9-060)_
- [ ] **P9-062** — Run SCA _(depends on: P9-061)_
- [ ] **P9-063** — Scan container images _(depends on: P9-062)_
- [ ] **P9-064** — Create incident response playbook _(depends on: P9-063)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
