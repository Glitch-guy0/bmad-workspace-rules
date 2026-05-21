---
id: promise-001
title: Promise Exception Registry
status: accepted
date: 2026-05-20
deciders: Prajwal
---

# Promise Exception Registry

Resolve tension T2 between constitution ("async/await only") and braindump allowance for `.then().catch()`.

## Default Policy

- **Default:** `async/await` in application code (services, controllers)
- **Exception:** Native callbacks wrapped in promisify, stream pipelines, or third-party APIs with no async variant
- **Never:** `.then()` for business logic flow control

## Registry

| API / pattern | File pattern | Rationale | Approved |
|---------------|--------------|-----------|----------|
| `fs.promises` pipeline with streams | `*.repository.ts`, `src/utils/stream*.ts` | Streams with known error types, backpressure control | 2026-05-20 |
| `zlib` stream chaining | `src/utils/compression*.ts` | Multi-step transform pipes | 2026-05-20 |
| Third-party callback APIs | `*.adapter.ts` | No native async variant available | 2026-05-20 |

## Process for New Entries

1. Create PR referencing this registry
2. Explain why async/await is not viable
3. Get approval from 1 senior reviewer
4. Add entry with date

## ESLint Consideration

Future: `@typescript-eslint/no-restricted-syntax` with allowlist for registry patterns.