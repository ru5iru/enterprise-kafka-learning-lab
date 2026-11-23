# Phase 13 — Kubernetes and enterprise deployment

[← Master roadmap](../ROADMAP.md) · [Architecture](../ARCHITECTURE.md) · [SSDLC](../SSDLC_AND_VERIFICATION.md)

## Objective

Deploy a supported operator-managed Kafka cluster and independent applications on Kubernetes.

## Expected exit deliverable

Repeatable Kubernetes and Helm lab with network and workload security controls

## Phase gate

demonstrate the deliverable; complete applicable tests and negative/failure experiments; capture logs or reports; update documentation and ADRs; verify the relevant SSDLC controls.

## Task checklist (65 tasks)

Task titles and IDs are retained from the source checklist. Granular tracking fields (owner, dates, acceptance criteria, dependencies and verification) are available in the accompanying CSV.

- [ ] **P13-001** — Explain Kubernetes components _(depends on: P12-GATE)_
- [ ] **P13-002** — Explain control plane _(depends on: P13-001)_
- [ ] **P13-003** — Explain Pods _(depends on: P13-002)_
- [ ] **P13-004** — Explain Deployments _(depends on: P13-003)_
- [ ] **P13-005** — Explain StatefulSets _(depends on: P13-004)_
- [ ] **P13-006** — Explain Services _(depends on: P13-005)_
- [ ] **P13-007** — Explain ConfigMaps _(depends on: P13-006)_
- [ ] **P13-008** — Explain Secrets _(depends on: P13-007)_
- [ ] **P13-009** — Explain PV/PVC _(depends on: P13-008)_
- [ ] **P13-010** — Explain StorageClass _(depends on: P13-009)_
- [ ] **P13-011** — Explain Ingress _(depends on: P13-010)_
- [ ] **P13-012** — Explain requests/limits _(depends on: P13-011)_
- [ ] **P13-013** — Explain probes _(depends on: P13-012)_
- [ ] **P13-014** — Explain autoscaling _(depends on: P13-013)_
- [ ] **P13-015** — Install local Kubernetes _(depends on: P13-014)_
- [ ] **P13-016** — Compare kind and minikube _(depends on: P13-015)_
- [ ] **P13-017** — Create namespace _(depends on: P13-016)_
- [ ] **P13-018** — Deploy hello-world service _(depends on: P13-017)_
- [ ] **P13-019** — Expose ClusterIP _(depends on: P13-018)_
- [ ] **P13-020** — Test persistent volume _(depends on: P13-019)_
- [ ] **P13-021** — Configure env vars _(depends on: P13-020)_
- [ ] **P13-022** — Configure limits _(depends on: P13-021)_
- [ ] **P13-023** — Configure probes _(depends on: P13-022)_
- [ ] **P13-024** — Evaluate Kafka deployment choices _(depends on: P13-023)_
- [ ] **P13-025** — Compare operators and manifests _(depends on: P13-024)_
- [ ] **P13-026** — Choose maintained Kafka operator _(depends on: P13-025)_
- [ ] **P13-027** — Deploy KRaft Kafka on Kubernetes _(depends on: P13-026)_
- [ ] **P13-028** — Configure persistent broker storage _(depends on: P13-027)_
- [ ] **P13-029** — Configure Kafka listeners _(depends on: P13-028)_
- [ ] **P13-030** — Configure health and readiness _(depends on: P13-029)_
- [ ] **P13-031** — Configure broker resources _(depends on: P13-030)_
- [ ] **P13-032** — Deploy multi-broker Kafka _(depends on: P13-031)_
- [ ] **P13-033** — Verify replicated topic _(depends on: P13-032)_
- [ ] **P13-034** — Restart broker pod _(depends on: P13-033)_
- [ ] **P13-035** — Recover persistent broker state _(depends on: P13-034)_
- [ ] **P13-036** — Create microservice Deployments _(depends on: P13-035)_
- [ ] **P13-037** — Create microservice Services _(depends on: P13-036)_
- [ ] **P13-038** — Deploy Order Service _(depends on: P13-037)_
- [ ] **P13-039** — Deploy Payment Service _(depends on: P13-038)_
- [ ] **P13-040** — Deploy Inventory Service _(depends on: P13-039)_
- [ ] **P13-041** — Deploy Notification Service _(depends on: P13-040)_
- [ ] **P13-042** — Deploy lab PostgreSQL _(depends on: P13-041)_
- [ ] **P13-043** — Connect workloads to Kafka _(depends on: P13-042)_
- [ ] **P13-044** — Configure persistent volumes _(depends on: P13-043)_
- [ ] **P13-045** — Configure app resource limits _(depends on: P13-044)_
- [ ] **P13-046** — Verify application horizontal scaling _(depends on: P13-045)_
- [ ] **P13-047** — Configure Kubernetes RBAC _(depends on: P13-046)_
- [ ] **P13-048** — Configure service accounts _(depends on: P13-047)_
- [ ] **P13-049** — Use non-root containers _(depends on: P13-048)_
- [ ] **P13-050** — Define network policies _(depends on: P13-049)_
- [ ] **P13-051** — Restrict namespace permissions _(depends on: P13-050)_
- [ ] **P13-052** — Integrate secret provider _(depends on: P13-051)_
- [ ] **P13-053** — Integrate cert-manager or equivalent _(depends on: P13-052)_
- [ ] **P13-054** — Apply Pod Security standards _(depends on: P13-053)_
- [ ] **P13-055** — Scan manifests _(depends on: P13-054)_
- [ ] **P13-056** — Test workload access _(depends on: P13-055)_
- [ ] **P13-057** — Create Helm chart _(depends on: P13-056)_
- [ ] **P13-058** — Parameterize application values _(depends on: P13-057)_
- [ ] **P13-059** — Parameterize Kafka connection values _(depends on: P13-058)_
- [ ] **P13-060** — Create dev values _(depends on: P13-059)_
- [ ] **P13-061** — Create enterprise-like values _(depends on: P13-060)_
- [ ] **P13-062** — Deploy with Helm _(depends on: P13-061)_
- [ ] **P13-063** — Upgrade Helm release _(depends on: P13-062)_
- [ ] **P13-064** — Rollback Helm release _(depends on: P13-063)_
- [ ] **P13-065** — Write operations guide _(depends on: P13-064)_

## Task-level acceptance and verification

Refer to the corresponding `Task_ID` row in `Kafka_Learning_Lab_Task_Checklist.csv` for the source acceptance criteria, verification approach, task type, priority and dependency. Record test evidence before changing the status to Done.
