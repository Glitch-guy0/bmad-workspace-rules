# Pulse

**Default frequency:** daily

## On Quiet Rebirth

When invoked via `--headless` without a specific task, load `references/memory-guidance.md` for memory discipline, then work through these in priority order.

### Memory Curation

Your goal: when your owner activates you next session and you read MEMORY.md, you should have everything you need to be effective and nothing you don't. MEMORY.md is the single most important file in your sanctum — it determines how smart you are on rebirth.

**What good curation looks like:**
- A new session could start with any request and MEMORY.md gives you the context to be immediately useful — past work to reference, preferences to respect, patterns to leverage
- No entry exists that you'd skip over because it's stale, resolved, or obvious
- Patterns across sessions are surfaced — recurring themes, things the owner keeps circling back to
- The file is under 200 lines. If it's longer, you're hoarding, not curating.

**Source material:** Read recent session logs in `sessions/`. These are raw notes from past sessions — the unprocessed experience. Your job is to extract what matters and let the rest go. Session logs older than 14 days can be pruned once their value is captured.

**Also maintain:** Update INDEX.md if new organic files have appeared. Check BOND.md — has anything about the owner changed that should be reflected?

### Doc Map Scan

Run `scan-doc-map.sh` from the `{output-folder}` to check every indexed folder for drift. Compare actual files against `_index.md` entries. Flag discrepancies:
- Files without index entries
- Index entries pointing to missing files
- Stale cross-references in `docs/_index.md`

### Frontmatter Validation

Run `validate-frontmatter.sh` from the `{output-folder}` against `docs/`, `ideas/`, `milestones/`, `planning/`, and `reports/`. Report any files with missing or invalid frontmatter fields.

### Workflow State Review

Scan the workflow state and flag items that appear stalled:
- Items in "Validation" for more than 7 days without activity
- Items in "Dev Planning" for more than 14 days
- Items in "Implementation" with no recent progress log updates
- Items in "Report" that have been sitting for more than 3 days

### Self-Improvement (if owner has enabled)
Reflect on recent sessions. What worked well? What fell flat? Are there capability gaps — things the owner keeps needing that you don't have a capability for? Consider proposing new capabilities, refining existing ones, or innovating your approach. Note findings in session log for discussion with owner next session.

## Task Routing

| Task | Action |
|------|--------|
| scan-docs | Run doc map scan and frontmatter validation, report results |
| curate-memory | Full memory curation cycle (session log review, MEMORY.md update, BOND.md check) |
| review-workflow | Scan workflow state, flag stalled items |
| full-cycle | Run scan-docs + curate-memory + review-workflow |

## Quiet Hours
Prefer running between 00:00 and 06:00 local time, or low-activity periods. Do not pulse when the owner is likely in a session — check for recent session logs.

## State
_Maintained by the agent. Last check timestamps, pending items._
