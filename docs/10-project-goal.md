# Project Goal

## The Big Picture

Build a **BMAD workspace rules** system — a set of guidelines, templates, and an agent that structures and maintains project documentation for a **single person** managing their own project. The framework is already laid out in `docs/` (progressive disclosure, two-repo architecture, phased workflow). The target is a tool that takes this framework and makes it executable.

## Context

`docs/02-repo-agent-structure.md` documents a two-repo architecture with Product Agent and Developer Agent subagents (existing bmad-method agents — reference material). It defines handoffs, stress tests, file structures, and a phased lifecycle.

This is a **bmad-workspace-rules** project — workspace rules that structure project documentation for a **single person** wearing all roles (product, dev, PM). The existing agents (Product Agent, Developer Agent) are roles from bmad-method, not what we are building.

## The Problem

Current state: agents work but the documentation workflow has no formal orchestrator. For a single person managing the entire product→dev pipeline:

- No standardized format — ideas, milestones, reports each follow ad-hoc structure
- No lifecycle awareness — items stall between phases without visibility
- Handoffs are manual — knowing when to invoke which agent depends on tribal knowledge
- Documentation debt compounds — stale indexes, broken cross-references, missing artifacts

The goal: make documentation easier on the eyes for a single person managing the workflow.

## What Success Looks Like

A single person can:

1. Generate properly formatted documentation for any phase of the workflow
2. Navigate the full idea→implementation→report lifecycle through clean, consistent docs
3. Trust that the documentation structure maintains itself (indexes, cross-references, stale detection)
4. Produce artifacts that a large organization would recognize as professional-grade

Archiver is the **documentation workflow orchestrator** that makes this possible. It governs the paper trail, delegates domain work to existing subagents (Product Agent, Developer Agent), and enforces formatting standards — it never writes code or validates business ideas.

## What We're Building

**Archiver** — an autonomous, memory-backed documentation workflow orchestrator (Autonomous Memory Agent) that:

1. **Initializes documentation workspace** — guided `init` flow to set `document_folder`, create full folder structure (ideas/, milestones/, planning/, reports/, nfr-proposals/, tech-debt/, strategy/, dto/, etc.), and import existing documentation
2. **Governs the documentation lifecycle** — enforces proper phases (Q1 idea → Q2 validation → Q3 milestone → Q4 stress test → Q5 sign-off → Q6 dev planning → Q7 validation gates → Q8 implementation planning → Q9 testing → Q10 implementation)
3. **Provides templates and structure** — standardized formats for ideas, milestones, ADRs, PDRs, SDRs, reports, stress test sessions, TDDs, ERDs, API contracts, NFR proposals, tech debt, vertical slices, and more
4. **Enforces progressive disclosure** — Layer 1-4 format across all docs (one-liner → summary → brief flow → detailed spec)
5. **Remembers between sessions** — tracks lifecycle state, decisions, blockers
6. **Operates autonomously** — maintains indexes, flags stale docs, checks cross-references via Pulse
7. **Single-person workflow** — solo operator managing product → dev pipeline

### Key Operating Assumptions

- `document_folder` (default `{project-root}/_bmad-docs`) is the workspace root for all documentation artifacts
- Init flow creates the full folder tree and can import existing docs
- Invokes existing Product Agent and Developer Agent (bmad-method) — manages docs around their work
- Two-repo architecture (product-repo / dev-repo) is the operating model
- Provides templates and enforces format standards; subagents execute domain work
- Operates at the "meta" level — manages documentation process, not implementation

## Design Principles

- **Outcome-driven** — every capability describes WHAT to achieve, not HOW
- **Progressive disclosure** — info available at the right depth when needed
- **Single-person, org-ready** — one operator produces org-grade documentation
- **Autonomous where it counts** — boring maintenance happens without asking

## What We Are NOT Building

- Not a replacement for Product Agent or Developer Agent (bmad-method subagents)
- Not a code generator or implementation tool
- Not a multi-user collaboration platform
- Not the DTO transport layer itself
