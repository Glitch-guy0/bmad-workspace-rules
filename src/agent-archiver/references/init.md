---
name: init
description: Initialize documentation workspace — create folder structure, import existing docs
code: IN
---

# Init — Documentation Workspace Initialization

Conventions reference: `references/workspace-rules.md` — artifact types, paths, naming, frontmatter.

## What Success Looks Like
The owner invokes `init` and walks through a guided setup. The `{document-folder}` is created with the full folder structure, all `_index.md` files in place, and their existing documentation imported into the right folders. After init, the owner has a ready-to-use documentation workspace.

## Prerequisites

- Module should be registered via `setup` first (has `wr` section in `config.yaml`). If not, run `setup` before or bundled.
- Need permission to create directories and copy files at the chosen path.

## Step 1 — Ask Where to Create the Document Folder

Present the question clearly with a sensible default:

> "Where should I create the documentation workspace?"
>
> Default: `{project-root}/_bmad-docs`

Show the default in brackets. The owner can accept it or specify a different path. If they provide a path, resolve it relative to `{project-root}` if it's relative, or use it as-is if absolute.

Save the chosen path as `document_folder` in `_bmad/config.yaml` (root level).

## Step 2 — Create the Full Folder Structure

Create the following directory tree under `{document-folder}`:

```
_bmad-docs/
├── docs/                        # Cross-repo doc map, reference docs
├── ideas/                       # Idea capture files
├── milestones/
│   ├── active/                  # Active milestone folders
│   │   └── [slug]/
│   │       ├── requirements/    # Per-milestone requirements
│   │       ├── stress-test/     # Stress test session logs
│   │       ├── pdrs/            # Product Decision Records
│   │       └── research/        # Product Research Docs
│   ├── confirmed/               # Confirmed milestones (read-only)
│   │   └── [slug]/
│   └── completed/               # Completed milestones
│       └── [slug]/
├── planning/
│   └── [slug]/
│       ├── adrs/                # Architecture Decision Records
│       ├── api-contracts/       # API Contracts
│       ├── spikes/              # Spike/Research docs
│       └── vertical-slices/     # Vertical slice plans
├── implementation/
│   └── [slug]/                  # Per-milestone implementation
├── reports/                     # Implementation reports
├── nfr-proposals/               # NFR proposals
├── tech-debt/
│   ├── accepted/                # Accepted tech debt
│   └── postponed/               # Postponed tech debt
├── strategy/
│   ├── research/                # Strategic research docs
│   ├── sdrs/                    # Strategic Decision Records
│   └── directives/              # Strategic Directives
└── dto/
    ├── incoming/                # Incoming DTOs (from other repo)
    └── outgoing/                # Outgoing DTOs (to other repo)
```

For each subfolder that can contain multiple files, create a placeholder `_index.md`:

```markdown
---
type: directory-index
path: {document-folder}/[folder-path]
---

# [Folder Title]

[One-line description of what lives here]

_Empty. Add files to populate this folder._
```

For the root `_index.md` of the document folder, create a master index:

```markdown
---
type: directory-index
path: {document-folder}/
---

# Documentation Workspace

Master index for the documentation workspace.

## Contents

| Folder | Description |
|--------|-------------|
| docs/ | Cross-repo doc map and reference documentation |
| ideas/ | Raw idea capture files |
| milestones/ | Milestone lifecycle (active, confirmed, completed) |
| planning/ | Technical planning docs per milestone |
| implementation/ | Per-milestone implementation tracking |
| reports/ | Implementation reports |
| nfr-proposals/ | Non-functional requirement proposals |
| tech-debt/ | Technical debt register (accepted, postponed) |
| strategy/ | Strategic decision records and directives |
| dto/ | Incoming and outgoing handoff documents |
```

Use `mkdir -p` or equivalent to create the directory tree.

## Step 3 — Ask Where Existing Documentation Lives

> "Do you have existing documentation you'd like to import? Enter a path to a folder or a single file, or type 'skip' to start fresh."

If they provide a path:
1. Verify the path exists and is readable
2. Scan the folder or file
3. Classify each document by type (idea, milestone, ADR, report, etc.)
4. Copy each into the appropriate subfolder under `{document-folder}`

### Classification Heuristics

Use these rules when scanning imported files:

| File Pattern / Content Clue | Destination Folder |
|----------------------------|-------------------|
| Filename contains `idea`, `brainstorm` | `ideas/` |
| Filename contains `milestone`, filename matches milestone slug pattern | `milestones/active/[slug]/` |
| Frontmatter `type: adr` or filename contains `adr`, `decision` | `planning/[slug]/adrs/` |
| Frontmatter `type: tdd` or filename contains `tdd`, `design` | `planning/[slug]/` |
| Frontmatter `type: report` or filename contains `report` | `reports/` |
| Frontmatter `type: nfr` or filename contains `nfr` | `nfr-proposals/` |
| Frontmatter `type: tech-debt` or filename contains `debt` | `tech-debt/` |
| Frontmatter `type: pdr` or filename starts with `PDR` | `milestones/active/[slug]/pdrs/` |
| Frontmatter `type: sdr` or filename starts with `SDR` | `strategy/sdrs/` |
| Frontmatter `type: spike` or filename contains `spike` | `planning/[slug]/spikes/` |
| Unclassified markdown files with `type` in frontmatter | Match type to path per workspace-rules.md |
| Unclassified markdown files without type | `docs/` — general reference |
| Non-markdown files | `docs/` — reference material |

For each imported file:

1. Read the file content
2. Extract or add YAML frontmatter (slug, type, status, created)
3. Add `upstream` pointing to the original source path
4. Add `imported: YYYY-MM-DD` to frontmatter
5. Write to the appropriate destination under `{document-folder}`

If the file already has frontmatter, preserve it and only add the import metadata. If it lacks frontmatter, add minimal frontmatter with the detected type and the original path as upstream.

### After Import

After copying files, show the owner a summary:

> "Imported [N] files into the documentation workspace:"
> - [N] ideas → ideas/
> - [N] milestones → milestones/
> - [N] ADRs → planning/[slug]/adrs/
> - ...etc

Then run the Index Keeper flow (`references/index-keeper.md`) to generate `_index.md` files for all populated folders.

## Step 4 — Confirm

> "Documentation workspace initialized at `{document-folder}`."
>
> "Folder structure created with [N] subdirectories."
>
> "Imported [N] existing documents."
>
> "The workspace is ready. You can now use me to manage the full documentation lifecycle."

## Memory Integration
Write the chosen `document_folder` path to MEMORY.md for quick reference. Note the import count and any notable patterns discovered in existing docs.

## After the Session
Note the init completion in the session log — workspace path, folder count, import count, any classification issues encountered.
