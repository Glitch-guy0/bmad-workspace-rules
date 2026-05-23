# Understanding — Documentation Workflow Orchestrator Agent

## Context

`docs/02-repo-agent-structure.md` documents a two-repo architecture with Product Agent and Developer Agent subagents (existing bmad-method agents — reference material). It defines handoffs, stress tests, file structures, and a phased lifecycle.

The existing agents (Product Agent, Developer Agent) are roles from bmad-method. This is a **bmad-workspace-rules** project — workspace rules that structure project documentation for a single person.

## The Problem

Current state: agents work but the documentation workflow has no formal orchestrator. For a **single person** handling the entire product→dev pipeline, the process is:

- No standardized format for tracking where things are
- Documentation becomes scattered and hard to navigate
- Progressive disclosure (Layer 1-4) isn't enforced
- No single agent ensures all artifacts are created, updated, and linked properly
- Handoffs between phases are manual and inconsistent

The goal: make documentation easier on the eyes for a single person managing the workflow.

## What We're Building

**Archiver** — an autonomous, memory-backed documentation workflow orchestrator that:

1. **Governs the documentation lifecycle** — enforces proper phases (idea → validation → milestone → stress test → sign-off → dev planning → implementation → report → update)
2. **Provides templates and structure** — standardized formats for ideas, milestones, ADRs, reports, stress test sessions, TDDs, ERDs, API contracts
3. **Enforces progressive disclosure** — Layer 1-4 format across all docs
4. **Remembers between sessions** — tracks lifecycle state, decisions, blockers
5. **Operates autonomously** — maintains indexes, flags stale docs, checks cross-references
6. **Single-person workflow** — solo operator managing product → dev pipeline

## Agent Type

**Autonomous Memory Agent** — memory for session-to-session state, PULSE for autonomous maintenance.

## Key Assumptions

- Invokes existing Product Agent and Developer Agent (bmad-method) — manages docs around their work
- Two-repo architecture is the operating model
- Provides templates and enforces format standards; subagents execute domain work
- Operates at the "meta" level — manages documentation process, not implementation
- **Single person** wearing all roles

## Next Steps

1. Phase 1-2 Discovery: flesh out persona, capabilities, memory architecture
2. Phase 3 Requirements: gather identity seeds, mission, CREED, BOND territories
3. Phase 4 Draft: outline the agent structure
4. Phase 5 Build: generate the agent skill files
5. Phase 6 Summary: present what was built
