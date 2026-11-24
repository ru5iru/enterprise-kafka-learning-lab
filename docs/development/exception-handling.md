# Exception and failure handling

Preserve failure meaning and the original cause; handle it at the boundary that can make a useful decision. Do not swallow `catch (Exception)`, catch Error to continue normal processing, replace failures with null/success, or log-and-rethrow at every layer. Checked versus unchecked exceptions should reflect the caller contract and recovery needs, not an automatic wrapping rule. Custom failure types use meaningful names; satisfy the compiler's applicable serial warnings deliberately.

| Failure | Required policy before implementation |
|---|---|
| Invalid startup/configuration | Fail before creating clients/listeners; report safe field/error code, never credential value |
| Invalid request/event or serialization | Treat as deterministic until corrected; no blind retry/offset advancement |
| Transient remote failure | Retry only with explicit attempt/time budget, backoff/jitter and idempotency review; surface exhaustion |
| Authentication/authorization denial | Stop/reject with safe diagnostics; do not repeatedly retry bad identity/privilege configuration |
| Interrupted blocking operation | Restore the interrupt flag when catching InterruptedException, propagate/stop promptly; do not convert cancellation into retry |
| Asynchronous producer failure | Observe callback/future result as well as synchronous send errors; enqueue is not acknowledgement |
| Consumer processing failure | Do not report success or advance offsets implicitly; follow an explicit retry/parking/stop policy at its owning task |
| Timeout/unknown publication outcome | Do not assume nothing was written; retry/replay needs duplicate/idempotency analysis |

Keep retry ownership explicit so client, framework and application retries do not multiply into an unbounded storm. Never invent a universal retry count here: the owning experiment must set/validate bounded configuration and verify behavior. Repeated processing can repeat external side effects; Kafka idempotent publication alone is not end-to-end exactly-once behavior.

Close owned resources with structured lifecycle/try-with-resources where appropriate. Preserve primary failures and relevant suppressed-close errors rather than overwriting the cause. Translate failures once at API/message/process boundaries into stable safe error codes; do not expose internal stack traces, raw Kafka records, SQL/connection strings or credential-bearing exception messages. Sanitized restricted diagnostics and useful metrics belong to the logging/observability policy. Broad catches are only justified at a true terminal boundary with explicit reporting/cleanup/failure outcome, never silent continuation.

These are reviewed standards, not implemented handlers/retry/DLT/offset policies. P2/P3 and P6 implement/test the relevant behavior. Documentary scenarios covered valid input, invalid config, serialization, producer timeout, consumer failure, interruption and auth denial. [P1-029 evidence](../testing/evidence/P1-029-review.md) records review, not simulated runtime results. Changing a failure contract later requires caller/consumer/security review and applicable tests; do not weaken errors just to make a check green.
