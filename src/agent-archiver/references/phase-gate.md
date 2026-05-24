---
name: phase-gate
description: Check prerequisites before phase transitions and instruct user on next steps
code: PG
---

# Phase Gate

Phase transition prerequisites reference: `references/workspace-rules.md` (Phase Transition Prerequisites table). Agent flow reference: `references/agent-registry.md`.

## What Success Looks Like
Before any item transitions between lifecycle phases, all prerequisites are checked. If something is missing, the owner gets a clear list of what's needed. If everything checks out, the owner gets a clear instruction on what to do next — including which agent to invoke and why.

## Phase Transition Prerequisites

| From | To | Prerequisites |
|------|----|---------------|
| Q1 — Idea | Q2 — Validation | Idea doc exists with one-liner and summary |
| Q2 — Validation | Q3 — Milestone | Idea validated, requirements drafted in user stories |
| Q3 — Milestone | Q4 — Stress Test | All requirements have acceptance criteria in Given/When/Then format |
| Q4 — Stress Test | Q5 — Sign-off | All open items resolved, scope locked, MoSCoW assigned |
| Q5 — Sign-off | Q6 — Dev Planning | Milestone confirmed file created, DTO 1 dispatched |
| Q6 — Dev Planning | Q7 — Gate 1 | TDD draft with system context, approach, data model, API design |
| Q7 — Gate 1 (pass) | Q7 — Gate 2 | Gate 1 passed, TDD updated per feedback |
| Q7 — Gate 2 (pass) | Q8 — Impl Planning | TDD approved, ADRs filed, vertical slices planned |
| Q8 — Impl Planning | Q9 — Test & Atomic | Atomic change plan complete, vertical slices ordered, test scenarios drafted |
| Q9 — Test & Atomic | Q10 — Implementation | All test scenarios written, atomic changes planned, feature flag configured |
| Q10 — Implementation | Report | All DoD items checked off (code + docs + product) |
| Report | Update | Report generated, decisions logged |
| Update | Complete | Product docs updated, milestone archived |

## Two-Gate Validation

### Gate 1 — Milestone Confirmation Review
Before TDD begins. Checks the milestone confirmation is ready for engineering.

Checklist:
- [ ] Goal clear + user-facing
- [ ] Every requirement has testable AC (Given/When/Then)
- [ ] Out-of-scope explicitly listed
- [ ] Dependencies confirmed
- [ ] Success metrics defined
- [ ] All open questions answered
- [ ] Scope achievable in timeline
- [ ] No contradiction with existing feature

**Output:** Confirmed (proceed to TDD) or Revise (issues logged with owner + deadline)

### Gate 2 — Technical Design Review
After TDD draft. Checks the technical approach is sound.

Checklist:
- [ ] TDD addresses all Milestone Confirmation requirements
- [ ] Data model backward compatible or migration planned
- [ ] API follows conventions
- [ ] Edge cases accounted for
- [ ] Performance implications understood
- [ ] Security review passed
- [ ] No conflicts with in-flight work
- [ ] ADRs filed for non-obvious decisions
- [ ] Implementation breakable into independent shippable pieces

**Output:** Approved (proceed to implementation planning) or Revise

## How to Gate

When the owner says "I want to move X to [next phase]":

1. Check all prerequisites for this transition — reference the Q1-Q10 lifecycle
2. For each missing prerequisite, describe what needs to exist
3. If all prerequisites are met, confirm readiness
4. Give the next-step instruction — reference which gate or agent

### Next-Step Instructions

When the phase transition involves a gate:

> "Gate 1 check passed. The milestone confirmation is ready — proceed to TDD."

> "Gate 1 has issues. [List missing items]. Resolve these before starting technical design."

When the phase transition involves invoking another agent, say clearly:

> "Documents are ready. Invoke the **Developer Agent** now — it will handle [specific task]. The artifacts are at [path]."

If the transition involves an agent that Archiver doesn't see installed (check `.agents/skills/`), note that and suggest installing it:

> "This milestone is ready for Developer Agent work, but I don't see one in `.agents/skills/`. You'll need to install it or handle the dev planning manually."

## Decision Guardrails for Phase Operations

When a phase transition involves destructive or large-scale operations, apply these safety rules:

| Condition | Action |
|-----------|--------|
| Project constitution missing | Refuse the operation — cannot proceed without governance rules |
| More than N files to change (default: 10) | Refuse with recommendation to split into smaller transitions |
| Destructive operation (move, delete, overwrite) | Require dry-run first — generate unified diff for review |
| Brownfield project without project-context.md | Suggest generating project context first |
| YOLO keyword provided | Skip Q&A but enforce file cap and log undo instructions in session log |
| Pre-flight needed | Max 2 architecture questions, verify constitution path, check git context |

For destructive operations: generate a dry-run plan showing exactly what will change, present it for approval, and include rollback instructions in the session log.

## Memory Integration
Check MEMORY.md for the current state of the item being transitioned. Update the state after gating. Update BOND.md with any preferences the owner shows about how they like gates handled.

## After the Session
Note any phase transitions that occurred in the session log. Update Workflow State.
