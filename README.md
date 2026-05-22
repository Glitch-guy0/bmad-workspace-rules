# BMad Documentation Builder

A BMad skill for building and maintaining product documentation following the Product Documentation Framework.

## Structure

- `README.md` — this file
- `LICENSE` — license information
- `.gitignore` — git ignore rules
- `CONTRIBUTION.md` — repo conventions and structure rules
- `final-plan.md` — comprehensive Product Documentation Framework plan
- `tech-stack-standards.md` — tech stack and coding standards reference
- `project-plan-source-of-truth/` — validated source-of-truth documents
  - `_index.md` — index of source-of-truth documents
  - `01-documentation-framework.md`
  - `02-project-constitution.md`
  - `03-bmad-skill-system.md`
  - `04-architecture-decisions.md`
  - `05-documentation-guidelines.md`
- `src/` — skill resources
  - `SKILL.md` — main skill definition
  - `structured_rules.csv` — structured rules for the skill
  - `agents/` — agent definitions (editorial, developer, product)
  - `templates/` — document templates (pdr, adr, tdd, api-contract, milestone-confirmation)
  - `scripts/` — pipeline scripts (editorial-pipeline, milestone-stress-test)
- `docs/` — known issues and development milestones
  - `missing.md` — issues from failing test cases (human-operated)
  - `milestones.md` — development milestones
- `_bmad/` — BMad configuration
- `_bmad-output/` — BMad output artifacts
- `.agents/` — installed BMad skills
- `.agent/` — agent workspace configuration
- `.opencode/` — OpenCode configuration

## License

See [LICENSE](LICENSE).
