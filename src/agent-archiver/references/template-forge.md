---
name: template-forge
description: Generate properly formatted documentation artifacts on demand
code: TF
---

# Template Forge

Conventions reference: `references/workspace-rules.md` — naming, frontmatter, progressive disclosure, artifact paths and formats.

## What Success Looks Like
The owner says "I need a milestone doc for X" (or an ADR, or a stress test session, or a report) and you generate a properly structured artifact with the right frontmatter, progressive disclosure layers, cross-references, and status indicators. The owner fills in details — they don't fix the format.

## Standard Artifact Templates

### Idea Capture
```markdown
---
type: idea
status: draft
slug: [kebab-case-slug]
created: YYYY-MM-DD
owner: user
---

# [Title]

**One-liner:** [Layer 1 — what this is in one sentence]

**Summary:** [Layer 2 — a few sentences on what's being proposed]

**Details:** [Layer 3 — what needs to be explored, known constraints]
```

### Milestone
```markdown
---
type: milestone
status: active
slug: [kebab-case-slug]
created: YYYY-MM-DD
owner: user
---

# [Title]

**Layer 1:** One sentence on what this milestone delivers.

**Layer 2:** Summary of scope, why it matters, success criteria.

## Requirements

### [REQ-001] [Title]
**Description:** What this requirement means.
**Success:** How we know it's done.
**Edge cases:** [optional]
```
(Full template includes all progressive disclosure layers)

### ADR
```markdown
---
type: adr
status: proposed
number: ADR-[NNN]
title: [Title]
date: YYYY-MM-DD
---

# ADR-[NNN]: [Title]

**Status:** [Proposed | Accepted | Superseded]

**Context:** What prompted this decision.

**Decision:** What we decided.

**Consequences:** What this means for the project.
```

### Implementation Report
```markdown
---
type: report
status: draft
slug: [milestone-slug]-report
date: YYYY-MM-DD
---

# Implementation Report: [Milestone]

**Status:** [Complete / Partial / Blocked]

**What shipped:**
- ✅ [Requirement] — what was delivered

**Deviations:** [if any]

**New decisions:** ADR-[NNN] — [Title]
```

### Stress Test Session
```markdown
---
type: stress-test
status: complete
slug: [milestone-slug]-stress-test-[date]
date: YYYY-MM-DD
---

# Stress Test: [Milestone]

**Requirements reviewed:** [list]

**Findings:**
| Requirement | Issue | Resolution | AC Updated |
|---|---|---|---|

**Open items:** [owner, must resolve before sign-off]
```

## On Request
When the owner says "generate a template for [type]":

1. Confirm the slug and context
2. Generate the template with Layer 1-4 structure pre-filled
3. Add cross-references to related docs if they exist
4. Write it to the correct path per workspace conventions (`references/workspace-rules.md` — Artifact Types and Paths table)
5. Update the state tracker

## Memory Integration
Check if a similar artifact already exists. Offer to reference it rather than duplicate. Check BOND.md for any formatting preferences the owner has expressed.

## After the Session
Note in the session log what templates were generated and for what items. Update Workflow State if phases changed.
