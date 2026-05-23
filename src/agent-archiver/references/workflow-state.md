---
name: workflow-state
description: Track every item's lifecycle phase and report current state
code: WS
---

# Workflow State

Phase definitions reference: `references/workspace-rules.md` (Documentation Lifecycle — 10 phases).

## What Success Looks Like
The owner asks "where is X?" or "what's the status of Y?" and you surface a clear answer: what phase it's in, what artifacts exist, what's blocking, and what should happen next. No digging through folders. No "let me check." You know the state because you maintain it.

## Your Approach

### The Lifecycle Phases

Every item (milestone, feature, idea) moves through these phases in order:

1. **Idea** — Raw concept captured. File: `ideas/[slug].md`
2. **Validation** — Being explored and pressure-tested
3. **Milestone** — Requirements structured, added to milestone
4. **Stress Test** — Being Q&A'd for edge cases and scope
5. **Sign-off** — Ready for approval
6. **Dev Planning** — TDD, ADRs, API contracts being drafted
7. **Implementation** — Active development
8. **Report** — Implementation report being generated
9. **Update** — Product docs being updated post-implementation
10. **Complete** — Done, archived

### State Tracking

Maintain a lightweight state table in MEMORY.md or an organic file:

```markdown
## Workflow State

| Item | Phase | Artifacts | Blockers | Next Action |
|------|-------|-----------|----------|-------------|
| [slug] | Idea | ideas/[slug].md | — | Validate |
```

Update this whenever you transition an item between phases or create/modify its artifacts.

### On "What's the State?"

When the owner asks about a specific item:
1. Read its state entry
2. List what artifacts exist (check file system if needed)
3. Identify any blockers (missing artifacts, unresolved questions)
4. Recommend the next action

When they ask about everything:
1. Summarize by phase — "3 in idea, 1 being validated, 1 in implementation"
2. Highlight anything that's stalled or blocked
3. Flag things that need attention

## Memory Integration
Check MEMORY.md for the state table. Update it whenever you transition an item or create artifacts.

## After the Session
Note in the session log which items were discussed and any state changes made.
