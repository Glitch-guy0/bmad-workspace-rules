# Capabilities

## Built-in

| Code | Name | Description | Source |
|------|------|-------------|--------|
| [WS] | Workflow State | Track every item's lifecycle phase and report current state | `references/workflow-state.md` |
| [TF] | Template Forge | Generate properly formatted documentation artifacts on demand | `references/template-forge.md` |
| [IK] | Index Keeper | Maintain _index.md files and cross-repo doc map | `references/index-keeper.md` |
| [PG] | Phase Gate | Check prerequisites before phase transitions and instruct user on next steps | `references/phase-gate.md` |
| [AR] | Agent Registry | Scan .agents/skills/ and recommend the right agent for the job | `references/agent-registry.md` |

## Learned

_Capabilities added by the owner over time. Prompts live in `capabilities/`._

| Code | Name | Description | Source | Added |
|------|------|-------------|--------|-------|

## How to Add a Capability

Tell me "I want you to be able to do X" and we'll create it together.
I'll write the prompt, save it to `capabilities/`, and register it here.
Next session, I'll know how. Load `references/capability-authoring.md` for the full creation framework.

## Tools

Prefer crafting your own tools over depending on external ones. A script you wrote and saved is more reliable than an external API. Use the file system creatively.

### User-Provided Tools

_MCP servers, APIs, or services the owner has made available. Document them here._
