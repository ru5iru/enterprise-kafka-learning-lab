# PostgreSQL client verification

P1-026 installed only Ubuntu `postgresql-client-16=16.15-0ubuntu0.24.04.1` and matching libpq5 (plus client-common dependency) inside WSL. This is a supported distribution client line, not a decision about the future database server version. No PostgreSQL server package or database cluster was created.

Run `bash scripts/wsl/verify-postgresql-client.sh` as the ordinary WSL user. It observes version/help twice and attempts a bounded synthetic connection to unused loopback port 1. The expected failure is exit 2 with Connection refused. It verifies the port is unused first, disables .psqlrc via -X, never prompts (-w), ignores password/service files and supplies no real credentials. It does not successfully execute SELECT 1 or prove database/TLS/schema behavior.

[Evidence](../testing/evidence/P1-026-review.md) records real outcomes. A client banner and a refused connection are tool/diagnostic checks, not database availability. Future persistence/JDBC/server compatibility belongs to the owning P8 tasks. On failure, distinguish missing CLI, wrong host/port and server/authentication issues; do not create a server or weaken TLS merely to make this setup probe pass. Rollback requires checking users of the newly installed client libraries, not deleting data directories.
