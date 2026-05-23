---
name: agent-registry
description: Scan .agents/skills/ and recommend the right agent for the job
code: AR
---

# Agent Registry

Agent discovery: `{project-root}/.agents/skills/` (installed skills with SKILL.md frontmatter) + `{project-root}/_bmad/custom/config.toml` (registered agents).

## What Success Looks Like
When the owner asks "who should handle this?" or a phase gate requires agent invocation, Archiver knows exactly which agents exist, what they do, and when to recommend them. The owner never has to remember which agent does what.

## Registry Source

Read agent information from:
1. `{project-root}/_bmad/custom/config.toml` — look for `[agents.<code>]` sections with name, title, description
2. `{project-root}/.agents/skills/` — scan for installed skills, read their SKILL.md frontmatter for name/description
3. `{skill-root}/customize.toml` metadata block for registered agents

## Agent Discovery

For each discovered agent, track:
- **Code** — stable identifier
- **Name** — display name (may be empty for First-Breath-named agents)
- **Title** — role title
- **Description** — what it does
- **SKILL.md path** — where to find its instructions

## When to Recommend

### By Q1-Q10 Phase

| Situation | Recommendation |
|-----------|---------------|
| Q1 idea ready for validation | "Ready for Product Agent to explore validity." |
| Q3 milestone structured, needs stress test | "Requirements have AC — invoke the Product Agent for stress testing." |
| Q5 milestone signed off, needs dev work | "DTO 1 dispatched — invoke the Developer Agent for technical design." |
| Q6 dev planning complete, needs Gate 2 review | "TDD and ADRs ready — technical design review needed." |
| Q8 implementation planning complete | "Vertical slices planned — Developer Agent can begin implementation." |
| Q10 implementation done, needs report | "Ask the Developer Agent to generate the Implementation Report." |
| Report received, needs product doc update | "The report is in — invoke the Product Agent to update docs." |

### By Decision Record Type

| Situation | Recommendation |
|-----------|---------------|
| Strategic question (market, competition) | "This needs an SDR — strategic level." |
| Product question (user behavior, scope) | "This needs a PDR — product level." |
| Technical question (architecture, trade-offs) | "This needs an ADR — technical level." |

### By NFR / Tech Debt

| Situation | Recommendation |
|-----------|---------------|
| NFR proposed → needs review | "NFR proposal ready for PM review." |
| Tech debt accepted → needs ADR | "Tech debt accepted — file an ADR documenting the trade-off." |

## Registration Format for Config

When writing agent info to config or suggesting installation, use this format:

```toml
[agents.<code>]
name = "<name or ''>"
title = "<role title>"
icon = "<emoji>"
description = "<one-sentence summary>"
```

## Memory Integration
Cache the agent registry in MEMORY.md so you can answer quickly. During Pulse, re-scan `.agents/skills/` for changes.

## After the Session
Note any agent recommendations made and whether the owner acted on them. Update the cached registry if agents were added or removed.
