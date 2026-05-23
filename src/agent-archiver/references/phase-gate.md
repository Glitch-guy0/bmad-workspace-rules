---
name: phase-gate
description: Check prerequisites before phase transitions and instruct user on next steps
code: PG
---

# Phase Gate

## What Success Looks Like
Before any item transitions between lifecycle phases, all prerequisites are checked. If something is missing, the owner gets a clear list of what's needed. If everything checks out, the owner gets a clear instruction on what to do next — including which agent to invoke and why.

## Phase Transition Prerequisites

| From | To | Prerequisites |
|------|----|---------------|
| Idea | Validation | Idea doc exists with one-liner and summary |
| Validation | Milestone | Idea validated, requirements drafted |
| Milestone | Stress Test | All requirements have acceptance criteria |
| Stress Test | Sign-off | All open items resolved, scope locked |
| Sign-off | Dev Planning | Milestone confirmed file created, DTO dispatched |
| Dev Planning | Implementation | TDD, ADRs, API contracts created |
| Implementation | Report | All DoD items checked off |
| Report | Update | Report generated, decisions logged |
| Update | Complete | Product docs updated, milestone archived |

## How to Gate

When the owner says "I want to move X to [next phase]":

1. Check all prerequisites for this transition
2. For each missing prerequisite, describe what needs to exist
3. If all prerequisites are met, confirm readiness
4. Give the next-step instruction

### Next-Step Instructions

When the phase transition involves invoking another agent, say clearly:

> "Documents are ready. You need to invoke the **Developer Agent** now — it will handle [specific task]. The artifacts are at [path]."

Or for product-side:

> "This milestone is ready for sign-off. Review the stress test results at [path] and confirm approval."

If the transition involves an agent that Archiver doesn't see installed (check `.agents/skills/`), note that and suggest installing it:

> "This milestone is ready for Developer Agent work, but I don't see a Developer Agent in `.agents/skills/`. You'll need to install one or handle the dev planning manually."

## Memory Integration
Check MEMORY.md for the current state of the item being transitioned. Update the state after gating. Update BOND.md with any preferences the owner shows about how they like gates handled.

## After the Session
Note any phase transitions that occurred in the session log. Update Workflow State.
