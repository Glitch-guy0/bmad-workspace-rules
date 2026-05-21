---
id: R-01
status: closed
priority: P0
brainstorm_ref: 'Part 2 R-01'
blocks: [R-07, R-12]
---

# R-01 — How BMad-method skills are structured

## Goal

Document skill anatomy so `bmad-workspace-rules` and future custom skills follow BMad conventions without re-reading the entire installed skill tree.

## Research questions

| # | Question | Status |
|---|----------|--------|
| 1 | What belongs in `SKILL.md` vs `references/` vs `assets/` vs `scripts/`? | answered |
| 2 | How do workflow skills differ from agent (persona) skills? | answered |
| 3 | Required frontmatter and description format? | answered |
| 4 | How does `customize.toml` integrate with activation? | answered |
| 5 | When to use `steps/` micro-files vs inline vs `references/` carve-out? | answered |

## Findings

### Skill families (this project)

| Family | Activation pattern | Example | Typical layout |
|--------|-------------------|---------|----------------|
| **Workflow** | Thin `SKILL.md` → `workflow.md` or inline stages | `bmad-brainstorming` | `workflow.md`, `steps/*.md`, `assets/`, `template.md` |
| **Agent (persona)** | Resolver → persona → menu → dispatch child skills | `bmad-cis-agent-brainstorming-coach` | `SKILL.md`, `customize.toml`, optional `references/` |
| **Multi-agent workflow** | Orchestrator + `agents/*.md` sub-prompts | `bmad-distillator` | `agents/`, `resources/`, `scripts/` |
| **Builder / meta** | Long SKILL.md + heavy `references/` + `scripts/` | `bmad-workflow-builder` | Quality scans, templates in `assets/` |

### Directory comparison (installed skills)

**Workflow — `bmad-brainstorming`**

```
bmad-brainstorming/
├── SKILL.md              # 6 lines: frontmatter + "Follow workflow.md"
├── workflow.md           # Orchestration, conventions, stage routing
├── steps/                # One file per step (micro-file architecture)
├── template.md           # Output document template
└── brain-methods.csv     # Static data (assets pattern)
```

**Agent — `bmad-cis-agent-brainstorming-coach`**

```
bmad-cis-agent-brainstorming-coach/
├── SKILL.md              # Persona, activation via resolve_customization.py --key agent
└── customize.toml        # role, menu, persistent_facts, prepend/append steps
```

**Multi-agent — `bmad-distillator`**

```
bmad-distillator/
├── SKILL.md
├── agents/               # Subagent prompts (compressor, reconstructor)
├── resources/            # Format rules, splitting strategy
└── scripts/              # Deterministic analyze_sources.py + tests
```

### Layer responsibilities

| Layer | Purpose | Put here when… |
|-------|---------|----------------|
| `SKILL.md` | Entry: `name`, `description`, activation, routing | Always; keep thin if workflow is large |
| `workflow.md` | Multi-step orchestration separate from entry | Workflow has many stages and shared preamble |
| `steps/*.md` | Sequential micro-steps with embedded rules | Steps are independently loaded; brainstorming pattern |
| `references/` | Carved prompts readable without SKILL.md | SKILL.md would exceed context; each file standalone |
| `assets/` | Templates, CSV, static inputs | Content is copied or filled, not executed |
| `scripts/` | Deterministic ops (tests, scans, analysis) | Wrong answer has a cost; exact invocation required |
| `agents/` | Subagent prompts for parallel/serial sub-runs | Parent skill spawns focused sub-tasks |
| `customize.toml` | Team overrides: activation, paths, persistent_facts | Skill is installed and team needs config without editing SKILL.md |

### Frontmatter (required)

From `bmad-workflow-builder/references/standard-fields.md`:

- `name` — kebab-case, equals folder name
- `description` — `[5–8 word summary]. [Use when user says 'phrase' or 'phrase'.]` — quote trigger phrases

### Description and naming

- Official BMad skills: `bmad-{name}` prefix reserved
- Module skills: `{modulecode}-{name}` (e.g. `cis-brainstorm`)
- Conservative triggering: explicit user phrases in description

### Path conventions (stamp in SKILL.md when referencing internal files)

```
## Conventions
- Bare paths resolve from skill root.
- `{skill-root}` → skill install directory (where customize.toml lives).
- `{project-root}` → project working directory.
- `{skill-name}` → skill directory basename.
```

### Quality bar (`skill-quality-principles.md`)

- Every line must pass: *would an LLM do this correctly without being told?*
- Outcome-based instructions over numbered trivia
- Exact steps only for fragile ops (scripts, APIs, security, resolver invocation)

### When to choose architecture

| Situation | Pattern |
|-----------|---------|
| &lt; ~200 lines, few stages | Inline everything in `SKILL.md` |
| Many sequential stages, user checkpoints | `workflow.md` + `steps/` (brainstorming) |
| Large skill, sections independently useful | `references/` carve-out |
| Validation, scanning, metrics | `scripts/` with tests co-located |
| Persona + menu of child skills | Agent skill + `customize.toml` |
| Cross-session artifact with resume | Decision-log workspace (see `complex-workflow-patterns.md`) |

### Helper vs Writer (project registry)

| Family | Role | Skills |
|--------|------|--------|
| Helper | Refine/compress project docs | prose → structure → shard → index → distill |
| Writer | Create/maintain technical docs | tech-writer, document-project, generate-project-context |

## Recommended outputs

- [ ] Publish `docs/engineering/bmad-skill-anatomy.md` (distilled from this brief)
- [ ] Use structure decisions when scaffolding R-07 `bmad-workspace-rules`

## Next steps

- [x] Compare workflow vs agent directory trees
- [x] Read `skill-quality-principles.md` and `standard-fields.md`
- [ ] Read `complex-workflow-patterns.md` for decision-log pattern (R-09 dependency)
- [ ] Draft `docs/engineering/bmad-skill-anatomy.md` for workspace authors

## References

- `.agents/skills/bmad-workflow-builder/references/skill-quality-principles.md`
- `.agents/skills/bmad-workflow-builder/references/standard-fields.md`
- `.agents/skills/bmad-workflow-builder/references/complex-workflow-patterns.md`
- Consolidated brainstorm Appendix B — skills registry
