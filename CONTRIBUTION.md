## repo

- README.md
- LICENSE
- .gitignore
- src
- docs
  - missing.md — issues from failing test cases (human-operated)
  - milestones.md

## conventions

this is a skill repo containing resources for bmad skill generation

### src
- SKILL.md serves as the module index file
- each file covers one atomic topic (info or process)
- if a process has steps, create a folder with one file per step and substep
- steps can be cyclic only if the process has steps

### docs
- missing.md tracks known issues from test failures
- milestones.md tracks development milestones

## src example

- src
  - SKILL.md
  - agents
    - sub-agent1
      - sub-agent1.md
      - steps
        - sub-agent1-step1.md
        - sub-agent1-step2.md
    - sub-agent2.md
  - templates
    - template1.md
    - template2.md
  - scripts
    - script1.md
    - script2.md
  - structured_rules.csv
