# Logging conventions

Use a logging facade (SLF4J when Java services are introduced) and the selected framework-managed provider; do not add competing backends or speculative version overrides. Prefer structured, bounded fields with stable event codes rather than ad hoc println/raw object dumps. No logging runtime/provider is installed by this policy task.

| Field/level | Convention |
|---|---|
| Core context | UTC timestamp, level, service/version, environment and stable event code |
| Work correlation | Validated synthetic event/correlation ID; trace/span IDs only when actual tracing supplies them |
| Kafka context | Allowlisted topic, partition, offset and group when useful; offset is not a global business ID |
| INFO | Lifecycle and meaningful aggregate outcomes; avoid per-record high-volume noise by default |
| WARN | Recoverable degradation or bounded retries needing attention; avoid one stack trace per retry |
| ERROR | Terminal failed operation/exhaustion/actionable incident, once at the handling boundary |
| DEBUG/TRACE | Explicit local diagnostic enablement; sensitive-data exclusions still apply |

Use parameterized messages or structured key/value APIs rather than eager concatenation. This improves API usage/performance but **does not sanitize** input. Validate/escape CR/LF/control characters, bound field lengths and reject untrusted dynamic field names to prevent forged/multiline records. Provisional opaque lab correlation IDs are at most 128 characters; real trace IDs follow their defined format, not this generic bound. Avoid high-cardinality labels in metrics; logs and metric labels are different tools.

Never log passwords, tokens, private keys, SASL properties, cookies/auth headers, raw record values/headers, customer/payment data, full environment dumps or credential-bearing connection strings. Allowlist safe metadata rather than relying on a broad dump plus a regex. Hashing a secret does not automatically make it safe to publish. Exceptions may carry these values: preserve useful causes internally but emit only approved sanitized diagnostics; no internal stack trace in a public API response. Follow [failure handling](exception-handling.md) to avoid repeated log-and-rethrow noise.

Propagate/clear context deliberately across asynchronous callbacks, consumer threads and thread pools; no MDC propagation or end-to-end trace guarantee exists yet. Define diagnostic access, retention/rotation and saturation/drop behavior when a real sink is chosen. Do not block record handling indefinitely or silently claim audit durability because a logger call returned. P10 implements operational telemetry; relevant earlier tasks must capture sanitized evidence.

Self-review scenarios: allow a synthetic bounded topic/partition/offset outcome; reject a raw record/header dump, credential-bearing exception and a correlation field containing CR/LF; report unknown trace context honestly. These are reviewed examples, not executed redaction tests. [Evidence](../testing/evidence/P1-030-review.md) records the policy review. Later runtime tests must capture logs for success/failure/redaction/injection/context/saturation cases before asserting those controls.
