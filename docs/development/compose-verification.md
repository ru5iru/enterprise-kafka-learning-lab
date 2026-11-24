# Compose verification

P1-019 installed Ubuntu package `docker-compose-v2=2.40.3+ds1-0ubuntu1~24.04.1` using the existing authenticated Ubuntu package metadata and normal dpkg locking. No global package upgrade or unrelated package removal ran. This matches the Ubuntu Docker package family in ADR-0012, not upstream Docker CE packaging.

Run `bash scripts/wsl/verify-compose.sh` as WSL root (explicit Docker daemon access). It repeats `docker compose config --quiet`, rejects a missing required interpolation variable and an invalid top-level schema, then checks the daemon project-list API. A temporary config-only image points to reserved example.invalid; no image is pulled and no stack/port/volume is created. `--env-file /dev/null` and fake input avoid reading a real project env file or printing expanded values. Temporary files are removed.

See [evidence](../testing/evidence/P1-019-review.md). Parsing proves the CLI/schema behavior and project-list call proves basic daemon access; neither proves Kafka readiness or application connectivity. For failures, inspect selected plugin/version, required variables, schema and socket permissions separately. Never fix permission errors with a world-writable socket. Rollback can remove/correct the probe and review the new plugin package; no stack teardown is required.
