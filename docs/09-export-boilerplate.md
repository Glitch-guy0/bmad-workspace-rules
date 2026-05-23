# Export Boilerplate — `src/` Structure

The `src/` directory is the **export folder** — built agents, templates, scripts, and rules ready for distribution. This document defines the abstract layout and conventions.

## Structure

```
src/
├── SKILL.md                       # Module index — entry point, agent registry
├── customize.toml                 # Module-level customization overrides
├── agents/
│   ├── agent-archiver/            # Built agent (see src/ for reference)
│   │   ├── SKILL.md               # Agent bootloader (identity seed, Three Laws, routing)
│   │   ├── customize.toml         # Agent-level customization metadata
│   │   ├── references/            # Capability prompts (init, workflow-state, template-forge, index-keeper, phase-gate, agent-registry), first-breath, memory guidance
│   │   ├── assets/                # Sanctum templates (PERSONA, CREED, BOND, etc.)
│   │   └── scripts/               # Init script, deterministic operations
│   └── [agent-name]/              # Convention for adding new agents
│       ├── SKILL.md
│       ├── customize.toml
│       ├── references/
│       ├── assets/
│       └── scripts/
├── templates/                     # Artifact templates for documentation generation
│   ├── _index.md
│   ├── idea.md
│   ├── milestone.md
│   ├── adr.md
│   ├── report.md
│   ├── stress-test.md
│   ├── tdd.md
│   ├── api-contract.md
│   └── [template-name].md
├── scripts/                       # Executable operations (bash by convention)
│   ├── init-sanctum.py            # First Breath — deterministic sanctum scaffolding
│   ├── scan-doc-map.sh            # Check folder indexes for drift
│   ├── validate-frontmatter.sh    # Validate YAML frontmatter across all docs
│   ├── merge-config.py            # Merge module config into _bmad/config.yaml
│   ├── merge-help-csv.py          # Merge help entries into _bmad/module-help.csv
│   └── [script-name].sh
└── structured_rules.csv           # If-then rule table governing agent behavior
```

## Conventions

### `SKILL.md` (module index)
- Serves as entry point — describes what agents are available and when to invoke each
- Frontmatter: `name` (kebab-case), `description` (use-when format)
- Body: agent registry table with code, name, title, description for each built agent

### `customize.toml`
- Module-level base configuration (`[agent]` blocks for each agent)
- Individual agents ship their own `customize.toml` alongside their `SKILL.md`
- Merge order: module → team → user overrides

### `agents/`
- One folder per agent, named `agent-{name}/`
- Each agent is self-contained (SKILL.md + references + assets + scripts)
- Agent types: stateless (full identity in SKILL.md) or memory/autonomous (lean bootloader + sanctum)

### `templates/`
- One file per artifact type
- All templates include YAML frontmatter and progressive disclosure layers (Layer 1-4)
- `_index.md` template for folder navigation files

### `scripts/`
- Bash scripts for deterministic operations (validation, scanning, generation)
- Must include usage comment block and error handling
- Executable (`chmod +x`)

### `structured_rules.csv`
- Columns: `trigger_type`, `trigger_condition`, `action`, `target_path`, `notes`
- Governs phase transitions and agent invocations without changing prompts

## Adding a New Agent

1. Create `agents/[agent-name]/` with `SKILL.md`, `customize.toml`
2. Add capability prompts to `references/` (one per capability, outcome-focused)
3. If memory/autonomous: add sanctum templates to `assets/` and init script to `scripts/`
4. If deterministic ops needed: add bash scripts to `scripts/`
5. Register agent in `src/SKILL.md` module index table
6. Register agent in `src/customize.toml` metadata block
7. Add phase-transition rules to `structured_rules.csv` if applicable
