# P0-024 - Define payload size

**Date:** 2026-11-24
**State:** Reviewed planning decision; no runtime implementation or measured results.

## Payload assumptions

Use **1 KiB (1,024 bytes) average serialized event value** and a provisional **4 KiB (4,096 bytes) maximum lab event value**. The cap belongs to the future lab input/contract policy; it is not a selected Kafka broker/client message-size setting. Exact field schemas and validation behavior remain implementation/contract work.

At 50 produced records/s, modeled event-value ingress is 51,200 bytes/s; at 200 records/s it is 204,800 bytes/s. Values exclude keys, headers, protocol/batch/record framing, indexes, network encryption overhead, replica traffic and compression effects. Do not label them full network bandwidth or disk requirements.

A later generator should measure the encoded bytes of real synthetic values rather than pad logs with sensitive data or assume one byte per character. Validate near-boundary values, reject over-cap values at the intended layer, and account for schema/CDC envelopes. Compression ratios must be measured for the actual synthetic distribution; assume no compression benefit for planning calculations.

The cap/average are chosen hypotheses, not observed message distributions. P7 and P11 must record actual serialized sizes and justify any revised model before making capacity claims.

## Evidence

See [task learning record](../learning-notes/P0/P0-024.md) and [document review](../testing/evidence/P0-024-review.md).
