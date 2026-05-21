---
stepsCompleted: [research-topics-population]
status: active
session_active: true
workflow_completed: false
session_continued: true
continuation_date: '2026-05-19'
population_date: '2026-05-19'
source_session: '_bmad-output/brainstorming/brainstorming-session-2026-05-19-consolidated.md'
session_topic: 'Researching open topics from brainstorming session'
session_goals: 'Populate remaining research topics (R-02 through R-12) for implementation.'
pending_from_braindump:
  - status: open
    item: 'Prisma shards — Cat #14 Prisma Shard Composer (R-02)'
  - status: open
    item: 'k6 per-layer testing — Cat #17 k6 Perimeter Grid (R-03)'
  - status: open
    item: 'TanStack-first frontend — Cat #18 (R-04)'
  - status: open
    item: 'Utility/static class taxonomy — Cat #20 (R-05)'
  - status: open
    item: 'Promise-chain policy — T2 deferred, Cat #15 Promise Exception Registry (R-06)'
  - status: open
    item: 'Mirror docs layout + post-commit cartographer — Cat #3, #8, #9 (R-09)'
  - status: open
    item: 'Editorial pipeline automation — Cat #19 (R-10)'
  - status: open
    item: 'YOLO safety interlock + pre-flight quiz — Cat #2, #5, #6 (R-11)'
  - status: open
    item: 'Helper-vs-Writer dispatcher — Cat #22 (R-12)'
---

# Brainstorming Session — Research Topics Population

**Facilitator:** Prajwal  
**Date:** 2026-05-19  
**Purpose:** Populate open research topics from the 2026-05-19 consolidated brainstorming session for implementation.

---

## Part 1 — Research Topics Overview

| ID | Topic | Status | Priority | Research Questions |
|----|-------|--------|----------|-------------------|
| R-02 | Prisma multi-file schema + generator client | open | P1 | How to split schema.prisma into maintainable chunks? How does Prisma generator client work with this layout? |
| R-03 | k6 per-layer load/perf grid | open | P1 | What does k6 per-layer testing look like for frontend, backend, microservices? |
| R-04 | TanStack-first frontend scaffold gate | open | P1 | What modules to include? What are the minimum viable TanStack stack choices? |
| R-05 | Utility/static class taxonomy | open | P2 | When to use atomic helpers vs static class grouping for utils? |
| R-06 | Promise exception registry (T2) | open | P2 | When is `.then().catch()` acceptable vs async/await requirement? |
| R-09 | Mirror docs layout + post-commit cartographer | open | P1 | How does mirror docs integrate with git diff for incremental updates? |
| R-10 | Editorial pipeline automation | open | P2 | How to automate prose → structure → shard → index → distill? |
| R-11 | YOLO safety interlock + pre-flight quiz | open | P2 | What safety checks for YOLO mode? |
| R-12 | Helper-vs-Writer dispatcher | open | P2 | How to route tasks to Helper vs Writer skills? |

---

## Part 2 — Detailed Research Items

### R-02: Prisma multi-file schema shards

**Research questions:**
1. Prisma `schemaPath` option for splitting monolithic `schema.prisma`
2. Generator client configuration for multi-file schemas
3. Naming conventions for schema shards (models, relations, enums)

**Preliminary findings needed:**
- Prisma documentation on schema organization
- Example project with sharded schema
- Migration strategy from single to sharded schema

### R-03: k6 per-layer load/perf grid

**Research questions:**
1. k6 script organization for frontend (browser-level) vs backend (HTTP) vs microservices
2. Performance thresholds and metrics per layer
3. Script location conventions (`testing/load/{layer}/`)

**Preliminary findings needed:**
- k6 browser module for frontend testing
- API testing patterns for backend
- Service-to-service testing approaches

### R-04: TanStack-first frontend scaffold gate

**Research questions:**
1. Core TanStack modules: Query, Router, Table, Forms
2. Integration with Next.js App Router
3. State management split: TanStack Query vs Redux Toolkit

**Preliminary findings needed:**
- Minimum viable TanStack stack for new projects
- Scaffold checklist for TanStack-first projects

### R-05: Utility/static class taxonomy

**Research questions:**
1. When to use atomic helper functions vs static class grouping
2. Threshold for grouping (≥3 helpers for same domain)
3. Naming conventions for static utility classes

**Preliminary findings needed:**
- Example utility taxonomy structure
- Domain-based grouping rules

### R-06: Promise exception registry

**Research questions:**
1. When `.then().catch()` is acceptable (Node APIs with known types)
2. Exception handling patterns for async operations
3. ADR requirements for promise policy

**Preliminary findings needed:**
- Node.js APIs where `.then().catch()` is idiomatic
- Exception registry structure in documentation

### R-09: Mirror docs layout + post-commit cartographer

**Research questions:**
1. Git diff integration for incremental doc updates
2. Mirror docs structure synchronized with project structure
3. Post-commit update workflow

**Preliminary findings needed:**
- Git diff parsing patterns
- Mirror docs template structure
- Integration with bmad-dev-story

### R-10: Editorial pipeline automation

**Research questions:**
1. Automation flow: prose → structure → shard → index → distill
2. Trigger conditions for each pipeline stage
3. Integration with Helper skills (prose review, structure review)

**Preliminary findings needed:**
- Pipeline stage transitions
- Quality gates between stages

### R-11: YOLO safety interlock

**Research questions:**
1. Safety checks before destructive operations
2. Pre-flight quiz structure for YOLO mode
3. Override mechanisms

**Preliminary findings needed:**
- Safety interlock checklist
- Prompt patterns for pre-flight

### R-12: Helper-vs-Writer dispatcher

**Research questions:**
1. Criteria for Helper vs Writer routing
2. Task type classification
3. Integration with bmad-workspace-rules

**Preliminary findings needed:**
- Routing decision tree
- Task type definitions

---

## Part 3 — Next Actions

1. Research R-02: Prisma shards (begin with documentation review)
2. Research R-03: k6 per-layer testing patterns
3. Research R-04: TanStack module choices and scaffold checklist

**Session path:** `_bmad-output/brainstorming/brainstorming-session-2026-05-19-research-topics.md`