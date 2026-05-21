
# Documentation & Guidelines Notes

## Two Types of Documentation

### Product Brief *(Features & Workflow)*
> In the abstract, from the user's perspective

### Architecture Documentation
- How code is written
- Infrastructure
  - how services communicate with each other
  - each service's functionality

### Data Flow
- **DB Architecture:**
  - How things are stored
  - Data Manipulation
  - Transactions
- Connecting User Story with DB Manipulation

---

#### Architecture Documentation also covers:
- How Architecture / Infra is structured
- How services communicate and handle failures
- Coding philosophy used

---

## General Guidelines *(TypeScript)*

### `CONTRIBUTION.md`
Rules to follow during a coding session on:
- How to structure & write code
- What to document after code is written

> Each Repo will have its own `CONTRIBUTION.md` explaining what could be done in that repo/project folder.

### How code should be organized
- Managing written functionality
- Documenting & managing features
- **Brain Dump** → `[Project Milestones]` → Brainstorming
  - Maintain a file for brainstorming
  - `[Linear]`

- While explaining **Architectural decisions plan**

----

What to do?
I currently have a **docs** folder; structure things in there
- each file is atomic and contains rules on one specific thing
- create an abstract folder with multiple related files in it
- folders are like indexes to the actual files
- each file can have rules for different languages but the rules will be the same
  - focus on how to implement the exact outcome rather than language packages.
  - selected packages should be stable and should be preferred (well-known) by developers.
  - example: TypeScript logging packages will be different from Python but implementation rules will be the same