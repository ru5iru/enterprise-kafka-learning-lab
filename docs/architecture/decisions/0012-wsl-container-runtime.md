# ADR-0012: Ubuntu-packaged Docker engine inside WSL

- **Status:** Accepted for local lab setup, 2026-11-24.
- **Task:** P1-018; owner authorized Linux dependencies/runtime inside WSL.

## Decision and evidence

Use Ubuntu 24.04 signed distribution packages inside WSL: `docker.io=29.1.3-0ubuntu3~24.04.2`, `containerd=2.2.1-0ubuntu1~24.04.4`, `runc=1.3.4-0ubuntu1~24.04.1`. The refreshed private Ubuntu index accepted these pins and the actual engine API reports client/server 29.1.3. This is Ubuntu's distribution packaging, **not Docker CE from Docker's upstream repository**. Do not mix the package families.

An existing unrelated `apt-get -qq -y update` held the global lists lock for more than a day. The installer used a separate temporary lists directory, authenticated Ubuntu package metadata and normal dpkg locking. It did not kill that process, delete lock files, disable signatures or alter repository sources. Exact pins stop a silent version substitution; dependencies are installed from the signed repository and actual primary versions are captured in task evidence.

## Rationale and alternatives

Ubuntu's maintained package family avoids adding a new third-party repository/trust key and integrates with the existing systemd host. Docker's upstream CE repository is an alternative with its own update cadence, key and containerd packaging. Docker Desktop would add a Windows runtime dependency contrary to the requested setup. Rootless Docker could reduce daemon privilege but needs a separate compatibility/resource/network review for later learning tools; it is not installed implicitly.

Keep the rootful daemon on its normal Unix socket. Do not expose unauthenticated TCP or change socket permissions to world-writable. No user is added to the root-equivalent docker group. Execute administrative/container checks explicitly with WSL root or reviewed sudo access. Later Testcontainers/IDE use must account for daemon permissions; no unprivileged access is claimed here. Persistent images/volumes live on the WSL filesystem under `/var/lib/docker`, separate from the mounted source tree.

## Consequences, verification and rollback

Systemd enables/starts Docker in WSL. P1-018 verifies API/package versions, socket selection and permission rejection; P1-019 verifies Compose and P1-020 runs a bounded test container. No broker, application stack or published port is introduced. This local daemon is not a production isolation guarantee or independent fault domain.

Do not purge packages or `/var/lib/docker` as an automatic rollback: future data may live there. Stop/disable the newly introduced service only after checking users; remove selected packages only in a reviewed change. Revisit pins/update/security status at maintenance tasks, and revisit rootless/group access when actual integration tests need it.

## References

- [Docker Ubuntu installation and package-family conflicts](https://docs.docker.com/engine/install/ubuntu/).
- [WSL decision](0011-wsl-development-runtime.md), [P1-018 learning](../../learning-notes/P1/P1-018.md).
