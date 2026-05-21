---
title: TanStack-first Frontend
status: draft
source: _bmad-output/research/R-04-tanstack-scaffold-gate.md
---

# TanStack-first Frontend

Frontend scaffold rules preferring TanStack modules per constitution.

## State Split (Constitution)

| State type | Tool | Examples |
|------------|------|----------|
| Server state | **TanStack Query** | API lists, detail views, mutations |
| Routing | **TanStack Router** (new apps) or Next App Router | Prefer Router when SPA; App Router when Next |
| Tables | **TanStack Table** | Data grids, sort/filter |
| Client UI state | Redux Toolkit or React state | Auth token in memory, UI toggles |

## Greenfield Scaffold Gate

- [ ] `@tanstack/react-query` installed with `QueryClientProvider`
- [ ] API hooks colocated under `src/lib/api/` using query keys convention
- [ ] No `useEffect` + `fetch` for server data in new code
- [ ] Redux slices **must not** store server-fetched entities
- [ ] Table UIs use TanStack Table before MUI DataGrid alternatives

## Brownfield Rules

- **Surgical strike:** New files TanStack-only
- Touching legacy Redux-server code → create migration ticket
- **ADR** if exception needed for third-party widget coupling

## Essential Packages

```bash
npm install @tanstack/react-query
npm install @tanstack/react-router  # for SPA
npm install @tanstack/react-table    # for data grids
```

## Query Key Convention

```typescript
const queryKeys = {
  users: ['users'],
  user: (id: string) => ['users', id],
  posts: ['posts'],
}
```