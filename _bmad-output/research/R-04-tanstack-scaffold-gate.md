---
id: R-04
status: open
priority: P1
brainstorm_ref: 'Part 2 R-04; Cat #18; constitution: MUST prefer TanStack'
---

# R-04 — TanStack-first frontend scaffold gate

## Goal

Define greenfield/brownfield rules so new frontend work prefers TanStack Query, Router, and Table before Redux or ad-hoc data fetching.

## Research questions

| # | Question |
|---|----------|
| 1 | Which TanStack packages are mandatory vs optional? |
| 2 | Redux Toolkit — still allowed for client-only state per Appendix A? |
| 3 | Scaffold gate: lint rule, checklist, or skill refusal? |
| 4 | Migration path when existing code uses Redux for server state? |
| 5 | Next.js App Router integration patterns (providers, SSR)? |

## Findings (starter)

### State split (from constitution — retain)

| State type | Tool | Examples |
|------------|------|----------|
| Server state | **TanStack Query** | API lists, detail views, mutations |
| Routing | **TanStack Router** (new apps) or Next App Router | Prefer Router when SPA; App Router when Next |
| Tables | **TanStack Table** | Data grids, sort/filter |
| Client UI state | Redux Toolkit or React state | Auth token in memory, UI toggles |

### Scaffold gate checklist (greenfield)

- [ ] `@tanstack/react-query` installed with `QueryClientProvider`
- [ ] API hooks colocated under `src/lib/api/` using query keys convention
- [ ] No `useEffect` + `fetch` for server data in new code
- [ ] Redux slices **must not** store server-fetched entities
- [ ] Table UIs use TanStack Table before reaching for MUI DataGrid alternatives

### Brownfield gate

- **Surgical strike:** new files TanStack-only; touching legacy Redux-server code requires migration ticket
- **ADR** if exception needed for third-party widget coupling

## Recommended doc output

`docs/engineering/frontend-tanstack-first.md` — decision tree + code snippets for Query + Next.js 14 App Router.

## Acceptance criteria

- [ ] Engineering doc published
- [ ] `bmad-workspace-rules` flags new `store/*Slice` that mirror API entities
- [ ] Appendix A "Libraries of Choice" table updated if Router/Table added
- [ ] `pending_from_braindump` TanStack item closable

## References

- Brainstorm Cat #18 TanStack-First Scaffold Gate
- Appendix A — Frontend Architecture, State Management Split
