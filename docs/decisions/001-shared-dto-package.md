---
id: 001
title: Shared DTO Package
status: accepted
date: 2026-05-19
deciders: Prajwal
---

# ADR 001 — Shared DTO Package

## Status

Accepted

## Context

Backend and frontend must share API contracts without duplicating types. The brainstorming session resolved T1 in favor of an internal package at `packages/dto/`.

## Decision

- Create `packages/dto/` as a workspace-internal package
- Export **TypeScript types and Zod schemas** used at API boundaries
- FE and BE depend on `packages/dto` via package name
- No business logic in DTO package
- Versioning: lockstep with API changes; breaking changes require coordinated release

## Structure

```
packages/dto/
├── package.json
├── tsconfig.json
├── src/
│   ├── index.ts
│   └── auth/
│       ├── auth.dto.ts      # Zod + inferred types
│       └── auth.types.ts    # if split needed
```

## Consequences

**Positive:**
- Single contract source; compiler catches drift

**Negative:**
- Extra package to publish/build in CI

**Risks:**
- Scope creep (putting services in dto package) — forbid via lint/rule

## Migration (Brownfield)

For existing projects:
1. Extract types from BE controllers into `packages/dto/`
2. Add FE dependency on `@workspace/dto`
3. Replace FE inline types with DTO imports
4. Add lint rule preventing business logic in DTO package