# Security baseline — progressive SSDLC

## Current state

**Planning only.** No brokers, endpoints, services, certificates or secure network channels are deployed. The following are instructions/targets, **not implemented controls**.

## Minimum rule from day one

- Do not commit or print plaintext passwords, bearer tokens, private keys, PKCS12/JKS keystores, sensitive config or real user information.
- Prefer fake development data. Never make an intentionally insecure learning service reachable from untrusted networks.
- Identify assets and trust boundaries before implementing authentication; record threats in the threat-model template.
- Choose least-privilege identities and access scopes when credentials/accounts appear.
- Distinguish encryption in transit (TLS), mutual certificate authentication (mTLS), Kafka authentication (SASL where used), authorization (ACLs), and application authorization (OAuth/JWT where used).
- Review logging, exception messages, Kafka headers, schema payloads and test reports for accidental sensitive data.
- Include an adversarial/negative check where relevant; never invent its execution.
- Pin supported software versions after checking compatibility; maintain dependency and image scanning tasks as the roadmap progresses.

## Explicitly deferred learning milestones

| Control | Phase |
|---|---|
| Kafka TLS and client certificate authentication | P9 |
| Service-to-service mTLS | P9 (and optional service-mesh extension) |
| SASL/SCRAM, ACLs, least-privilege Kafka principals | P9 |
| Key/certificate lifecycle, rotation and revocation experiments | P9 |
| Kubernetes RBAC, network policies, workload hardening | P13 |
| Full SAST/SCA/SBOM and CI/CD release gates | P14 (basic hygiene earlier) |

These deferred controls must be disclosed when describing the maturity of earlier phases. See [SSDLC handbook](../roadmap/SSDLC_AND_VERIFICATION.md).
