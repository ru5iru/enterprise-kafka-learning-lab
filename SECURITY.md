# Security policy

This is a learning lab, not a certified production deployment. P0 planning and P1 repository foundations do not establish runtime security. No application, broker, database or Kubernetes deployment exists yet. Use synthetic data and isolated local environments; never expose an intentionally unsecured lab to untrusted networks.

## Supported scope

There are no published releases as of the GitHub API check on 2026-11-24. The repository owner reviews reports about the current main branch and active task work on a best-effort basis. Older snapshots have no promised maintenance stream. No security response deadline, production support, certification or bounty is offered. Tool versions selected in ADRs are learning choices, not an upstream support guarantee.

## Report safely

**Private vulnerability reporting was disabled at the 2026-11-24 API check. No dedicated security email/contact has been designated.** This policy does not enable the feature or establish a new contact. Check the repository [security page](https://github.com/ru5iru/enterprise-kafka-learning-lab/security) for current options; settings can change after this dated observation.

1. If a private "Report a vulnerability" option is now available, use it for sensitive details.
2. Otherwise, use an already established private channel with the repository owner if one exists. Do not infer a reporting address from Git author metadata.
3. If no private route is available, open a non-sensitive [contact request](https://github.com/ru5iru/enterprise-kafka-learning-lab/issues/new/choose) asking only for a private security contact. Say only that you need a private reporting route. Do not include the affected component, exploit, payload, logs, credentials or impact details in that public request. Wait for a verified private route before sharing them.

Lack of a private route is a known reporting limitation, not permission to disclose publicly. Do not submit a public proof of concept, ordinary PR with an exploit, or real secret as a trial report. Enabling private reporting or designating a monitored contact remains an owner follow-up; it is not claimed complete by this policy task.

## Information for the private report

After a private channel is confirmed, provide the affected commit/component, a short impact explanation, minimal isolated reproduction with synthetic data, expected versus actual behavior, relevant sanitized tool versions and a proposed mitigation if known. Send the minimum necessary information. Do not include production credentials, full environment dumps, private keys, customer data or live third-party targets.

The owner can triage scope, reproduce safely, coordinate a correction and discuss disclosure timing. No independent security review or response-time guarantee is implied. A report is not sent by merely following a template, and no report/notification was submitted while preparing this policy.

## Credentials or sensitive data exposed

Stop further publication and notify the owner through a verified private route. The credential owner should revoke/rotate exposed credentials promptly; deleting a file or adding .gitignore rules does not invalidate a credential or erase Git history, forks or clones. Preserve only redacted evidence. Coordinate any history cleanup deliberately; agents must not force-push or rewrite shared history automatically.

## Progressive controls and current limits

Read the [security baseline](docs/security/SECURITY_BASELINE.md), [trust boundaries](docs/security/trust-boundaries.md), [open STRIDE risks](docs/security/initial-stride-model.md) and [SSDLC handbook](docs/roadmap/SSDLC_AND_VERIFICATION.md). Ignore rules and manual staged review are hygiene, not a complete secret scan.

TLS/mTLS, SASL/ACLs and certificate lifecycle experiments belong to P9; Kubernetes hardening to P13; full SAST/SCA/SBOM/release gates to P14. Basic CI is later in P1. These controls are not implemented merely because the policy describes them. Recheck this document when reporting settings, executable scope or release support changes.

## References

- [GitHub security-policy guidance](https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/configure-vulnerability-reporting/add-security-policy).
- [GitHub private reporting guidance and unavailable-channel fallback](https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/report-privately).
- [P1-010 learning record](docs/learning-notes/P1/P1-010.md) and [verification](docs/testing/evidence/P1-010-review.md).
