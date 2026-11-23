# Security policy for the learning lab

This is a learning repository, **not a certified production deployment**. The architecture intentionally starts with simple local infrastructure and introduces controls incrementally. Do not expose an unsecured lab to the public internet.

Report suspected vulnerabilities privately to the repository owner through a private channel; do not publish working secrets or exploit details in issues. No security contact address has been designated yet.

Read [security baseline](docs/security/SECURITY_BASELINE.md) and [SSDLC handbook](docs/roadmap/SSDLC_AND_VERIFICATION.md). Authentication, TLS/mTLS, ACLs and certificate rotation are future tasks; their absence in the initial scaffold is explicitly known and must never be represented as production-ready security.
