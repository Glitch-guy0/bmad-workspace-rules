---
stepsCompleted: [research-consolidation]
status: active
session_active: true
workflow_completed: false
session_continued: true
continuation_date: '2026-05-19'
consolidation_date: '2026-05-19'
supersedes:
  - '_bmad-output/brainstorming/brainstorming-session-2026-05-18-0907.md'
  - 'braindump.md'
  - 'existing-skills.md'
  - 'current-project-workflow-extracted-docs.md'
session_topic: 'Designing bmad-workspace-rules — project documentation, structure guidance, and research backlog'
session_goals: 'Single source of truth combining constitution, skill registry, deltas, prior brainstorm, and research topics for implementation.'
decisions:
  T1: 'A — packages/dto/ internal package (Cat #16)'
  T3: 'A — Repository triad + per-module *.repository.ts (Cat #13)'
  T2: 'deferred — recommend Cat #15 Promise Exception Registry'
ideas_generated:
  - '[Cat #1] The Personal Workflow Compiler'
  - '[Cat #2] The YOLO Default Engine'
  - '[Cat #3] The Mirror Docs Architecture'
  - '[Cat #4] The Surgical Strike Protocol'
  - '[Cat #5] The YOLO Safety Interlock'
  - '[Cat #6] DX Guardrail Constraints (Never-Do Rules)'
  - '[Cat #7] The ADR-First Deviation Engine'
  - '[Cat #8] The Post-Commit Cartographer'
  - '[Cat #9] bmad-dev-story Integration'
  - '[Cat #10] The Init Ceremony'
  - '[Cat #11] The Braindump Ingress Valve'
  - '[Cat #12] The Tri-File Constitution'
  - '[Cat #13] The Repository Triad Pattern'
  - '[Cat #14] The Prisma Shard Composer'
  - '[Cat #15] The Promise Exception Registry'
  - '[Cat #16] The Shared DTO Bridge'
  - '[Cat #17] The k6 Perimeter Grid'
  - '[Cat #18] TanStack-First Scaffold Gate'
  - '[Cat #19] The Editorial Pipeline Chain'
  - '[Cat #20] Util Static Class Taxonomy'
  - '[Cat #21] The Pending Session Queue'
  - '[Cat #22] Helper-vs-Writer Skill Router'
pending_from_braindump:
  - status: resolved
    item: 'Repository triad — Cat #13 adopted (T3=A)'
  - status: open
    item: 'Split schema.prisma — Cat #14 Prisma Shard Composer'
  - status: open
    item: 'k6 per-layer testing — Cat #17 k6 Perimeter Grid'
  - status: open
    item: 'TanStack-first frontend — Cat #18'
  - status: resolved
    item: 'Shared DTO — packages/dto/ internal package (T1=A, Cat #16)'
  - status: open
    item: 'Utility/static class taxonomy — Cat #20'
  - status: open
    item: 'Promise-chain policy — T2 deferred, Cat #15 recommended'
constitutional_tensions:
  - id: T1
    resolution: 'RESOLVED — packages/dto/ internal package; FE/BE import types only'
  - id: T2
    resolution: 'DEFERRED — draft ADR via Cat #15 Promise Exception Registry'
  - id: T3
    resolution: 'RESOLVED — triad holds definitions; modules keep *.repository.ts orchestration'
output_files:
  - '/Users/prajwal/Documents/learning/bmad-documentation-builder/init.md'
  - '_bmad-output/research/research-index.md'
---

# Brainstorming Session — Research Consolidation

**Facilitator:** Prajwal  
**Date:** 2026-05-19  
**Purpose:** Merge prior session, braindump, project constitution, and skill registry into one document with rules, research topics, and appendices.

---

## Part 1 — Rules (do not edit unless user requests)

### What this file is

- **Single source of truth** for the `bmad-workspace-rules` initiative: rules, research backlog, adopted decisions, constitution, and skill registry.
- Supersedes: `brainstorming-session-2026-05-18-0907.md`, `braindump.md`, `existing-skills.md`, `current-project-workflow-extracted-docs.md`.
- Agents read this file before scaffolding, documenting, or extending project structure.

### Document precedence (within this file)

| Order | Section | Role |
|-------|---------|------|
| 1 | **Appendix A** — Project Constitution | Immutable defaults (layered BE/FE, testing, docs, DX) |
| 2 | **Part 4** — Delta queue | Proposed changes and open gaps |
| 3 | **Appendix B** — BMAD Skills Registry | Available Helper and Writer operators |
| 4 | **Part 3** — Prior brainstorm | Ideas, tensions, action plan |

Conflicts between Appendix A and Part 4 resolve via **ADR** (`docs/decisions/`), never silent merge (Cat #7).

### Agent workflow

1. Read Part 1, Part 2 (research topics), and relevant appendices.
2. For implementation tasks, check `pending_from_braindump` in frontmatter — route open items to research or ADR.
3. Greenfield: apply constitution + resolved decisions (T1, T3); use YOLO defaults (Cat #2) with guardrails (Cat #6, #5).
4. Brownfield: Surgical Strike (Cat #4) — diff-only, incremental scan.
5. After substantive doc writes: Editorial Pipeline (Cat #19) — prose → structure → shard → index → distill.
6. Route by task type (Cat #22): structure → Helper chain; net-new technical docs → Writer agents; brownfield discovery → `bmad-generate-project-context` first.

### Delta ingress (replaces `braindump.md`)

- User adds unstructured notes under **Part 4 — Delta queue** below.
- Run `bmad-brainstorming` to extend this session; mark new frontmatter `pending_from_braindump` items **open** until ADR, constitution update, or research complete.
- Closing a research topic requires: finding documented, ADR if policy change, or explicit deferral with trigger.

### Required project standards (adopted)

| Area | Rule |
|------|------|
| Testing | **MUST** use k6 for HTTP endpoint and load testing |
| Performance | Separate performance testing for frontend, backend, and microservices |
| Frontend | **MUST** prefer TanStack modules |
| Shared contracts | `packages/dto/` internal package — types only (T1 resolved) |
| Data layer | `src/repository/{schemas,models,cache}` + per-module `*.repository.ts` (T3 resolved) |
| Promises | Constitution: async/await default; braindump exceptions → Cat #15 registry (T2 deferred) |

### DX guardrails (Cat #6)

- Dry-run destructive changes with explicit diff before apply.
- Cap file changes per session; include undo instructions.
- YOLO defaults must exist — one keystroke to skip Q&A.
- Never more than 2 architecture choices at once.
- Session memory: never re-ask answered questions.
- Ship partial usable docs — do not block on perfection.
- Incremental scan — only changed files, not whole repo.

### Init and integration

- One-time setup: `init.md` + `bmad-customize` → `_bmad/custom/bmad-workspace-rules.toml` (Cat #10).
- Post `bmad-dev-story`: read `git diff HEAD~1`, update mirror docs, coverage report, ADRs on deviation (Cat #8, #9).

---

## Part 2 — Research topics

Use this section as the research backlog. **Detailed briefs:** [`_bmad-output/research/research-index.md`](../research/research-index.md). Mark status in frontmatter `pending_from_braindump` when a topic becomes an implementation task.

| ID | Topic | Status | Priority | Research brief |
|----|-------|--------|----------|----------------|
| **R-01** | **How BMad-method skills are structured** | in_progress | P0 | [R-01-bmad-skill-anatomy.md](../research/R-01-bmad-skill-anatomy.md) |
| R-02 | Prisma multi-file schema + generator client | open | P1 | [R-02-prisma-schema-shards.md](../research/R-02-prisma-schema-shards.md) |
| R-03 | k6 per-layer load/perf grid | open | P1 | [R-03-k6-perimeter-grid.md](../research/R-03-k6-perimeter-grid.md) |
| R-04 | TanStack-first frontend scaffold gate | open | P1 | [R-04-tanstack-scaffold-gate.md](../research/R-04-tanstack-scaffold-gate.md) |
| R-05 | Utility/static class taxonomy | open | P2 | [R-05-utility-taxonomy.md](../research/R-05-utility-taxonomy.md) |
| R-06 | Promise exception registry (T2) | open | P2 | [R-06-promise-exception-registry.md](../research/R-06-promise-exception-registry.md) |
| R-07 | `bmad-workspace-rules` skill skeleton | open | P0 | [R-07-workspace-rules-skill-skeleton.md](../research/R-07-workspace-rules-skill-skeleton.md) |
| R-08 | ADRs for T1 + T3 | open | P0 | [R-08-adrs-t1-t3.md](../research/R-08-adrs-t1-t3.md) |
| R-09 | Mirror docs layout + post-commit cartographer | open | P1 | [R-09-mirror-docs-cartographer.md](../research/R-09-mirror-docs-cartographer.md) |
| R-10 | Editorial pipeline automation | open | P2 | [R-10-editorial-pipeline-automation.md](../research/R-10-editorial-pipeline-automation.md) |
| R-11 | YOLO safety interlock + pre-flight quiz | open | P2 | [R-11-yolo-safety-interlock.md](../research/R-11-yolo-safety-interlock.md) |
| R-12 | Helper-vs-Writer dispatcher | open | P2 | [R-12-helper-writer-dispatcher.md](../research/R-12-helper-writer-dispatcher.md) |

### R-01: How BMad-method skills are structured

**Goal:** Document anatomy so `bmad-workspace-rules` and future custom skills follow BMad conventions.

**Research questions**

1. What belongs in `SKILL.md` vs `references/` vs `assets/` vs `scripts/`?
2. How do workflow skills (e.g. `bmad-brainstorming`) differ from agent skills (e.g. `bmad-agent-tech-writer`)?
3. What is required frontmatter (`name`, `description`) and description format?
4. How does `customize.toml` integrate with install and `module.yaml`?
5. When to use micro-file `steps/` vs inline SKILL.md vs carved `references/`?

**Findings (from installed BMad skills — starter reference)**

| Layer | Purpose | Examples |
|-------|---------|----------|
| `SKILL.md` | Entry point: YAML frontmatter (`name`, `description`), activation, routing | All skills |
| `workflow.md` | Multi-step workflow orchestration (brainstorming) | `bmad-brainstorming` |
| `steps/*.md` | Micro-file architecture — one step per file, sequential | `bmad-brainstorming/steps/` |
| `references/` | Carved-out prompt content; standalone-readable | `bmad-workflow-builder/references/` |
| `assets/` | Templates, CSV data, static inputs | `brain-methods.csv`, setup templates |
| `scripts/` | Deterministic operations (tests, analysis) | `bmad-distillator/scripts/` |
| `agents/` | Subagent prompt files for multi-agent skills | `bmad-distillator/agents/` |
| `customize.toml` | Team overrides: activation prepend/append, paths | Per-skill install |

**Naming**

- Folder name = skill `name` (kebab-case).
- Official BMad: `bmad-{name}` prefix reserved.
- Module skills: `{modulecode}-{name}` (e.g. `cis-brainstorm`).

**Description format (BMad)**

- `[5–8 word summary]. [Use when user says 'phrase' or 'phrase'.]`
- Quote trigger phrases; prefer explicit invocation.

**Path conventions**

```
## Conventions
- Bare paths resolve from skill root.
- `{skill-root}` → skill install directory (where customize.toml lives).
- `{project-root}` → project working directory.
- `{skill-name}` → skill directory basename.
```

**Quality bar**

- Every line must pass: *would an LLM do this correctly without being told?*
- Outcome-based instructions over numbered trivia steps.
- Exact steps only for fragile ops (scripts, APIs, security).

**Skill families (this project)**

| Family | Role | Skills |
|--------|------|--------|
| **Helper** | Understand, refine, compress project docs | prose → structure → shard → index → distill |
| **Writer** | Create/maintain technical documentation | tech-writer, document-project, generate-project-context |

**Next steps for R-01**

- [ ] Read `bmad-workflow-builder/references/skill-quality-principles.md` and `metadata-reference.md` end-to-end.
- [ ] Compare one workflow skill (`bmad-brainstorming`) vs one agent skill (`bmad-agent-tech-writer`) directory trees.
- [ ] Draft `docs/engineering/bmad-skill-anatomy.md` for workspace skill authors.
- [ ] Use findings when scaffolding `bmad-workspace-rules/SKILL.md`.

---

## Part 3 — Prior brainstorm summary (2026-05-18 → 2026-05-19)

**Topic:** Agent-first skill for project documentation and structure guidance (`bmad-workspace-rules`).

**Techniques used:** What If Scenarios, Reverse Brainstorming, Concept Blending, Storytelling, continuation What If.

**Top 3 build priorities**

1. **#10 Init Ceremony + #12 Tri-File Constitution** — onboarding and rule precedence.
2. **#1 Workflow Compiler + #13/#16 scaffold** — greenfield materializes triad + `packages/dto/`.
3. **#7 ADR-First + #19 Editorial Pipeline** — safe deviations and LLM-ready docs.

**Thematic index (22 ideas)**

| Theme | Ideas |
|-------|-------|
| Constitution & governance | #7, #11, #12, #21 |
| Skill UX & safety | #1, #2, #4, #5, #6, #10 |
| Documentation lifecycle | #3, #8, #9, #19, #22 |
| Architecture scaffold | #13–#18, #20 (see Part 2) |

**Resolved tensions**

| ID | Resolution |
|----|------------|
| T1 | `packages/dto/` internal package |
| T3 | Repository triad + per-module `*.repository.ts` |
| T2 | Deferred → R-06 Promise Exception Registry |

---

## Part 4 — Delta queue (user content)

Append unstructured notes below. Agents structure on request.

### Required standards (carried from braindump)

| Area | Rule |
|------|------|
| Testing | **MUST** use k6 for HTTP endpoint and load testing |
| Performance | Implement performance testing separately for frontend, backend, and microservices |
| Frontend | **MUST** prefer TanStack modules |

### Data layer

#### Repository layout

- Target per project:

```
{{project root}}/
  src/
    repository/
      schemas/
        User.schema.ts
      models/
        User.model.ts
      cache/
        UserSession.cache.ts
```

#### Prisma

- Split monolithic `schema.prisma` into maintainable chunks.
- Learn Prisma generator client for this layout.

### Code architecture

- `.then().catch()` allowed when function and error types are well known (Node APIs) — pending R-06 ADR.
- Small utility helpers for datetime, conversions, etc.
  - Prefer atomic helpers; group under static class when ≥3 share a topic.

### Collaboration

- Backend and frontend share DTO via `packages/dto/` (resolved T1).

### Resolved (do not re-litigate)

- [x] Shared DTO → `packages/dto/`
- [x] Repository triad pattern adopted

### Open (see Part 2)

- [ ] Prisma shards (R-02)
- [ ] k6 per layer (R-03)
- [ ] TanStack-first (R-04)
- [ ] Utils taxonomy (R-05)
- [ ] Promise policy ADR (R-06)

---

## Appendix A — Project Constitution

*Formerly `current-project-workflow-extracted-docs.md`. Treat as read-only defaults.*

# Project Planning & Architecture Guide

A reusable methodology for structuring and planning backend, frontend, and specialized microservices projects.

---

## Table of Contents

1. [Project Structure Philosophy](#project-structure-philosophy)
2. [Backend Architecture](#backend-architecture)
3. [Frontend Architecture](#frontend-architecture)
4. [Microservices Architecture](#microservices-architecture)
5. [Development Standards](#development-standards)
6. [Testing Strategy](#testing-strategy)
7. [Documentation Strategy](#documentation-strategy)
8. [Developer Experience](#developer-experience)
9. [Libraries of Choice](#libraries-of-choice)
10. [Project Setup Workflow](#project-setup-workflow)

---

## Project Structure Philosophy

### Core Principles

1. **Feature-based modularization** - Group by domain, not by technical role
2. **Strict separation of concerns** - Clear layered architecture with unidirectional dependencies
3. **Co-located concerns** - Tests, types, and schemas live next to implementation
4. **Convention over configuration** - Predictable file naming and organization
5. **Progressive disclosure** - Start simple, add complexity only when needed

### Multi-Service Architecture Pattern

```
project-root/
├── backend/                    # API service (Express/Fastify/etc.)
├── frontend/                   # Web frontend (Next.js/React/Vue/etc.)
├── [specialized-service]/      # Domain-specific microservices
├── docs/                       # Centralized documentation
├── testing/                    # Cross-service testing (k6, etc.)
├── release/                    # Production configs (nginx, docker)
└── docker-compose.yml          # Local infrastructure
```

**Key Decision**: Each service is its own git-tracked package with independent dependencies, not a monorepo workspace.

---

## Backend Architecture

### Directory Structure

```
backend/
├── src/
│   ├── modules/               # Feature modules (one folder per domain)
│   │   └── auth/
│   │       ├── auth.routes.ts           # HTTP route definitions
│   │       ├── auth.controller.ts       # Request parsing, response formatting
│   │       ├── auth.service.ts          # Business logic
│   │       ├── auth.repository.ts       # Data access layer
│   │       ├── auth.dto.ts             # Validation schemas + inferred types
│   │       └── auth.service.test.ts    # Co-located unit tests
│   ├── middleware/            # Cross-cutting concerns
│   │   ├── auth.middleware.ts
│   │   └── error.middleware.ts
│   ├── exceptions/           # Typed error hierarchy
│   │   ├── AppException.ts
│   │   └── [Domain]Exception.ts
│   ├── utils/                # Shared utilities
│   ├── types/                # Shared TypeScript types
│   ├── app.ts                # Express app setup
│   └── server.ts             # Entry point with graceful shutdown
├── prisma/                   # Database schema (if using Prisma)
├── .env.example
├── package.json
└── tsconfig.json
```

### Layered Architecture Rules

```
Routes → Controller → Service → Repository
```

**Strict Boundaries**:
- Controllers parse HTTP requests and format responses (never call repos directly)
- Services contain business logic (never format HTTP responses)
- Repositories handle data access (never contain business logic)
- Dependencies flow in one direction only

### Module Structure Pattern

Each feature module contains:
- `*.routes.ts` - HTTP method, path, middleware, controller binding
- `*.controller.ts` - Extract params/body, call service, return response
- `*.service.ts` - Business logic, validation, external service calls
- `*.repository.ts` - Database queries, external data sources
- `*.dto.ts` - Input validation schemas (Zod) with inferred TypeScript types
- `*.test.ts` - Co-located tests for that module

### Exception Handling Pattern

```typescript
// Base exception class
class AppException extends Error {
  constructor(
    public code: string,
    public status: number,
    public message: string,
    public details?: Record<string, any>
  ) {}
}

// Domain exceptions with static factory methods
class AuthException extends AppException {
  static invalidCredentials() {
    return new AuthException('INVALID_CREDENTIALS', 401, 'Invalid email or password');
  }
}
```

### API Response Standardization

```json
// Success
{ "success": true, "data": {...}, "error": null, "meta": {...} }

// Error
{ "success": false, "data": null, "error": { "message": "...", "code": "...", "status": ..., "details": {...} } }
```

---

## Frontend Architecture

### Directory Structure (Next.js App Router)

```
frontend/
├── src/
│   ├── app/                   # Next.js App Router pages
│   │   ├── layout.tsx
│   │   ├── login/page.tsx
│   │   └── dashboard/page.tsx
│   ├── components/            # Reusable UI components
│   │   ├── auth/              # Feature-based grouping
│   │   │   ├── LoginForm.tsx
│   │   │   └── ProtectedRoute.tsx
│   │   └── layout/
│   ├── lib/                   # Utilities and configurations
│   │   ├── api/
│   │   │   └── client.ts      # HTTP client with interceptors
│   │   ├── exceptions/
│   │   └── providers/
│   ├── store/                 # State management
│   │   ├── index.ts
│   │   └── [feature]Slice.ts
│   └── __tests__/
│       └── setup.ts
├── e2e/                       # Playwright E2E tests
├── public/
├── package.json
└── tsconfig.json
```

### State Management Split Strategy

| State Type | Tool | Example |
|-----------|------|---------|
| **Client state** | Redux Toolkit | auth token, user, UI state |
| **Server state** | TanStack Query | API data, caching, refetching |
| **Local state** | React useState | Form inputs, toggles |

### HTTP Client Pattern

```typescript
// Axios with interceptors for auth, errors, logging
const client = axios.create({ baseURL: process.env.NEXT_PUBLIC_API_URL });

// Request interceptor: attach JWT
client.interceptors.request.use(config => {
  const token = store.getState().auth.token;
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

// Response interceptor: handle 401, refresh token logic
```

---

## Microservices Architecture

### When to Create a Specialized Service

Create a separate service when:
- Different scaling requirements (CPU-intensive, memory-intensive)
- Different runtime needs (Python for ML, Node.js for API)
- Different security boundaries
- Team ownership separation

### Service Structure Pattern

```
image-processing-service/
├── src/
│   ├── routes/               # API endpoints (if HTTP-facing)
│   ├── workflows/            # Business logic (LangGraph, etc.)
│   ├── utils/
│   └── server.ts
├── package.json
└── tsconfig.json
```

### Inter-Service Communication

- **Synchronous**: HTTP REST (backend → service)
- **Asynchronous**: Message queue (planned)
- **Shared storage**: S3-compatible object storage (MinIO)

---

## Development Standards

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Files | Dot notation, lowercase | `auth.service.ts` |
| Classes | PascalCase matching file | `AuthService` |
| Functions | camelCase | `getUserById` |
| Constants | UPPER_SNAKE_CASE | `BCRYPT_COST` |
| Types/Interfaces | PascalCase | `AuthenticatedRequest` |
| Test files | Co-located, `.test.ts` | `auth.service.test.ts` |
| Environment files | `.env.example` → `.env` | - |

### Coding Standards

- **Default exports** matching filename
- **async/await only** - no raw `.then()` chains
- **Validation at boundaries** - Zod schemas for all API inputs
- **Typed exceptions** - no throwing plain strings/objects
- **No `any` types** without justification comment
- **JSDoc for public APIs** - document exported functions
- **Comments for "why"** not "what"
- **Function size limits**: Services <50 lines, Controllers <30 lines

### TypeScript Configuration

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "CommonJS",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "outDir": "dist"
  }
}
```

### Git Conventions

**Branch Naming**:
```
<type>/<short-description>
feat/auth-system
fix/jwt-expiry
chore/update-deps
refactor/auth-module
docs/api-spec
```

**Commit Format** (Conventional Commits):
```
<type>(<scope>): <description>

feat(backend): add user registration endpoint
fix(frontend): correct login redirect loop
chore(root): update docker compose volumes
```

**Scopes**: `backend`, `frontend`, `image-processing`, `root`, `docs`, `testing`

---

## Testing Strategy

### Testing Stack by Level

| Level | Tool | Location | Pattern |
|-------|------|----------|---------|
| **Unit** | Jest + ts-jest | Co-located `*.test.ts` | Test pure logic, mock deps |
| **Integration** | Jest + Supertest | Co-located `*.test.ts` | Test HTTP endpoints with mocked services |
| **E2E** | Playwright | `frontend/e2e/` | Full user flows against running services |
| **Load/Perf** | k6 | `testing/load/k6-scripts/` | Concurrent users, response times |

### Unit Testing Pattern

```typescript
// auth.service.test.ts (co-located)
import { AuthService } from './auth.service';

jest.mock('../auth.repository'); // Mock dependencies

describe('AuthService', () => {
  describe('register', () => {
    it('should hash password before storing', async () => {
      // Test implementation
    });
  });
});
```

### E2E Testing Pattern

```typescript
// frontend/e2e/auth.spec.ts
test('complete auth flow', async ({ page }) => {
  await page.goto('/register');
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="password"]', 'password123');
  await page.click('button[type="submit"]');
  await expect(page).toHaveURL('/dashboard');
});
```

### k6 Load Testing Pattern

```javascript
// testing/load/k6-scripts/auth-load.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 20 }, // Ramp up
    { duration: '1m', target: 20 },  // Stay at 20 users
    { duration: '10s', target: 0 },  // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% of requests under 500ms
  },
};

export default function () {
  const res = http.post('http://localhost:3001/api/auth/login', {
    email: 'test@example.com',
    password: 'password123',
  });
  check(res, { 'status is 200': (r) => r.status === 200 });
  sleep(1);
}
```

### Test Coverage Expectations

- **Services**: >80% coverage (business logic critical)
- **Controllers**: Test HTTP status codes, response shapes
- **Repositories**: Mock at service level, test integration separately
- **E2E**: Critical user paths (register → login → core action → logout)

---

## Documentation Strategy

### Documentation Structure

```
docs/
├── index.md                          # Documentation hub with links
├── backend/
│   ├── index.md                      # Service-specific docs
│   └── openapi.yaml                  # Living OpenAPI 3.0 spec
├── frontend/
│   └── index.md
├── [service]/
│   └── index.md
└── engineering/
    ├── index.md                      # Engineering docs TOC
    ├── coding-standards.md           # Naming, file org, error handling
    ├── testing-strategy.md           # Test levels, mocking, coverage
    ├── architecture.md               # Current architecture + constraints
    ├── ai-agent-guidelines.md        # Guidelines for AI coding agents
    └── deferred-decisions.md         # Technical debt, parking lot
```

### Documentation Conventions

1. **OpenAPI spec** as living document in `docs/backend/openapi.yaml`
2. **API response envelope**: Standardized format across all endpoints
3. **Story tracking**: Markdown files for feature implementation artifacts
4. **Inline documentation**: JSDoc for public APIs, comments for "why"
5. **README per service**: Setup instructions, environment variables

### JSDoc Pattern

```typescript
/**
 * Registers a new user with email and password
 * @param {RegisterDto} input - User registration data
 * @returns {Promise<User>} The created user without password
 * @throws {UserException} If email is already registered
 */
async register(input: RegisterDto): Promise<User> {
  // Implementation
}
```

---

## Developer Experience

### Local Development Setup

```bash
# 1. Install root git hooks (Husky)
npm install

# 2. Start infrastructure (databases, caches, etc.)
docker compose up -d

# 3. Setup backend
cd backend
cp .env.example .env    # Fill in required values
npm install
npx prisma generate     # If using Prisma
npx prisma migrate dev
npm run dev

# 4. Setup frontend (new terminal)
cd frontend
npm install
npm run dev
```

### Docker Compose for Local Infrastructure

```yaml
# docker-compose.yml
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: myapp
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 5s

  minio:
    image: minio/minio
    command: server /data --console-address ":9001"
    ports:
      - "9000:9000"
      - "9001:9001"
```

### Config Safety Pattern

1. **`.configignore`** defines sensitive files and patterns that should never be committed (e.g. `.env`, `*.pem`, API keys, certificates).
2. **Husky pre-commit hooks** automatically generate corresponding `.example` template files alongside the original config files before each commit.
3. Developers create local config files by copying templates (e.g. `.env.example` → `.env`).
4. Actual secrets, credentials, and environment-specific values must never be committed to the repository.

### Hot Reload Setup

- **Backend**: Nodemon watching `src/` with auto-restart
- **Frontend**: Next.js built-in fast refresh
- **Docker**: Volume mounts for live code without rebuilding

### Volta for Node Version Pinning

```json
{
  "volta": {
    "node": "24.13.0",
    "npm": "10.5.0"
  }
}
```

Ensures all developers use the same Node.js version.

---

## Libraries of Choice

### Backend Stack

| Library | Purpose | Why |
|---------|---------|-----|
| **Express 4.18** | HTTP framework | Mature, minimal, well-documented |
| **Prisma 5.x** | PostgreSQL ORM | Type-safe queries, migration management |
| **Zod 3.x** | Runtime validation | Infer TypeScript types from schemas |
| **paseto** | PASETO handling | Modern secure stateless auth |
| **bcryptjs** | Password hashing | Pure JS (no native deps), secure |
| **Multer** | File uploads | Express middleware, well-supported |
| **@aws-sdk/client-s3** | S3/MinIO storage | Standard S3 API, works with MinIO |
| **http-status-codes** | Status constants | Readable status codes (OK, CREATED) |
| **Pino** | Structured logging | JSON logs, fast, npm standard | 
| **Jest + ts-jest** | Testing | TypeScript support, good mocking |
| **Supertest** | HTTP testing | Superagent-based, clean API |

### Frontend Stack

| Library | Purpose | Why |
|---------|---------|-----|
| **Next.js 14** | React framework | App Router, SSR/SSG, great DX |
| **React 18** | UI library | Standard, concurrent features |
| **Redux Toolkit** | Client state | Predictable, DevTools, less boilerplate |
| **TanStack Query** | Server state | Caching, background refetch, retries |
| **Axios** | HTTP client | Interceptors, request/response transform |
| **Tailwind CSS** | Styling | Utility-first, rapid development |
| **Playwright** | E2E testing | Reliable, fast, cross-browser |

### Specialized Service Stack

| Library | Purpose | Why |
|---------|---------|-----|
| **LangChain/LangGraph** | AI workflows | Composable AI pipelines |
| **sharp** | Image processing | Fast, low memory, wide format support |
| **pdf-lib** | PDF manipulation | Pure JS, no native deps |

### Development Tools

| Library | Purpose | Why |
|---------|---------|-----|
| **TypeScript** | Type safety | Catch errors early, better IDE support |
| **Husky** | Git hooks | Enforce conventions pre-commit |
| **Volta** | Node version manager | Pin versions per-project |
| **Docker Compose** | Local infrastructure | Reproducible environment |

---

## Project Setup Workflow

### New Backend Service Setup

```bash
# 1. Initialize
mkdir backend && cd backend
npm init -y

# 2. Install dependencies
npm install express cors dotenv
npm install -D typescript @types/node @types/express @types/cors ts-jest jest

# 3. TypeScript setup
npx tsc --init
# Edit tsconfig.json: strict: true, outDir: "dist", rootDir: "src"

# 4. Project structure
mkdir -p src/{modules, middleware, exceptions, utils, types}

# 5. Scripts in package.json
{
  "scripts": {
    "dev": "nodemon --watch src --exec ts-node src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "test": "jest"
  }
}
```

### New Frontend Setup (Next.js)

```bash
# 1. Create Next.js app
npx create-next-app@latest frontend --typescript --tailwind --app

# 2. Install additional dependencies
cd frontend
npm install @reduxjs/toolkit react-redux @tanstack/react-query axios

# 3. Project structure
mkdir -p src/{components, lib/{api, exceptions, providers}, store}
```

### New Microservice Setup

```bash
# Follow backend setup, then add specialized dependencies
npm install @langchain/langgraph @langchain/openai
# or
npm install sharp pdf-lib
```

---

## Checklist for New Projects

Use this checklist to ensure consistent project setup:

### Backend
- [ ] Feature-based module structure created
- [ ] Layered architecture (routes → controller → service → repository)
- [ ] Typed exception hierarchy
- [ ] Zod validation for all inputs
- [ ] Standardized API response format
- [ ] Jest + ts-jest configured
- [ ] Co-located test files
- [ ] Environment config with `.env.example`
- [ ] Docker Compose for local DB/cache
- [ ] Pino for structured logging

### Frontend
- [ ] Next.js App Router structure
- [ ] State management split (Redux for client, TanStack for server)
- [ ] Axios client with interceptors
- [ ] Component organization by feature
- [ ] Playwright E2E setup
- [ ] Jest unit test setup

### Documentation
- [ ] `docs/` structure created
- [ ] OpenAPI spec started
- [ ] Coding standards documented
- [ ] Testing strategy documented
- [ ] Architecture documented
- [ ] README with setup instructions

### Developer Experience
- [ ] Volta pinning in root `package.json`
- [ ] Husky git hooks installed
- [ ] `.configignore` for sensitive files
- [ ] Docker Compose for infrastructure
- [ ] Hot reload working for all services
- [ ] k6 load testing scaffolded

---

## Deferred Decisions Tracking

Maintain a `docs/engineering/deferred-decisions.md` to track:

```markdown
## Deferred Decisions

| Decision | Impact | Resolution Trigger |
|----------|--------|-------------------|
| Add ESLint config | Lint scripts do nothing | Before production |
| Structured logging | console.error in use | Before production |
| CI/CD pipeline | No automatic tests | Before second contributor |
| Rate limiting | Brute-force vulnerability | Before public launch |
```

This ensures technical debt is visible and has clear resolution criteria.

---

## Conclusion

This methodology provides a reusable framework for project structure and planning. The key is consistency:
- Same patterns across services
- Same libraries for same problems
- Same conventions for naming, testing, documentation
- Same developer experience setup

Adapt the specific libraries and tools based on project needs, but maintain the architectural patterns and conventions.

## Appendix B — BMAD Skills Registry

*Formerly `existing-skills.md`.*

# Existing BMAD-skills
- these skills could be divided into 2 parts
  - Helpers: which helps with understanding the project
  - Writer: existing skills for technical documentation maintainance
  
## Format
- first there will be segment
- the 2nd header is the skill name
- there there is a description of that skill
- and there could be '### Hint' on when and how to use it

### more on '### Hint' field usage
- this is just user interpretation and example on how it could be used.
- must not follow this strictly.
- must follow the 'name' and 'description' field as source of truth.
- recomended to search on what it actually does and the scope of usage based on that implement in the skill file.

---
# Helpers
## bmad-editorial-review-prose
- name: bmad-editorial-review-prose
- description: 'Clinical copy-editor that reviews text for communication issues. Use when user says review for prose or improve the prose'
### Hint
- use this when you had any update session with user and you have a dump of updates you got from user and need to be sorted into groups to have a structured file to refer.

## bmad-editorial-review-structure
- name: bmad-editorial-review-structure
- description: 'Structural editor that proposes cuts, reorganization, and simplification while preserving comprehension. Use when user requests structural review or editorial review of structure'
### Hint
- use this after 'bmad-editorial-review-prose' and structure things.

## bmad-shared-docs
- name: bmad-shard-doc
- description: 'Splits large markdown documents into smaller, organized files based on level 2 (default) sections. Use if the user says perform shard document'
### Hint
- use this after 'bmad-editorial-review-structure' to split things into grouping related things into files to have a related things together.

## bmad-index-docs
- name: bmad-index-docs
- description: 'Generates or updates an index.md to reference all docs in the folder. Use if user requests to create or update an index of all files in a specific folder'
### Hint
- use this after 'bmad-shared-docs' to have a index file to where agent can refer through and have a path to get required documents

## bmad-distillator
- name: bmad-distillator
- description: Lossless LLM-optimized compression of source documents. Use when the user requests to 'distill documents' or 'create a distillate'.
### Hint
- use this for conversation compression or after brainstorm completion to compress by extracting core ideas

# Writer
## bmad-agent-tech-writer
- name: bmad-agent-tech-writer
- description: Technical documentation specialist and knowledge curator. Use when the user asks to talk to Paige or requests the tech writer. 

## bmad-document-project
- name: bmad-document-project
- description: 'Document brownfield projects for AI context. Use when the user says "document this project" or "generate project docs"'

## bmad-generate-project-context
- name: bmad-generate-project-context
- description: 'Create project-context.md with AI rules. Use when the user says "generate project context" or "create project context"'
### Hint
- use this first in case of brown-field to understand the project structure

---

## Session path

`_bmad-output/brainstorming/brainstorming-session-2026-05-19-consolidated.md`
