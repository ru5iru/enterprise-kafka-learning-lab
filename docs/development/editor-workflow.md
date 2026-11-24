# Editor-to-WSL workflow

The existing Windows VS Code CLI reports 1.107.1 (x64). Open `enterprise-kafka-learning-lab.code-workspace` in that editor, or continue editing here. No Windows JDK/Maven/Docker or additional Windows IDE was installed. The checked-in workspace uses an Ubuntu WSL terminal and process tasks that run the project launcher inside Linux. It also has native Linux command defaults for an optional remote-WSL editor session.

Use Tasks: Run Task → WSL: Java version / WSL: Maven version. Both argument vectors were resolved/executed without a shell and returned Linux versions. GUI task selection, language-server indexing and debugger attachment were not exercised; no Java application exists yet. Java formatting/inspections are configured in their own following tasks.

A root `.code-workspace` is versioned instead of overriding the ignored personal `.vscode/` directory. Terminal activation alone does not source project settings: use `bash scripts/wsl/lab.sh <command>` as documented. Docker access still follows ADR-0012 and is not granted through editor settings. No run-on-open task, downloaded extension, global preference or workspace-trust bypass was configured.

Rollback: close this optional workspace or correct its local task/profile entries; global/editor user settings are untouched. See [P1-022 evidence](../testing/evidence/P1-022-review.md) and [WSL setup](wsl-setup.md).
