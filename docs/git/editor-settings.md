# Editor settings

P1-004 configures repository formatting hints in [.editorconfig](../../.editorconfig). Enable EditorConfig support in your editor; this file is not a formatter, linter, compiler or security control.

| Files | Expected editing behavior |
|---|---|
| Default text | UTF-8 without BOM, LF, final newline, spaces with width 2, trim trailing whitespace |
| Java | Default text rules, width 4 |
| XML / POM | Default text rules, width 2 |
| Markdown | Trim trailing whitespace; use paragraphs/lists rather than two-space hard breaks in new work |
| CSV | UTF-8 without BOM, CRLF in the working copy, preserve trailing spaces in cells |
| BAT / CMD | CRLF |

The CSV exception preserves the inherited ledger layout; it does not authorize opening/resaving all 726 rows through a spreadsheet. Preserve header, task IDs/order, dependencies and unrelated rows. Historical baseline Markdown is not mass-formatted by this task.

## Editor versus Git

[.gitattributes](../../.gitattributes) controls Git normalization/checkout, while EditorConfig directs supported editors on save. Git text normalization can store CSV as LF in commits while the editor/working checkout uses CRLF. These are different layers. Do not change global `core.autocrlf` or renormalize the repository as part of a task.

Git reported that LF in .gitignore may become CRLF in this Windows checkout; its eol attribute is unspecified. This warning was not a failed check. Markdown is explicitly LF in Git attributes. Inspect with:

```text
git check-attr text eol -- .editorconfig .gitignore README.md docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv
git diff --check
```

## Verification and recovery

Static CLI review verifies syntax/property values and existing Git attributes. No IDE save, real EditorConfig-core resolution or Java formatter ran; formatter selection belongs to P1-023/P1-035. When settings appear ignored, check EditorConfig support, filename case and closer overrides. Review the diff after saving one non-baseline file; never bulk-format the roadmap or ledger. Revert the configuration change in a new commit if it causes unintended edits.

[EditorConfig specification](https://spec.editorconfig.org/) describes precedence and supported properties. [P1-004 learning](../learning-notes/P1/P1-004.md) and [evidence](../testing/evidence/P1-004-review.md) record the checks.
