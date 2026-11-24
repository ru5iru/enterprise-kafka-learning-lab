# P1-028 verification

**Date:** 2026-11-24
**Method:** Task-specific CLI/static verification and executing-agent self-review; no independent reviewer claimed.
**Dependency:** P1-027: Done; preceding task committed/pushed and upstream tip matches
**Pre-task commit:** `b3a50218743965d5e46beb1248299c32a4f5a34d`

## Scope and acceptance review

Self-reviewed positive domain/event/request/adapter/exception/test examples and negative interface-prefix/catch-all/environment examples. Existing OrderCreated naming remains consistent with ADR-0001. Exact-case filenames and test-discovery implications are disclosed. No Java source or runtime behavior was generated to make a documentation task look implemented.

## Executed check

Command: `python P1-028-verify.py` from the repository root, using this exact script:

```python
from pathlib import Path
text=Path('docs/development/class-naming.md').read_text(encoding='utf-8')
for phrase in ['UpperCamelCase','exact-case filenames','OrderCreated','CreateOrderRequest','KafkaOrderPublisher','InvalidOrderException','OrderPublisherTest','OrderPublisherIT','IOrderPublisher','CommonUtils','does not authorize retry','No classes, tests, interfaces']:assert phrase in text,phrase
assert Path('docs/development/package-naming.md').is_file() and not Path('applications').exists()
print('PASS: type-role/event-command/test examples, reviewed naming counterexamples, case portability and no generated class hierarchy')
```

Exit code: 0. Observed output:

```text
PASS: type-role/event-command/test examples, reviewed naming counterexamples, case portability and no generated class hierarchy
```

## Shared integrity checks

The completion gate compares this task's ledger against the pre-task commit, permits only Status/Completed_Date/Notes/Evidence_Link on this row, preserves every other row and all 726 IDs/order/dependencies, 15 phases, 18 named plus two inherited empty columns and UTF-8/CRLF working-copy layout. It validates all 11 learning-note sections and local Markdown file/directory targets outside code fences. Publication stages only the listed task files, runs both working and staged `git diff --check`, checks added lines for common credential patterns, then commits/pushes and compares the remote branch tip. Publication failure stops the sequence.

## Limitations and rollback

This is a reviewed convention rather than an enforced identifier rule, implemented class model or tested reflection/serialization contract. Test suffix discovery is configured later, not claimed enabled now. No new architecture ADR is required.

Correct the convention normally. Once code/contracts exist, assess imports, reflection, schema consumers and test discovery before a type rename; do not silently rename public event contracts.

## Learning record

[Task-specific rationale, alternatives and lessons](../../learning-notes/P1/P1-028.md).
