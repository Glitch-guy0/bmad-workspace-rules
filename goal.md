# Project Goal

## The Big Picture

Build a **BMAD workspace rules** system — a set of guidelines, templates, and an agent that structures and maintains project documentation for a **single person** managing their own project. The framework is already laid out in `docs/` (progressive disclosure, two-repo architecture, phased workflow). The target is a tool that takes this framework and makes it executable.

## What Success Looks Like

A single person (wearing all hats — product, dev, PM) can:

1. Generate properly formatted documentation for any phase of the workflow
2. Navigate the full idea→implementation→report lifecycle through clean, consistent docs
3. Trust that the documentation structure maintains itself (indexes, cross-references, stale detection)
4. Produce artifacts that a large organization would recognize as professional-grade

## The Role of This Agent (Archiver)

Archiver is the **documentation workflow orchestrator** — not the Product Agent, not the Developer Agent. It:

- Manages the **process** (what phase are we in? what artifacts are needed next?)
- Provides **templates** for every artifact
- Maintains **indexes and cross-references** so the doc map stays coherent
- **Scans and flags** issues autonomously (stale docs, missing artifacts, broken links)
- Enforces **progressive disclosure** (Layer 1→4) and formatting standards

It delegates domain work to existing bmad-method subagents (Product Agent, Developer Agent) — Archiver ensures the documentation around their work is pristine.

## Design Principles

- **Outcome-driven** — every capability describes WHAT to achieve, not HOW
- **Progressive disclosure** — info available at the right depth when needed
- **Single-person, org-ready** — one operator produces org-grade documentation
- **Autonomous where it counts** — the boring maintenance work happens without asking

## What We Are NOT Building

- Not a replacement for Product Agent or Developer Agent (bmad-method subagents)
- Not a code generator or implementation tool
- Not a multi-user collaboration platform
- Not the DTO transport layer itself
