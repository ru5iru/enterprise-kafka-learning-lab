# Git in WSL

P1-021 adopted the existing `/usr/bin/git`: upstream banner 2.43.0, Ubuntu package `1:2.43.0-1ubuntu7.4`, matching the observed configured Ubuntu candidate. No redundant install, global identity, credential helper or Git configuration change was needed. A stable distribution package includes Ubuntu revisions independently of the upstream banner; this is not a claim to run the newest upstream Git.

Run `bash scripts/wsl/verify-git.sh` as the ordinary WSL user. It reads this mounted checkout, then initializes/stages/commits only inside a unique Linux temporary repository with an explicitly synthetic identity, hooks disabled and global/system configuration excluded for the probe. It verifies clean then dirty state and invalid-ref rejection. The temporary history is removed and never pushed.

Windows Git continues the already-authorized publication workflow using its existing credentials. Do not perform concurrent Git mutations from Windows and WSL on the shared checkout. Linux remote authentication has not been configured/tested by this task. [Evidence](../testing/evidence/P1-021-review.md) records the actual check. No host Git was replaced, so rollback concerns only these optional probe/docs changes.
