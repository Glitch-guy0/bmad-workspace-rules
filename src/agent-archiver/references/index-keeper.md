---
name: index-keeper
description: Maintain _index.md files and cross-repo doc map
code: IK
---

# Index Keeper

Conventions reference: `references/workspace-rules.md` — file lifecycle, folder conventions, naming rules, frontmatter format, cross-repo doc map concept, file indexing system.

## What Success Looks Like
Every folder has a valid `_index.md` that accurately lists its contents. The cross-repo doc map in `docs/_index.md` is current. If something is added, moved, or removed, the indexes reflect it. The owner never hits a folder and wonders what's in it.

## Index Format

Every `_index.md` follows this structure:

```markdown
---
type: directory-index
path: [relative path from project root]
---

# [Folder Title]

[Layer 1 one-liner: what lives here]

[Layer 2 summary: when to look in this folder]

## Contents

| Name | Type | Description |
|------|------|-------------|
| [file/folder name] | [file/folder] | What it is |
```

## What to Index

All paths below resolve from `{document-folder}`. Index every folder that has structured documentation content:
- `docs/` — cross-repo doc map in the root `_index.md`
- `ideas/` — each idea file
- `milestones/` — active, confirmed, completed subfolders
- `milestones/active/[slug]/` — per-milestone folders (milestone doc, requirements, stress-test, pdrs, research)
- `milestones/confirmed/[slug]/` — confirmed artifacts (confirmed doc, sign-off log)
- `milestones/completed/[slug]/` — completed artifacts
- `planning/[slug]/` — per-milestone planning docs (tdd, adrs, api-contracts, spikes, vertical-slices)
- `implementation/[slug]/` — per-milestone implementation docs (progress, decisions-log)
- `reports/` — implementation reports
- `nfr-proposals/` — NFR proposals
- `tech-debt/` — accepted and postponed debt (with sub-indexes inside `accepted/` and `postponed/`)
- `tech-debt/accepted/` — accepted debt register
- `tech-debt/postponed/` — postponed debt register
- `strategy/` — strategic layer (research, sdrs, directives)
- `strategy/research/` — strategic research docs
- `strategy/sdrs/` — Strategic Decision Records
- `strategy/directives/` — Strategic Directives
- `dto/` — incoming and outgoing handoffs
- Any folder with multiple files that needs navigation

## When to Update

- **Immediately** when a new file or folder is created
- **During Pulse** — scan all indexed folders for changes
- **On request** — owner asks "update the indexes"

## Scan Process

1. List all files in the folder (excluding `_index.md` itself)
2. Compare against the current index entries
3. Add missing entries, flag unmatched entries
4. Ensure all frontmatter has `type` and `path` fields
5. Update the doc map root if this folder is referenced there

## Cross-Repo Doc Map

The root `docs/_index.md` serves as the cross-repo document map. When updating:

- Verify each listed document still exists
- Add new documents that have been created
- Remove entries for documents that have been archived
- Update descriptions if the doc's purpose has shifted
- Check link chain integrity (upstream/downstream fields in frontmatter)

## Memory Integration
Maintain a list of indexed folders in MEMORY.md or an organic file. During Pulse, run scan-doc-map.sh to detect drift between indexes and actual files.

## After the Session
Note which indexes were updated in the session log. Flag any discrepancies found between indexes and actual files.
