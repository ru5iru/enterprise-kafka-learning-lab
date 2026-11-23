# Enterprise Kafka Learning Lab — Markdown Documentation

This package converts the existing **Enterprise Kafka Learning Lab master roadmap** and task checklist into portable Markdown documentation. It preserves the **15-phase / 726-task** baseline from the source documents.

## Start here

1. [Master Roadmap](ROADMAP.md) — decisions, progression, milestones, all phase links.
2. [Architecture](ARCHITECTURE.md) — Mermaid system diagrams, KRaft/Kafka infrastructure, trust boundaries and monorepo blueprint.
3. [SSDLC and Verification](SSDLC_AND_VERIFICATION.md) — security lifecycle, testing, phase gates and definition of done.
4. [Phase-specific tasks](phases/) — 15 individually readable task checklists.
5. [CSV task tracker](Kafka_Learning_Lab_Task_Checklist.csv) — 726 tasks with dependencies, acceptance criteria and tracking columns.

## Viewing diagrams

All diagrams are embedded as `mermaid` fenced code blocks. GitHub, GitLab and Mermaid-capable Markdown viewers render them as diagrams. Standard text editors display the editable Mermaid source instead; no separate image files are required.

## Editing and tracking

Task IDs remain stable and match the CSV. Checkboxes in Markdown are for reading/planning; use the CSV as the canonical task-status ledger to avoid conflicting status copies.

## Scope fidelity

The source roadmap contains phase overviews and task titles in the Word document; the source CSV holds the task-level dependencies, generic acceptance criteria, verification methods and status fields. The additional Mermaid diagrams are a visualization of the agreed architecture and are explicitly conceptual, not deployed implementation artifacts.
