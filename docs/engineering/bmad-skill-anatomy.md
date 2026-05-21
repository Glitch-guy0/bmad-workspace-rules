---
title: BMad Skill Anatomy
status: published
source: _bmad-output/research/R-01-bmad-skill-anatomy.md
---

# BMad Skill Anatomy

A practical guide to skill structure for workspace skill authors.

## Skill Families

| Family | Activation | Example | Layout |
|--------|------------|---------|--------|
| **Workflow** | Thin SKILL.md → workflow.md | `bmad-brainstorming` | `workflow.md`, `steps/*.md`, `assets/` |
| **Agent (persona)** | Resolver → persona → menu | `bmad-cis-agent-brainstorming-coach` | `SKILL.md`, `customize.toml` |
| **Multi-agent** | Orchestrator + `agents/*.md` | `bmad-distillator` | `agents/`, `resources/`, `scripts/` |
| **Builder/meta** | Long SKILL.md + `references/` + `scripts/` | `bmad-workflow-builder` | Quality scans, templates in `assets/` |

## Directory Structure

| Layer | Purpose | When to use |
|-------|---------|-------------|
| `SKILL.md` | Entry: name, description, activation, routing | Always; keep thin if workflow is large |
| `workflow.md` | Multi-step orchestration separate from entry | Workflow has many stages and shared preamble |
| `steps/*.md` | Sequential micro-steps with embedded rules | Steps independently loaded; brainstorming pattern |
| `references/` | Carved prompts; standalone-readable | SKILL.md would exceed context; each file standalone |
| `assets/` | Templates, CSV, static inputs | Content is copied or filled, not executed |
| `scripts/` | Deterministic ops (tests, scans, analysis) | Wrong answer has a cost; exact invocation required |
| `agents/` | Subagent prompts for parallel/serial sub-runs | Parent skill spawns focused sub-tasks |
| `customize.toml` | Team overrides: activation, paths, persistent_facts | Skill is installed and team needs config without editing SKILL.md |

## Frontmatter (Required)

```yaml
---
name: skill-name
description: [5-8 word summary]. [Use when user says 'phrase' or 'phrase'.]
---
```

## Description Format

- `[5-8 word summary].` + `[Use when user says 'specific phrase' or 'specific phrase'.]`
- Quote trigger phrases
- Conservative (explicit) triggering is default

## Naming

- Folder name = skill `name` (kebab-case)
- Official BMad: `bmad-{name}` prefix reserved
- Module skills: `{modulecode}-{name}` (e.g. `cis-brainstorm`)

## Path Conventions

```
## Conventions
- Bare paths resolve from skill root.
- `{skill-root}` → skill install directory (where customize.toml lives).
- `{project-root}` → project working directory.
- `{skill-name}` → skill directory basename.
```

## Quality Bar

- Every line must pass: *would an LLM do this correctly without being told?*
- Outcome-based instructions over numbered trivia steps
- Exact steps only for fragile ops (scripts, APIs, security)

## When to Choose Architecture

| Situation | Pattern |
|-----------|---------|
| < ~200 lines, few stages | Inline everything in `SKILL.md` |
| Many sequential stages, user checkpoints | `workflow.md` + `steps/` |
| Large skill, sections independently useful | `references/` carve-out |
| Validation, scanning, metrics | `scripts/` with tests |
| Persona + menu of child skills | Agent skill + `customize.toml` |
| Cross-session artifact with resume | Decision-log workspace |

## Helper vs Writer (Project Registry)

| Family | Role | Skills |
|--------|------|--------|
| **Helper** | Refine/compress project docs | prose → structure → shard → index → distill |
| **Writer** | Create/maintain technical docs | tech-writer, document-project, generate-project-context |

## References

- `.agents/skills/bmad-workflow-builder/references/skill-quality-principles.md`
- `.agents/skills/bmad-workflow-builder/references/standard-fields.md`
- `.agents/skills/bmad-workflow-builder/references/complex-workflow-patterns.md`