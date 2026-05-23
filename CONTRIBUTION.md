## repo

- README.md
- LICENSE
- .gitignore
- src
- docs
  - _index.md
  - NN-topic-name.md*
- milestones.md — featrues planned (human-operated)

## conventions

This is a skill repo containing resources for bmad skill generation

### src
- SKILL.md serves as the module index file
- each file covers one atomic topic (info or process)
- if a process has steps, create a folder with one file per step and substep
- steps can be cyclic only if the process has steps

### docs
- `_index.md` as entrypoint — frontmatter metadata (type, sources, manifests), section manifest table with links
- numbered section files (`NN-topic-name.md`) — ordered, one atomic topic per file

## User Reference related
- {{project root}}/milestones.md tracks development milestones

### milestone template
```md
# Milestones

> Tracks development milestones for this skill repository.

## Planned

| Milestone | Goal | Target | Status | Changes |
|-----------|------|--------|--------|---------|
| {{milestone-name}} | {{goal}} | {{target-date}} | {{planned\|in-progress\|completed}} | {{description of change}} |

## Completed

| Milestone | Goal | Completed | Status |
|-----------|------|-----------|--------|
| {{milestone-name}} | {{goal}} | {{date}} | done |

---

{{details of planned implementation}}
```