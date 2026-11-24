# Container execution verification

The official Docker library hello-world Linux image was pulled once in WSL and resolved to `hello-world@sha256:5e22040d441e5fb3aed38368acbe8486b575d7018df38dbdfbc7311fbb2ef3a9`. The probe runs that immutable digest with pull=never; it does not execute an unreviewed moving tag on every run. To acquire the same artifact later, explicitly pull that digest using the reviewed daemon.

Run `bash scripts/wsl/verify-container.sh` as WSL root. Two successful runs must print the expected synthetic greeting, with no network, read-only root filesystem, no capabilities, no-new-privileges, UID/GID 65534, 32 MiB memory, 0.5 CPU and 32-process limit. Invalid entrypoint and missing local image are expected failures. Only container IDs written to this probe's unique cidfiles are eligible for cleanup; it never prunes global images/volumes or uses an assumed shared name.

[Evidence](../testing/evidence/P1-020-review.md) records results. The image remains cached intentionally; all probe containers/temp files are removed. An image digest establishes byte identity, not absence of vulnerabilities or production isolation. The rootful daemon still has administrative power. No broker, service, published port or volume is created, and no image scanner was run.
