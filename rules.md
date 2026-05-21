# Workspace Rules

**Skill:** `bmad-workspace-rules`  
**Purpose:** Guides project documentation and structure using constitution, research backlog, and dev-story integration.

## Modes

| Mode | When | Behavior |
|------|------|----------|
| `initial-setup` | First run / greenfield | Full structure scan, scaffold `docs/`, baseline coverage |
| `post-commit` | After `bmad-dev-story` | `git diff HEAD~1` → update mirrors for touched paths |
| `re-baseline` | Constitution changed | Re-align all mirror docs to new Appendix A |
| `surgical-strike` | Brownfield touch | Diff-only; no full tree walk |

## Document Precedence

1. **Appendix A** — Project Constitution (immutable defaults)
2. **Part 4** — Delta queue (proposed changes)
3. **Appendix B** — BMAD Skills Registry
4. **Part 3** — Prior brainstorm

Conflicts between Appendix A and Part 4 resolve via ADR (`docs/decisions/`).

## States

| State | Condition | Behavior |
|-------|-----------|----------|
| Undocumented | No docs found | Run `initial-setup` mode |
| Stale | Docs older than code | Run `re-baseline` mode |
| Current | Docs in sync | Run `post-commit` mode |

## Rules

- Never use numbered procedural steps for things the LLM does naturally
- Outcome-based instructions over prescriptive trivia
- Every line must pass: *would an LLM do this correctly without being told?*
- Dry-run destructive changes with explicit diff before apply
- Cap file changes per session; include undo instructions
- YOLO defaults must exist — one keystroke to skip Q&A
- Never more than 2 architecture choices at once
- Session memory: never re-ask answered questions
- Ship partial usable docs — do not block on perfection
- Incremental scan — only changed files, not whole repo

## Constitution Highlights

### Backend Architecture
- Layered: Routes → Controller → Service → Repository
- Repository triad: `schemas/`, `models/`, `cache/`
- Async/await default

### Frontend Architecture
- Next.js App Router
- State split: TanStack Query (server), Redux (client UI)
- `src/lib/api/` for queries

### Testing Strategy
- k6 for HTTP endpoint and load testing
- Jest + ts-jest for unit tests
- Playwright for E2E

### Shared Contracts
- `packages/dto/` for TypeScript types and Zod schemas
- FE/BE import types only

## DX Guardrails (Cat #6)

- Dry-run destructive changes with explicit diff before apply
- Cap file changes per session; include undo instructions
- YOLO defaults must exist — one keystroke to skip Q&A
- Never more than 2 architecture choices at once
- Session memory: never re-ask answered questions
- Ship partial usable docs — do not block on perfection
- Incremental scan — only changed files, not whole repo