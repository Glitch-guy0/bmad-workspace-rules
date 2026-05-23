# Improvements — Carson Agent (bmad-cis-agent-brainstorming-coach)

---

## Improvement 1: Natural Language Intent Parsing

**Goal:** Agent should understand free-form user input, extract intent and steps, route without friction.

**Current state (SKILL.md Step 8):**
- Already has basic dispatch: if user message clearly maps to a menu item (`code` or fuzzy description), it skips the menu and dispatches directly
- Falls back to menu or free chat if no match

**Gap:**
- No structured intent extraction from multi-sentence user input
- No step decomposition — if user says "I want to brainstorm ideas for a SaaS app and then validate them", the agent only sees "brainstorm" and dispatches, losing the "validate" intent
- No fallback state tracking for partial matches

**Research context:**
- Method skills (bmad-brainstorming, bmad-cis-problem-solving, etc.) are single-intent workflows — each handles one thing
- The agent dispatches ONE skill at a time via menu selection
- To handle multi-step user requests, the agent needs to sequence multiple dispatches

---

## Improvement 2: Document Folder Awareness (`document_folder`)

**Goal:** Agent uses a custom folder name (`document_folder`) instead of `_bmad-output`, and is aware of the 4 allocated folders so it can inject/extract context for other agents.

**Current state:**
- Agent loads `output_folder` from `_bmad/cis/config.yaml` → `{project-root}/_bmad-output`
- Agent does NOT write any files itself (it's a dispatcher, not a method skill)
- The dispatched method skills write to `_bmad-output/brainstorming/`

**What the 4 allocated folders are (from the BMad ecosystem):**

| Folder | Purpose | Populated By |
|---|---|---|
| `_bmad-output/brainstorming/` | Brainstorming session outputs | `bmad-brainstorming` |
| `_bmad-output/research/` | Research findings | `bmad-market-research`, `bmad-domain-research` |
| `_bmad-output/planning-artifacts/` | PRDs, specs, architecture docs, project-context.md | `bmad-prd`, `bmad-create-architecture`, `bmad-generate-project-context` |
| `_bmad-output/implementation-artifacts/` | Epics, stories, sprint status | `bmad-create-epics-and-stories`, `bmad-sprint-planning` |

**Gap:**
- Agent is unaware of other folders' contents
- Can only load `project-context.md` via `persistent_facts` glob (`file:{project-root}/**/project-context.md`)
- Cannot read from `planning-artifacts/` or `implementation-artifacts/` to provide cross-context guidance
- No mechanism to tell dispatched skills about alternative output locations

---

## Research: How BMad Method Skills Work

### Sources

- Official docs: https://docs.bmad-method.org/ (AI-optimized full context: https://docs.bmad-method.org/llms-full.txt)
- CIS docs: https://cis-docs.bmad-method.org/
- GitHub: https://github.com/bmad-code-org/BMAD-METHOD
- Blog: https://vadim.blog/bmad-langfuse-claude-code-agent-teams
- Blog: https://medium.com/@hieutrantrung.it/the-complete-business-analysts-guide-to-bmad-method

### What BMad Method Skills Are

Structured instructional workflows that guide an AI agent through a predefined process (brainstorming, problem-solving, design thinking, storytelling, innovation strategy). Each lives in `.agents/skills/<name>/SKILL.md` and is:

- Self-contained with frontmatter (name, description, trigger phrases)
- Standardized activation sequence
- Customizable via 3-layer TOML overrides (no editing installed files)
- Produces output artifacts in `_bmad-output/`

### Common Activation Sequence (CIS method skills)

1. **Resolve Workflow Block** — `python3 {project-root}/_bmad/scripts/resolve_customization.py --skill {skill-root} --key workflow`
2. **Execute Prepend Steps** — `{workflow.activation_steps_prepend}`
3. **Load Persistent Facts** — literals + `file:`-prefixed paths/globs
4. **Load Config** — `{project-root}/_bmad/cis/config.yaml` → resolves `output_folder`, `user_name`, `communication_language`, `date`
5. **Greet the User**
6. **Execute Append Steps** — `{workflow.activation_steps_append}`
7. Begin the workflow body

### How `_bmad-output` Is Configured

```
_bmad/config.toml          → output_folder = "{project-root}/_bmad-output"
_bmad/cis/config.yaml      → output_folder: "{project-root}/_bmad-output"
_bmad/core/config.yaml     → output_folder: "{project-root}/_bmad-output"
_bmad/bmb/config.yaml      → output_folder: "{project-root}/_bmad-output"
```

All modules share the same `output_folder`. The variable is resolved at runtime by the agent from `config.yaml`.

### Per-Skill Default Output Paths

| Skill | Output File Pattern |
|---|---|
| `bmad-cis-problem-solving` | `{output_folder}/problem-solution-{date}.md` |
| `bmad-cis-design-thinking` | `{output_folder}/design-thinking-{date}.md` |
| `bmad-cis-storytelling` | `{output_folder}/story-{date}.md` |
| `bmad-cis-innovation-strategy` | `{output_folder}/innovation-strategy-{date}.md` |
| `bmad-brainstorming` | `{output_folder}/brainstorming/brainstorming-session-{date}-{time}.md` |

### Save Mechanism

After every `<template-output>` block in the workflow, the agent:
1. Fills template placeholders (`{{placeholder}}` from `template.md`)
2. Saves the full artifact to `default_output_file`
3. Shows checkpoint: `[a] Advanced Elicitation`, `[c] Continue`, `[p] Party-Mode`, `[y] YOLO`

### Method Skill Anatomy

Each method skill ships with:
- **`SKILL.md`** — activation + workflow with `<step>`, `<template-output>`, `<energy-checkpoint>`, `<action>` tags
- **`customize.toml`** — `[workflow]` surface: `activation_steps_prepend`, `activation_steps_append`, `persistent_facts`, `on_complete`
- **`template.md`** — output template with `{{placeholder}}` variables
- **`*-methods.csv`** — reference data (category, method_name, description, facilitation_prompts)

### Agent vs Method Skills

| Aspect | Agent Skills (Carson) | Method/Workflow Skills |
|---|---|---|
| Persona | Yes (named character) | No (facilitator role) |
| Menu | Presents menu, dispatches | No menu — runs steps |
| Output | None (dispatches) | Writes to `_bmad-output/` |
| Customization | `[agent]` in `customize.toml` | `[workflow]` in `customize.toml` |
| Template | No `template.md` | Has `template.md` |

### Subagent Pattern

Method skills are single-agent — they don't spawn subagents. Subagent spawning is limited to:
- `bmad-party-mode` (roundtable discussions)
- `bmad-distillator` (compressors)
- `bmad-eval-runner` (graders)
- `bmad-workflow-builder` / `bmad-agent-builder` (quality scanners)

Subagents CANNOT spawn other subagents.

### Three-Layer Customization Model

```
Priority 1 (wins): _bmad/custom/{skill-name}.user.toml  (personal, gitignored)
Priority 2:        _bmad/custom/{skill-name}.toml        (team/org, committed)
Priority 3 (last): skill's own customize.toml            (defaults)
```

Merge rules: scalars override, tables deep-merge, arrays-of-tables with `code`/`id` key merge, other arrays append.

### BMad Module Ecosystem

| Module | Config | Skills Include |
|---|---|---|
| **Core** | `_bmad/core/config.yaml` | bmad-help, bmad-brainstorming, bmad-shard-doc, bmad-index-docs, bmad-review-*, bmad-advanced-elicitation, bmad-distillator, bmad-party-mode, bmad-customize |
| **CIS** | `_bmad/cis/config.yaml` | bmad-cis-problem-solving, bmad-cis-design-thinking, bmad-cis-storytelling, bmad-cis-innovation-strategy, bmad-brainstorming, + 6 agent personas |
| **BMB** | `_bmad/bmb/config.yaml` | bmad-workflow-builder, bmad-agent-builder, bmad-module-builder, bmad-bmb-setup |

---

## Next Steps Plan

### Phase 1: Intent Parsing (Improvement 1)

**Goal:** Enable multi-intent understanding and step decomposition from free-form user input.

| # | Task | What | Files Affected |
|---|---|---|---|
| 1.1 | Add intent extraction logic | Before Step 8 (Dispatch), parse user message for multiple intents. Extract: primary intent (maps to menu), secondary intents (queue for after), context hints (topic, constraints). Store as session state. | SKILL.md |
| 1.2 | Add step decomposition | When user input contains sequenced intents (e.g. "brainstorm X then validate"), decompose into a queue. Execute first, then re-engage user for next. | SKILL.md |
| 1.3 | Add clarification prompts | For ambiguous or multi-match user input, generate a single clarifying question (not a full menu). E.g. "I see you want to brainstorm — are you looking for idea generation, problem solving, or both?" | SKILL.md |
| 1.4 | Add language-adaptive greeting | Use `communication_language` from config to adapt greeting and response style. Already loaded in Step 5 — ensure it's applied consistently. | SKILL.md (verify) |

### Phase 2: Document Folder Awareness (Improvement 2)

**Goal:** Replace `_bmad-output` with custom `document_folder`, add cross-folder awareness, enable injection/extraction.

| # | Task | What | Files Affected |
|---|---|---|---|
| 2.1 | Create team override | Create `_bmad/custom/bmad-cis-agent-brainstorming-coach.toml` with `activation_steps_prepend` that scans all 4 document folders on activation and loads their contents as context. | New file: `_bmad/custom/bmad-cis-agent-brainstorming-coach.toml` |
| 2.2 | Define `document_folder` concept | Add persistent facts describing the 4 folders and their purposes. The agent will know that `document_folder` maps to `{project-root}/_bmad-output` (or a custom path). | customize.toml (via override) |
| 2.3 | Add cross-folder scan | In `activation_steps_prepend`, list each folder and check for existing files. Load summaries into agent context. E.g.: "Scan planning-artifacts/ for PRDs, scan implementation-artifacts/ for sprint status." | Override TOML |
| 2.4 | Add injection capability | When dispatching to `bmad-brainstorming`, pass context extracted from other folders (e.g., "the user's PRD mentions this feature — reference it during brainstorming"). Use `data` attribute on skill invocation. | SKILL.md (customize injection strategy) |
| 2.5 | Route output awareness | When method skills ask where to save, answer `{document_folder}/brainstorming/...` instead of default. For dispatched skills, their own `customize.toml` overrides can set output paths. | SKILL.md (instruction to override per-skill output) |
| 2.6 | Update activation Step 5 | After loading config, also resolve `document_folder` — either by reading a custom config key or by defining it as `{output_folder}` mapped to a custom name. | SKILL.md |

### Phase 3: Integration

| # | Task | What | Files Affected |
|---|---|---|---|
| 3.1 | Create test scenario | Define test inputs and expected behaviors: single intent ("let's brainstorm"), multi-intent ("brainstorm and then validate"), ambiguous ("I need ideas"), context-rich ("we're working on a SaaS billing feature, brainstorm pricing models"). | milestones.md (document) |
| 3.2 | Wire up folder injection | When agent dispatches `bmad-brainstorming`, inject relevant context from `planning-artifacts/` or `project-context.md` as the `data` attribute. The brainstorm method skill's Step 1 already supports loading context from `data`. | SKILL.md |
| 3.3 | Verify with dry run | Manually invoke the updated agent, go through each scenario, verify intents are parsed correctly and folder contents are loaded as expected. | Manual test |
| 3.4 | Document in AGENTS.md | Write up how the agent handles multi-intent input and document folder management for other developers. | `AGENTS.md` (if exists) |

### Implementation Approach for Folder Management

The preferred approach for Improvement 2 is a **team override file** (`_bmad/custom/bmad-cis-agent-brainstorming-coach.toml`) because:

1. **Survives updates** — the base `customize.toml` and SKILL.md can be regenerated; overrides persist
2. **No forking needed** — follows the BMad 3-layer customization model
3. **Incremental** — start with `persistent_facts` for folder definitions, add `activation_steps_prepend` for scan logic later

The `document_folder` concept should be added as a persistent fact rather than a config key change, because:
- `_bmad/config.toml` and `_bmad/cis/config.yaml` are installer-managed (overwritten on reinstall)
- Custom config goes in `_bmad/custom/config.toml` (but only covers central roster, not per-skill)
- Per-skill custom values belong in the per-skill override TOML as `persistent_facts`
