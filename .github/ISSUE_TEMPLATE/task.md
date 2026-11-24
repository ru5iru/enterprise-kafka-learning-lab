---
name: Roadmap task
about: Plan and verify one existing task from the learning roadmap
title: "[P#-###] "
labels: []
assignees: []
---

Do not include credentials, private keys, real customer data or unredacted logs. For a suspected vulnerability, follow [SECURITY.md](https://github.com/ru5iru/enterprise-kafka-learning-lab/blob/main/SECURITY.md) instead of a public issue. These Markdown prompts do not enforce required fields; the reviewer checks completeness.

## Task identification

- Exact task ID and CSV title:
- Phase:
- Dependencies and current CSV status:
- Existing issue/PR, if any (avoid duplicates):

Use the stable [task CSV](https://github.com/ru5iru/enterprise-kafka-learning-lab/blob/main/docs/roadmap/Kafka_Learning_Lab_Task_Checklist.csv). Do not invent an ID, renumber tasks or treat issue closure as CSV completion.

## Goal and definition of done

- Knowledge/practical skill to acquire:
- Smallest scoped deliverable:
- Exact acceptance criteria and verification method:
- Included files and excluded later work:

## Design and SSDLC

- Selected approach, rationale and alternatives:
- Architecture/trust boundaries, errors and security risks:
- Configuration changes and rollback:

## Verification plan

- Positive case and expected observation:
- Negative/failure case, or why not applicable:
- Sanitized evidence path; distinguish planned checks from executed results:

## Completion records

- [ ] Task-specific learning note covers decisions, alternatives, patterns, vulnerabilities and lessons
- [ ] Applicable ADR/diagrams and real verification evidence
- [ ] Only legitimate tracking fields updated after acceptance; preserve unrelated rows
- [ ] Task branch, Conventional Commit and PR follow the contribution workflow
