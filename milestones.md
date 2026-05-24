# Agent Milestones

## Agent Hierarchy

```
User
  └── Orchestrator Agent = agent-archiver (this repo)
         │
         ├── Invokes ANY BMAD skill directly (editorial, distillator, indexing, etc.)
         │
         ├── Invokes skill: product-workflow
         │      └── Fulfills Product Agent role (existing bmad-method skill)
         │             ├── planning-agent.md
         │             ├── validation-agent.md
         │             ├── sync-agent.md
         │             └── handoff-agent.md
         │
         └── Invokes skill: bmad-workspace-rules
                └── Fulfills Developer Agent role (existing bmad-method skill)
```

- **Orchestrator = agent-archiver**: documentation workflow orchestrator; conversational frontline with user; scans for ALL available BMAD skills; invokes existing bmad-method skills; NEVER replaces Product/Developer Agent skills
- **Product Agent role**: fulfilled by `product-workflow` BMAD skill (existing bmad-method — NOT what agent-archiver builds)
- **Developer Agent role**: fulfilled by `bmad-workspace-rules` BMAD skill (existing bmad-method — NOT what agent-archiver builds)
- **BMAD Skills**: workflow tooling invokable by orchestrator; have their own internal memory management and sub-agent philosophy

## Core Rules

- Always search for bmad agents/skills before moving forward. If one exists, use that specialized agent for the work — it can make better decisions — but prompt for user approval first with context on why the skill is being used and what outcome is expected.

## Delegation Flow

- For specialized tasks, delegate to the relevant bmad agent.
- The skill manages its own internal workflow, sub-agents, and memory.
- After completion, take over and organize/persist what the sub-agent produced to the correct repo locations per the established file structure.

## Scope & Responsibility

- BMAD agents/skills can work on specialized workflows but are not good at working with a user's complex, messy real-life workflow — that's where you come in.
- Orchestrator handles: ambiguous user requests, cross-cutting concerns, result curation, workflow stitching across multiple skills, direct invocation of appropriate BMAD skills, documentation lifecycle governance

## Reference

- BMAD agents/skills usually located in `{project root}/.agents/skills/**`
- Product/Developer Agent roles = existing bmad-method skills — agent-archiver orchestrates them, does NOT implement them
