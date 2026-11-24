# Kafka CLI in WSL

P1-025 installs the official Scala 2.13 binary distribution of Apache Kafka **4.4.0** under `/opt/kafka-lab/kafka_2.13-4.4.0`. Apache's current downloads page was reviewed on 2026-11-24 after following its official relocation to community/downloads. The [installer](../../scripts/wsl/install-kafka-cli.sh) pins the publisher SHA-512 before extraction and accepts a local archive acquired with verified TLS, using the documented Apache-host transport fallback when necessary.

The project launcher exports KAFKA_HOME and selects Linux CLI scripts. For example: `bash scripts/wsl/lab.sh kafka-topics.sh --version`. Topic administration and console consumer version checks execute client programs only; they do not start a broker or create resources. Invalid CLI options must be rejected before network use. The distribution includes server scripts, but none is started/configured by installation.

A Kafka producer sends records; a consumer reads records; a broker stores/serves partitions; the KRaft controller manages metadata. Installing command-line clients does not supply a running broker or establish connectivity, delivery semantics, TLS/ACLs or broker/client compatibility. The actual broker/image choice and first message experiments remain P3. [Evidence](../testing/evidence/P1-025-review.md) records local Java 25 CLI behavior.

For missing commands, use the WSL launcher and inspect KAFKA_HOME instead of a Windows executable. On version/hash changes, review the official source/pin; never bypass TLS/checksum validation. Rollback retires only this versioned tool directory after checking users; no broker data was generated and no future data must be deleted automatically.
