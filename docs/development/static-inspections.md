# Static inspection baseline

P1-024 configures the installed Java 25 compiler as an initial static inspection gate: `--release 25 -proc:none -Xlint:all -Werror`. Run `bash scripts/wsl/inspect-java.sh file.java [...]`. Input paths must be existing Java files; bytecode is generated only in a unique cleaned Linux temp directory. Annotation processors are disabled for this isolated inspection, not silently enabled from a classpath.

The installed `javac --help-lint` categories were reviewed. Repeated warning-free source passes; raw/unchecked collection usage is observed rejected because warnings are errors. Syntax errors are also rejected. Prefer fixing the type/design issue; any necessary suppression must be narrow, explained and reviewed, not a blanket removal of the gate.

This is compiler-backed static analysis, **not full SAST**, secret scanning, dependency analysis or data-flow security verification. It does not detect every unused member, swallowed exception, SQL injection or Kafka semantic error. Domain/error/logging/config rules remain manual review and later task standards. Maven enforcement belongs to P1-033/P1-035; the standalone script currently has no application dependency classpath and is intended for independent snippets/probes. [Evidence](../testing/evidence/P1-024-review.md) records actual outcomes.

Rollback: correct/revert the explicit gate after reviewing reasons. No global compiler/IDE setting or source tree was rewritten; temporary output cleanup needs no application recovery.
