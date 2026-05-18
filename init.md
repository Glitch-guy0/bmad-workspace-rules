# bmad-workspace-rules — Project Init

> **What this is:** A one-time setup prompt. Run this with `bmad-customize` to configure `bmad-workspace-rules` for your project.
> After this init, the skill will automatically maintain your project documentation after every `bmad-dev-story` implementation run.

---

## How to Run

Paste the prompt below directly into your AI agent (with `bmad-customize` active):

---

## Init Prompt (copy & run)

```
@bmad-customize

I want to set up the `bmad-workspace-rules` skill for my project. 
Please help me configure it with the following setup:

## 1. Project Constitution
I have a workflow documentation file that defines my project's architecture standards.
- Path to my standards file: [FILL IN — e.g. `./_bmad-output/brainstorming/brainstorming-session-2026-05-19-consolidated.md` (Appendix A)]
- This file is the source of truth for how my project should be structured.
- The skill must treat it as read-only — never overwrite it.

## 2. Project Type
My project is: [CHOOSE ONE]
- [ ] Greenfield (brand new — no existing code)
- [ ] Existing structured project (follows a known architecture)
- [ ] Existing messy project (needs structure assessment first)

## 3. Language / Stack
Primary stack: [FILL IN — e.g. `TypeScript`, `NestJS backend`, `Next.js frontend`]

## 4. Documentation Output Location
Where should mirror docs be written?
- Docs folder: [FILL IN — e.g. `./docs/`]
- ADR (Architecture Decision Records) folder: [FILL IN — e.g. `./docs/decisions/`]

## 5. Integration Mode
This skill will be triggered automatically after `bmad-dev-story` implementation runs.
- It should read `git diff HEAD~1` to detect changed files.
- It should only update documentation for files that changed in the last commit.
- It should surface a coverage report showing undocumented files.

Please create a team-scoped override (`bmad-workspace-rules.toml`) under `_bmad/custom/` 
with these settings and verify the merged config before finishing.
```

---

## What Happens After Init

Once configured, the workflow is:

```
Developer implements a story via bmad-dev-story
        ↓
bmad-dev-story implementation phase completes
        ↓
bmad-workspace-rules triggers automatically
        ↓
Reads git diff HEAD~1 → identifies changed files
        ↓
Updates mirror docs for changed files only
        ↓
Surfaces coverage report (documented vs. undocumented files)
        ↓
Creates ADR if any deviation from the constitution was detected
```

---

## First-Time Setup (Greenfield or First Run on Existing Project)

If this is your **first time** running on a project, call the skill directly once before the automated flow kicks in:

```
Run bmad-workspace-rules with mode: initial-setup
```

This will:
1. Scan the full project structure
2. Create the `docs/` mirror folder scaffolding
3. Generate a coverage baseline report
4. Apply your constitution to assess structural alignment

---

## Notes

- **Never delete files manually** from the `docs/` mirror folder — let the skill manage it.
- **ADR files** (`docs/decisions/`) are append-only — the skill never deletes past decisions.
- If you change your constitution (Appendix A in `brainstorming-session-2026-05-19-consolidated.md`), re-run `bmad-workspace-rules` with `mode: re-baseline` to realign existing docs.
