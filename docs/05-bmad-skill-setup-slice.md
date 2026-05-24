# BMAD Skill Architecture & Operations Reference

## The BMAD Skill

Workflow tooling lives inside the bmad-method official skills folder as one large skill. Not a separate repo.

### What a Skill Can Contain

- **Sub-agents**: personal agents each focused on one responsibility, with own instructions and scope
- **Steps**: ordered instructions for a process, followed exactly by the agent
- **Scripts**: executable logic (file generation, validation checks, sync ops)
- **Tracking CSVs**: if-then rule tables governing agent behavior without hardcoding into prompts
- **Templates**: pre-filled markdown files for every document type, including full header block

### Skill Internal Structure

```
bmad-method/skills/product-workflow/
  SKILL.md — entry point, when to invoke, which sub-agent for which task
  agents/
    planning-agent.md — product planning (ideas → milestones → PDRs → stress test)
    validation-agent.md — milestone validation and VALIDATE op (checks AC, open questions, sign-off gate)
    sync-agent.md — SYNC: keeps planning and implementation in sync bidirectionally
    handoff-agent.md — manages DTO transfers between repos (confirmed files, reports, NFR proposals)
  steps/
    init-steps.md — full ordered steps for INIT operation
    milestone-steps.md — idea through to confirmed
    sync-steps.md — full ordered steps for SYNC operation
    validate-steps.md — full ordered steps for VALIDATE operation
  scripts/
    generate-structure.md — instructions for creating full folder tree with placeholder files from templates
    validate-milestone.md — checklist runner (pass/fail per item)
    sync-decisions.md — decision sync logic both directions
    update-indexes.md — scan all folders, rebuild _index.md files
  tracking/
    workflow-rules.csv — if/then rules table governing agent behavior
  templates/ (20 templates)
    _index.md, idea.md, milestone.md, requirement.md, nfr.md, nfr-proposal.md, pdr.md, product-research.md, sdr.md, directive.md, stress-test-session.md, milestone-confirmed.md, tech-debt-accepted.md, tech-debt-postponed.md, tdd.md, adr.md, api-contract.md, spike.md, vertical-slice.md, atomic-change-plan.md, test-scenarios.md, progress.md, implementation-report.md
```

## Four Operations

### INIT

- **When:** First-time setup of new product. **Who runs:** User invokes skill once
- **Does:** (1) Asks 4 product brief questions. (2) Generates full planning/ folder tree with prefilled placeholders. (3) Asks submodule or single repo. (4) Creates implementation/ connection. (5) Writes .planning-config.md at root. (6) Outputs checklist of what was created + first suggested action

#### Step by Step

1. User creates one repo: [product-name]-planning (planning repo by default, no implementation code)
2. User invokes product-workflow skill: INIT → agent reads init-steps.md
3. Agent asks 4 questions: product name, one-sentence what it does, primary user, do you have a codebase yet?
4. Agent generates full planning folder tree. Every folder gets prefilled _index.md. Key files created with placeholder content: product-brief.md (prefilled with answers), evolution-timeline.md, current-state-map.md, direction.md, feature-index/_index.md, ideas/_index.md, milestones/_index.md, strategy/directives/_index.md, strategy/sdrs/_index.md, dto/incoming/_index.md, dto/outgoing/_index.md
5. Agent asks: How to connect implementation codebase? Option A (Submodule) or Option B (Git Workflow single repo)
6. Both options result in same logical layout: planning/ and implementation/ at same level

#### Two Repo Options

| | Option A — Submodule | Option B — Git Workflow |
|---|---|---|
| **Choose when** | Teams need separate access control | Solo developer or small team |
| **Structure** | [product-name]-planning/ (git repo) with planning/ + implementation/ (git submodule) | [product-name]/ (single git repo) with planning/ + implementation/ |
| **INIT creates** | .gitmodules, implementation/ mount point | planning/, implementation/, implementation/dev-planning/, .planning-config.md |

#### End State (logical layout, both options)

| Domain | Contents |
|--------|----------|
| `planning/` | strategy/ (directives/SDRs/research), product/ (brief/timeline/state), ideas/, milestones/ (active/confirmed/completed), feature-index/, nfr-proposals/, dto/, reports/ |
| `implementation/` | source code + dev-planning/ (planning/TDDs/ADRs/spikes/contracts/slices), tech-debt/, nfr-proposals/, dto/, reports/ |

### VALIDATE

- **When:** Before any milestone is confirmed. **Who runs:** Planning agent (automated) + human sign-off
- **Does:** (1) Checks all requirements have AC. (2) Checks all PDRs in accepted state. (3) Checks all stress test sessions have zero open items. (4) Checks all open questions in milestone resolved. (5) Checks scope complete (no TBD in Must Have items). (6) Outputs pass/fail report per check — blocks confirmation if any fail

### SYNC

- **When:** After milestone ships, after any ADR/PDR filed, or manual invocation. **Who runs:** Sync agent
- **Does:** (1) Scans both repos for new decisions since last sync. (2) Pushes ADRs and infra decisions → planning/decisions/. (3) Pushes PDRs and directives → implementation/dev-planning/context/. (4) Rebuilds all _index.md files. (5) Validates all file headers. (6) Updates evolution-timeline.md and current-state-map.md if affected. (7) Writes sync-report.md with issues. (8) Updates last-sync timestamp

#### The Decisions Registry

Reference copies of decisions synced across repos, not source of truth. Source stays in the repo that filed it:

- **planning/decisions/** (receives from implementation): `_index.md` (all synced decisions, dated, categorized), `arch-[slug].md` (reference copy of ADR from dev side)
- **implementation/dev-planning/context/** (receives from planning): `_index.md`, `pdr-[slug].md` (reference copy of PDR)
- Each reference copy carries: slug, type=decision-reference, source path, synced date, summary from receiving team's perspective, impact on this side

### UPDATE

- **When:** Skill invoked against an existing repository with user requirements ready. **Who runs:** User-invoked skill
- **Does:** (1) Divides the whole repo into sections. (2) Creates `_repo-update-task-list.md` with all required context. (3) Prompts user that sections are allocated and ready. (4) After implementing each section, prompts user to commit changes and rerun in a new session. (5) After completion, prompts user to approve deletion of `_repo-update-task-list.md`. (6) On subsequent invocations, checks `_repo-update-task-list.md` to determine if this is a repo-update session

### workflow-rules.csv

Governs agent behavior across all four operations. Agents read the CSV before acting. New rules added without changing agent prompts.

**Format:** `trigger_type`, `trigger_condition`, `action`, `target_path`, `notes`

**Rules:**
- `idea.status=validated` → create `milestones/active/[slug]/milestone.md`
- `milestone.status=confirmed` → create `dto/outgoing/[slug]-confirmed.md` + create `sign-off-log.md`
- `file_received dto/incoming/[slug]-confirmed.md` → scaffold planning folder
- `file_received dto/incoming/[slug]-report.md` → run sync-agent
- `ADR filed` → sync to `planning/decisions/arch-[slug].md`
- `PDR filed` → sync to `implementation/context/pdr-[slug].md`
- `stress_test session.open_items > 0` → block milestone confirmation
- `vertical_slice vs.status=planned AND next_vs_depends=false` → allow ahead planning

## Skill Anatomy Reference

### Skill Families

| Family | Pattern | Use Case |
|--------|---------|----------|
| Workflow | Thin SKILL.md → workflow.md | Single linear process |
| Agent | Resolver → persona → menu | Interactive agent with choices |
| Multi-agent | Orchestrator + agents/*.md | Multiple sub-agents |
| Builder/meta | Long SKILL.md + references/ + scripts/ | Complex tooling with sub-capabilities |

### Layer Responsibilities

| Layer | Role | Required? |
|-------|------|-----------|
| SKILL.md | Entry point, routing | Always |
| workflow.md | Multi-step orchestration | For complex flows |
| steps/\*.md | Sequential micro-steps | When workflow needs detail |
| references/ | Carved prompts | Large skills with independent sections |
| assets/ | Templates, CSVs | Static data bundled with skill |
| scripts/ | Deterministic ops | Validation, scanning, generation |
| agents/ | Subagent prompts | Multi-agent skills |
| customize.toml | Team overrides | Optional metadata |

### Quality Bar
- "Would an LLM do this correctly without being told?"
- Outcome-based instructions over numbered trivia

### Path Conventions
- Bare paths resolve from skill root
- `{skill-root}` → skill install directory
- `{project-root}` → project working directory
- `{skill-name}` → skill directory basename

### Editorial Pipeline Automation
- Chain: prose review → structure review → shard (conditional >500 lines) → index → distill (optional)
- Prose review: auto after braindump or bulk edit; Structure review: auto after prose pass; Shard: conditional; Index: auto per folder; Distill: optional (brainstorm/compression only)
- Config: editorial_pipeline_enabled, auto_shard_threshold (500), dry_run_mode

### Helper-vs-Writer Skill Dispatcher
- Unstructured notes → Helper chain
- Compress brainstorm → Helper (distillator)
- New API/module tech doc → Writer
- Unknown brownfield → Writer (generate-project-context)
- Post-implementation → workspace rules
- Architecture deviation → ADR

### bmad-workspace-rules Skill (R-07)
- Package: `.agents/skills/bmad-workspace-rules/` — SKILL.md + customize.toml + references/ + assets/
- Family: Complex workflow skill with optional customize.toml hooks
- Activation: bmad-dev-story → bmad-workspace-rules (prepend hook) → resolve customize.toml → load constitution → git diff HEAD~1 → route to mode → deviation check → ADR if needed
- Config keys: constitution_path, research_index_path, docs_output_path, adr_path, mode (initial-setup|post-commit|re-baseline|surgical-strike), max_files_per_session, yolo_defaults_enabled

## Vertical Slice Plan

Required for every milestone in dev repo before full implementation begins. Enforced — not optional.

### Definition

- A vertical slice = thinnest complete cut through all system layers proving design works and validating TDD in reality. NOT horizontal (all UI first, then API, then DB)
- One specific user action, fully working end-to-end: UI → API → DB → response. Minimum viable implementation of one path. Proves architecture holds before committing to full build

### One Milestone, Multiple Slices

- Each requirement or group of related requirements → one vertical slice. All slices planned and ordered before implementation starts
- Example (Bulk Export): VS-1: User requests CSV export → job queued → confirmation shown. VS-2: Job processes → file generated → user notified. VS-3: User downloads → file valid → job marked complete

### Ahead Planning

- If Slice N+1 depends only on Slice N validated design (not its code) → VS-2 planning begins in parallel with VS-1 implementation
- If VS-2 depends on VS-1 actual running code → VS-2 planning waits until VS-1 implemented and verified
- Combining slices permitted if small and tightly coupled — declared explicitly in plan

### Vertical Slice Plan File

- Frontmatter: `slug=vs-[n]-[milestone-slug]`, `type=vertical-slice`, `status` (planned/in-progress/validated/implemented/combined), owner, created/updated, upstream, downstream
- Body: Milestone slug, Slice number (VS-[n] of [total]), Combined with (VS-[n] or —), Ahead planning (Enabled/Blocked), What this slice proves (specific design question/risk), User action covered (one specific action start to finish), Layers touched (UI/API/DB/Other — minimum viable per layer), Thin implementation plan (what is built/what is stubbed/what is deferred), Validation gate (specific checks for done), Next slice dependency (VS-[n+1] needs this: Implemented/Validated-only/Independent), Combination note (if combined: which VS + reason)

### File Location

- `implementation/dev-planning/planning/[milestone-slug]/vertical-slices/` (`_index.md` listing all slices with status/ahead-plan/combined/file, `vs-1-[name].md`, `vs-2-[name].md`, `vs-3-[name].md`)
- `atomic-change-plan.md` generated AFTER slices are planned. Test scenarios generated after slices

### Full Implementation Sequence With Slices

- Milestone Confirmation received → TDD written → All vertical slices planned and ordered → VS-1 implementation → validated → (if VS-2 ahead-plan allowed: VS-2 planning in parallel) → VS-2 implementation → validated → (VS-3 planning if not done) → VS-3 implementation → validated → All slices done → atomic-change-plan reviewed → full test suite → Implementation Report generated
