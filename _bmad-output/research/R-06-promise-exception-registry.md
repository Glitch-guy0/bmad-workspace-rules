---
id: R-06
status: open
priority: P2
brainstorm_ref: 'Part 2 R-06; Cat #15; T2 deferred'
---

# R-06 — Promise exception registry (T2)

## Goal

Resolve tension between constitution ("async/await only") and braindump allowance for `.then().catch()` on well-typed Node APIs via an explicit, reviewable registry.

## Research questions

| # | Question |
|---|----------|
| 1 | Which Node/built-in APIs justify promise chains? |
| 2 | Registry format — markdown table vs JSON for tooling? |
| 3 | Who approves new entries (ADR vs PR label)? |
| 4 | ESLint rule: ban `.then` except allowlisted files? |

## Proposed registry location

`docs/decisions/promise-exceptions.md` (ADR-style, append-only)

### Entry template

| API / pattern | File pattern | Rationale | Approved |
|---------------|--------------|-----------|----------|
| `fs.promises` pipeline | `*.repository.ts` | Streams with known error types | YYYY-MM-DD |

### Default policy

- **Default:** `async/await` in application code (services, controllers)
- **Exception:** Native callbacks wrapped in promisify, stream pipelines, or third-party APIs with no async variant
- **Never:** `.then()` for business logic flow control

## Acceptance criteria

- [ ] ADR/registry file exists with at least 2 example entries (or explicit empty + process)
- [ ] T2 marked resolved or deferred-with-trigger in consolidated brainstorm
- [ ] `bmad-workspace-rules` can cite registry on deviation review

## References

- Brainstorm Cat #15 Promise Exception Registry
- T2 constitutional tension — DEFERRED pending this research
