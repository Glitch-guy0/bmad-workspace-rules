This section covers Project Constitution and Architecture Standards. Part 2 of 5 from consolidated-session-complete.md, research-complete.md.

## Project Structure Philosophy
- Feature-based modularization: group by domain, not technical role
- Strict separation of concerns: unidirectional dependencies (routes → controller → service → repository)
- Co-located tests, types, schemas next to implementation
- Convention over configuration: predictable file naming and organization
- Progressive disclosure: start simple, add complexity when needed
- Multi-service pattern: `backend/`, `frontend/`, `[specialized-service]/`, `docs/`, `testing/`, `release/`
- Each service is an independent git-tracked package (not monorepo workspace)
- Must have k6 for HTTP endpoint and load testing
- Separate performance testing for frontend, backend, and microservices
- Frontend MUST prefer TanStack modules (Query, Router, Table)
- Shared contracts via `packages/dto/` internal package (T1 resolved)
- Data layer: `src/repository/{schemas,models,cache}` + per-module `*.repository.ts` (T3 resolved)
- Promises: async/await default; `.then().catch()` only via Cat #15 exception registry (T2 deferred)

## Backend Architecture
- Modules folder per domain: `auth.routes.ts`, `auth.controller.ts`, `auth.service.ts`, `auth.repository.ts`, `auth.dto.ts`, `auth.service.test.ts`
- Cross-cutting: `middleware/`, `exceptions/`, `utils/`, `types/`
- Controllers parse HTTP requests and format responses (never call repos directly)
- Services contain business logic (never format HTTP responses)
- Repositories handle data access (never contain business logic)
- Module structure: routes → controller → service → repository → test
- Exception hierarchy: `AppException(code, status, message, details)` base class; domain exceptions via static factories (e.g., `AuthException.invalidCredentials()`)
- API response standardization: `{ success, data, error, meta }` for success; `{ success: false, data: null, error: { message, code, details } }` for errors
- Validation at boundaries: Zod schemas for all API inputs
- No raw `.then()` chains
- Typed exceptions (no plain strings)
- No `any` types without justification
- Services <50 lines, Controllers <30 lines

## Frontend Architecture (Next.js App Router)
- Directory: `src/app/` (pages), `src/components/` (feature-grouped), `src/lib/api/`, `src/lib/exceptions/`, `src/lib/providers/`, `src/store/`, `frontend/e2e/`
- State management split: Redux Toolkit for client state (auth token, user, UI), TanStack Query for server state (API data, caching), React useState for local state (form inputs, toggles)
- HTTP client: Axios with interceptors for JWT attachment and 401 handling
- No `useEffect` + `fetch` for server data in new code
- Redux slices must not store server-fetched entities
- Table UIs use TanStack Table before MUI DataGrid alternatives
- Brownfield: new files TanStack-only; touching legacy Redux-server code requires migration ticket + ADR if exception needed

## Microservices Architecture
- Create separate service when: different scaling (CPU/memory-intensive), different runtime (Python for ML), different security boundaries, team ownership separation
- Service structure: `src/{routes, workflows, utils}/`, `server.ts`
- Inter-service communication: synchronous HTTP REST (backend → service), async message queue (planned), shared S3-compatible storage (MinIO)

## Development Standards
- Naming: dot-notation files (`auth.service.ts`), PascalCase classes, camelCase functions, UPPER_SNAKE_CASE constants, PascalCase types/interfaces, `.test.ts` co-located tests
- Default exports matching filename
- JSDoc for public APIs
- Comments for "why" not "what"
- TypeScript config: ES2020 target, CommonJS module, strict mode, esModuleInterop, skipLibCheck, outDir "dist"
- Git branches: `<type>/<short-description>` (feat, fix, chore, refactor, docs)
- Git commits: Conventional Commits format `<type>(<scope>): <description>` with scopes (backend, frontend, image-processing, root, docs, testing)

## Testing Strategy
- Unit: Jest + ts-jest, co-located `*.test.ts`, test pure logic with mocked deps
- Integration: Jest + Supertest, test HTTP endpoints with mocked services
- E2E: Playwright, `frontend/e2e/`, full user flows against running services
- Load/Perf: k6, `testing/load/k6-scripts/`, concurrent users and response times
- Coverage: Services >80%, controllers (HTTP codes + response shapes), repositories mock at service level, E2E for critical paths (register → login → core action → logout)
- k6 script pattern: `stages` (ramp up, stay, ramp down) + `thresholds` (e.g., p(95)<500ms)

## Documentation Strategy
- Directory: `docs/` with `index.md`, `backend/index.md + openapi.yaml`, `frontend/index.md`, `engineering/` (coding-standards, testing-strategy, architecture, ai-agent-guidelines, deferred-decisions)
- OpenAPI spec as living doc in `docs/backend/openapi.yaml`
- API response envelope standardized across all endpoints
- JSDoc for public APIs with `@param`, `@returns`, `@throws`
- README per service with setup instructions and env variables

## Developer Experience
- Local dev: Husky git hooks, Docker Compose for infrastructure, `cp .env.example .env`, `npx prisma generate`, `npx prisma migrate dev`, `npm run dev`
- Docker Compose services: postgres (16-alpine) + MinIO for S3-compatible storage
- Config safety: `.configignore` defines sensitive patterns, Husky auto-generates `.example` files pre-commit
- Hot reload: Nodemon for backend, Next.js fast refresh for frontend, Docker volume mounts
- Volta for Node version pinning (node 24.13.0, npm 10.5.0)

## Libraries of Choice
- Backend: Express 4.18, Prisma 5.x, Zod 3.x, paseto, bcryptjs, Multer, @aws-sdk/client-s3, http-status-codes, Pino, Jest/ts-jest, Supertest
- Frontend: Next.js 14, React 18, Redux Toolkit, TanStack Query, Axios, Tailwind CSS, Playwright
- Specialized: LangChain/LangGraph (AI workflows), sharp (image processing), pdf-lib (PDF manipulation)
- Dev tools: TypeScript, Husky, Volta, Docker Compose
- DTO package: `packages/dto/` with TypeScript types + Zod schemas, no business logic

## DX Guardrails (Cat #6)
- Dry-run destructive changes with explicit diff before apply
- Cap file changes per session with undo instructions
- YOLO defaults exist — one keystroke to skip Q&A
- Never more than 2 architecture choices at once
- Session memory: never re-ask answered questions
- Ship partial usable docs — do not block on perfection
- Incremental scan — only changed files, not whole repo
