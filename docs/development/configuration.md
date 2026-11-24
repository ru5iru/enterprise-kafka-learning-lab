# Configuration conventions

Keep configuration separate from code and expose a small typed, validated set per capability. Use framework-supported property names for framework settings and `lab.<service>.*` for project-owned settings when services exist. Prefer canonical lowercase dotted/kebab names. Examples `lab.order.timeout=2s` and `lab.order.retry.attempts=3` illustrate binding syntax only; they are not approved runtime timeout/retry budgets or SLOs.

Use typed @ConfigurationProperties plus validation when Spring is introduced, rather than scattered string lookups. Validate required values, supported modes, non-empty safe names, numeric ranges, positive duration/size units and cross-field constraints before clients/listeners start. Invalid/missing security settings must fail closed; do not substitute changeme credentials or silently enable weaker authentication. Production-like profiles are not a security boundary.

## Sources and precedence

For normal allowed runtime inputs, Spring's higher-precedence source overrides lower ones: packaged defaults < external configuration data < OS environment < Java system properties < command-line arguments. This is a selected subset, not the complete framework list (tests and other supported sources have their own order). Document the actual enabled sources and active profile; do not assume file location or a profile implies trust. Recheck exact framework behavior when the application is implemented.

Environment mapping follows actual binding rules, not a guessed underscore convention: `lab.order.retry.attempts` maps to `LAB_ORDER_RETRY_ATTEMPTS`. For kebab names, Spring's documented environment conversion removes dashes after converting dots; list/index names have additional rules. Test real binding/precedence for every externally configurable contract later.

## Secrets and WSL boundary

Commit only safe defaults and sanitized examples. Keep credentials outside Git, command-line arguments, images and raw logs; prefer reviewed secret-file/provider injection when available. Do not log resolved config objects or full environment/connection dumps. Environment variables are not inherently secret storage and can be exposed through diagnostics. Validate/report safe field names/error codes without values.

The current project launcher configures public tool paths only. Real local secret files should stay outside this checkout with reviewed Linux ownership/permissions; Windows-mounted files have different permission semantics, so chmod alone must not be assumed equivalent. No secret file/provider, application profile or credentials are created by this standard.

Keep bootstrap endpoints/listeners explicitly reviewed for the active environment; no auto-topic/resource creation or public listener should be enabled merely because defaults exist. Bound retries/timeouts/queues and define rollback/migration of changed property names before using them. Avoid renaming a setting without checking files, env, command-line, tests and deployment consumers.

Documentary review covered valid typed syntax, missing required input, malformed units/ranges, competing sources, profile confusion and sensitive diagnostics. None was an executed Spring binding test. [Evidence](../testing/evidence/P1-031-review.md) distinguishes requirements from implementation. Actual binding, startup, negative and precedence tests belong to owning service tasks; rollback here is a reviewed policy correction.
