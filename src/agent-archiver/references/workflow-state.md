---
name: workflow-state
description: Track every item's lifecycle phase and report current state
code: WS
---

# Workflow State

Phase definitions reference: `references/workspace-rules.md` (Q1-Q10 Lifecycle).

## What Success Looks Like
The owner asks "where is X?" or "what's the status of Y?" and you surface a clear answer: what Q-phase it's in, what artifacts exist, what's blocking, and what should happen next. No digging through folders. No "let me check." You know the state because you maintain it.

## Your Approach

### The Q1-Q10 Phases

Every item moves through these phases:

| Phase | Name | Key Artifacts |
|-------|------|---------------|
| Q1 | Idea Capture | `ideas/[slug].md` |
| Q2 | Validation | Idea explored, evidence gathered |
| Q3 | Milestone Structuring | `milestones/active/[slug]/milestone.md`, requirements |
| Q4 | Stress Test | `milestones/active/[slug]/stress-test/session-[date].md` |
| Q5 | Sign-off | `milestones/confirmed/[slug]/milestone-confirmed.md`, DTO 1 |
| Q6 | Dev Planning | TDD, ADRs, API contracts, ERDs, spikes |
| Q7 | Validation & Sign-Off | Gate 1 + Gate 2 reviews |
| Q8 | Implementation Planning | Brainstorm, vertical slices, atomic change plan |
| Q9 | Testing & Atomic Changes | Test scenarios, atomic commits |
| Q10 | Implementation & Docs | Code, `reports/[slug]-report.md`, DTO 2 |

### Decision Record Phases

- **SDR**: Proposed → Accepted → Superseded (strategic level)
- **PDR**: Proposed → Accepted → Superseded (product level)
- **ADR**: Proposed → Accepted → Superseded (technical level)

### NFR/Tech Debt Phases

- **NFR**: Proposed → Reviewing → Confirmed → Rejected
- **Tech Debt (Accepted)**: Accepted → (ADR filed) → Resolved
- **Tech Debt (Postponed)**: Postponed → (trigger hit → NFR proposal) → Resolved

### State Tracking

Maintain a lightweight state table in MEMORY.md or an organic file:

```markdown
## Workflow State

| Item | Phase | Artifacts | Blockers | Next Action |
|------|-------|-----------|----------|-------------|
| [slug] | Q1 — Idea | ideas/[slug].md | — | Validate |
| [slug] | Q6 — Dev Planning | planning/[slug]/tdd.md | Missing ADR | File ADR |
```

Update this whenever you transition an item between phases or create/modify its artifacts.

### On "What's the State?"

When the owner asks about a specific item:
1. Read its state entry
2. List what artifacts exist (check file system if needed)
3. Identify any blockers (missing artifacts, unresolved questions)
4. Recommend the next action

When they ask about everything:
1. Summarize by phase — "2 in Q1 idea, 1 in Q6 dev planning, 1 in Q10 implementation"
2. Highlight anything that's stalled or blocked
3. Flag things that need attention (stale phases, open blockers)

### Stalled Item Detection

| Phase | Stalled After | Flag |
|-------|---------------|------|
| Q1 Idea | 7 days no activity | Unvalidated ideas pile up |
| Q2 Validation | 14 days | Validation paralysis |
| Q6 Dev Planning | 14 days | Analysis paralysis |
| Q7 Gate Review | 7 days | Review bottleneck |
| Q10 Implementation | 14 days without progress update | Implementation stall |
| Report generated | 3 days not dispatched | Report sent but not acted on |

## Memory Integration
Check MEMORY.md for the state table. Update it whenever you transition an item or create artifacts.

## After the Session
Note in the session log which items were discussed and any state changes made.
