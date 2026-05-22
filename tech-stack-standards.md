---
type: bmad-distillate
sources:
  - "backend-stack-collection.md"
  - "frontend-stack-collection.md"
  - "typescript-coding-style-rules.md"
downstream_consumer: "Project initialization — tech-stack selection + coding standards adoption"
created: "2026-05-22"
token_estimate: 3713
parts: 1
---

# Tech Stack & Coding Standards — Project Initialization Prompt

## 🖥️ Backend

### HTTP Framework
- Minimal: Express.js, Fastify, Hono, Koa
- Opinionated: NestJS, AdonisJS
- Full-stack/meta: Next.js, Nuxt

### API Style
- REST + OpenAPI/Swagger — versioning, pagination, filtering, idempotency, rate limiting
- GraphQL (Apollo, Mercurius, Yoga) — schema-first, federation, persisted queries, dataloader, complexity limits
- Type-safe RPC: tRPC — monorepo, end-to-end TS inference, TanStack Query
- gRPC + Protobuf — microservices, low-latency, polyglot

### Realtime
- WebSockets, SSE, WebRTC, Socket.IO — event-driven, pub/sub, presence

### ORM / Database
- ORM: Prisma, TypeORM, Drizzle ORM, Sequelize
- ODM: Mongoose
- Query Builders: Kysely, Knex, SQLC, Zapatos
- Migrations: schema migrations, seeders, rollback, reproducible state, CI validation

### Validation & Serialization
- Validation: Zod, Joi, Valibot, Yup, class-validator
- Serialization: class-transformer, superjson, protobuf, msgpack

### Auth & Security
- Auth: JWT, PASETO, OAuth2, OIDC, session auth, API keys
- Identity: Auth0, Clerk, Supabase, Firebase, Keycloak
- Security: RBAC, ABAC, CSRF, CORS, Helmet, secret rotation, rate limiting, audit logging, input sanitization, dependency scan, SAST/DAST, OWASP

### Logging & Observability
- Logging: Pino, Winston — structured JSON, correlation IDs, request tracing
- Telemetry: OpenTelemetry, OTLP
- Monitoring: Prometheus+Grafana, Datadog, New Relic
- Error Tracking: Sentry, Bugsnag

### Async & Events
- Queues: BullMQ, RabbitMQ, SQS, Kafka
- Event Streaming: Kafka, Redpanda, NATS — event sourcing, CQRS, saga orchestration

### Caching
- Redis, Memcached — cache-aside, write-through, distributed, request dedup

### Testing
- Unit: Jest, Vitest
- Integration: testcontainers, supertest
- E2E: Playwright, Cypress
- Contract: Pact, OpenAPI validation

### Architecture
- MVC, Clean Architecture, Hexagonal, Onion, DDD, Vertical Slice, Modular Monolith, Microservices, Event-Driven

### CI/CD & Code Quality
- CI/CD: GitHub Actions, GitLab CI, Jenkins — lint, typecheck, test gates, security scan, preview deploys, semantic releases
- Formatting+Linting: ESLint, Prettier, Biome
- Git: conventional commits, semantic versioning, squash merge, trunk-based
- Hooks: Husky, lint-staged, commitlint
- API Docs: Swagger/OpenAPI, Redoc, Scalar, GraphQL Playground
- Config: dotenvx, infisical, vault — env validation, typed config, secrets, feature flags

### Monorepo
- Turborepo, Nx, pnpm workspaces

### Infra & Deploy
- Containers: Docker + Kubernetes
- IaC: Terraform, Pulumi
- Serverless: AWS Lambda, Cloudflare Workers, Vercel Functions

### Emerging Backend
- AI/LLM: LangChain, Mastra, OpenAI SDK, AI Gateway — embeddings, vector DBs, RAG, agent workflows
- Platform Engineering: Backstage, golden paths, self-service infra
- Supply Chain: SBOM, Sigstore, provenance, dependency pinning

---

## 🎨 Frontend

### Framework
- Component: React, Vue.js, Svelte
- Meta: Next.js, Remix, Nuxt, Astro, TanStack Start

### Build & Runtime
- Bundlers: Vite, Webpack, Rsbuild, Turbopack, Rspack
- Runtime: Node.js, Bun, Deno

### Styling
- Utility-first: Tailwind CSS
- CSS-in-JS: styled-components, Emotion
- Modern CSS: variables, design tokens, container queries, cascade layers, logical properties

### Component System
- UI Libraries: shadcn/ui, Material UI, Ant Design
- Headless UI: Radix UI, Ariakit — accessibility-first composable primitives

### State Management
- Client: Zustand, Jotai, Redux Toolkit, MobX
- Server: TanStack Query
- Forms: React Hook Form, Formik, TanStack Form

### API / Data
- REST: fetch, axios
- GraphQL: Apollo Client, Relay, urql
- Type-safe: tRPC
- Realtime: WebSockets, SSE, Live Queries

### Realtime & Collaboration
- WebRTC: voice/video, P2P, multiplayer, screen sharing
- Infra: LiveKit, mediasoup, Socket.IO, PeerJS
- CRDT Sync: Yjs, Automerge — collaborative editing, multiplayer, local-first

### 3D & Graphics
- WebGL (core)
- Engines: Three.js, React Three Fiber+Drei, Babylon.js, PlayCanvas
- WebGPU — high-perf rendering, compute shaders, AI, simulations
- Shaders: GLSL, WGSL
- Assets: glTF, USD, Draco
- Physics: Rapier, Cannon.js, Ammo.js

### WASM
- Languages: Rust, C++, Zig, Go
- Toolchains: wasm-pack, Emscripten, wasm-bindgen
- Use: image/video processing, CAD, game engines, AI inference, compression, emulators, crypto, scientific compute
- Browser AI+WASM: ONNX Runtime Web, Transformers.js, WebLLM

### Media
- Video: HLS, DASH, MSE
- Streaming: WebRTC, RTMP, WHIP/WHEP
- Audio: Web Audio API, Tone.js

### PWA & Offline
- PWA: Service Workers, Web App Manifest, offline caching
- Local-first: RxDB, ElectricSQL, PouchDB — sync engines, conflict resolution

### AI-Native
- AI SDKs: OpenAI SDK, Vercel AI SDK
- Streaming UI: token streaming, optimistic rendering, chat persistence
- AI UX: command palettes, agent workflows, inline copilots, multimodal

### Security
- CSP, XSS protection, iframe sandboxing, secure cookies, token rotation, browser isolation

### Observability
- Monitoring: Sentry, LogRocket, Datadog RUM
- Perf: Core Web Vitals, Lighthouse, RUM

### Testing
- Unit: Vitest, Jest
- Component: Testing Library
- E2E: Playwright, Cypress
- Visual Regression: Chromatic, Percy

### Architecture
- Component-driven, Atomic Design, Feature-based, Vertical Slice, Micro-frontends, Islands

### Deploy
- Hosting: Vercel, Netlify, Cloudflare Pages
- Edge: Cloudflare Workers, Edge Functions, server components at edge

### Browser APIs
- Web Workers, Shared Workers, IndexedDB, File System Access, WebUSB, WebBluetooth, WebSerial, WebCodecs, OffscreenCanvas

### Emerging Frontend
- Browser AI: on-device inference, local embeddings, browser vector DBs
- Spatial: WebXR, AR/VR
- Multiplayer: CRDT sync, realtime cursors, collaborative editors

### Engineering Tracks
- App (dashboards/SaaS), Creative (3D/graphics/motion), AI (copilots/agents), Realtime (multiplayer/collab), Browser Systems (WASM/WebGPU/native-like)

---

## 📐 Coding Standards — Backend

### Module File Structure (per feature)
- `{feature}.routes.ts` — Express Router, middleware chains
- `{feature}.controller.ts` — request parsing + response formatting
- `{feature}.service.ts` — business logic (orchestration)
- `{feature}.schema.repository.ts` — Prisma data access layer
- `{feature}.dto.ts` — Zod schemas + inferred types
- `{feature}.service.test.ts`, `{feature}.routes.test.ts`, `{feature}.schema.repository.test.ts`

### Dependency Flow
- Routes → Controller → Service → Repository → Prisma
- Controllers never call repositories directly
- Services never format HTTP responses
- Controllers perform Zod validation via DTO schemas (not services)
- Controllers never write inline JSON errors — throw typed exceptions or `next(err)`

### Controller Pattern
- Static methods (class) or standalone exported functions
- `try/catch` wrapping with `next(err)` delegation
- Response envelope: `{ success, data, error, meta }`
- Zod validation via DTO schemas at controller entry
- Keep under 30 lines

### Response Envelope
- Success: `{ success: true, data: T, error: null, meta: { version } }`
- Error: `{ success: false, data: null, error: { message, code, status, details } }`

### Service Pattern
- Static methods or standalone functions
- Zod validation at controller layer (not service)
- Throw domain exceptions for business logic failures
- Under 50 lines per method

### DTO / Zod Pattern
- One `dto.ts` per module
- Zod schemas define all API input validation
- Controllers call `.parse()` on DTO schemas to validate input
- Export inferred types: `type X = z.infer<typeof xSchema>`
- Use `z.literal()` for enum-like constraints

### Repository Pattern
- Static methods or standalone functions wrapping Prisma queries
- Safe-user projection: strip sensitive fields before returning
- Owner-check: `findFirst` with both `id` + `userId` filters
- Filename suffix: `.schema.repository.ts`

### Exception Pattern
- Base class: `AppException` extends `Error` — code, status, details fields
- Domain exception files with static factory methods
- `throw AuthException.invalidCredentials()` — never `throw new AuthException(...)`
- One exception file per domain, not per error type
- Error middleware order: `AppException` → `ZodError` (400 with field details) → unknown (500)

### Middleware
- Auth: Bearer token extraction → JWT RS256 verification → `req.user` attachment
- Upload: multer memoryStorage, 50MB limit, PDF-only (mimetype + magic bytes)
- Error: global Express 4-arg handler, typed error → structured response

### Database Conventions
- All columns: snake_case with `@map()`
- All tables: plural snake_case with `@@map()`
- All IDs: `String @id @default(uuid())`
- Timestamps: `createdAt` (now), `updatedAt` (@updatedAt)
- Foreign keys: explicit `@map()`
- Indexes on foreign key columns
- Cascade deletes on all relations

---

## 📐 Coding Standards — Frontend

### Directory Structure
- `app/` — Next.js App Router pages (layout, login, dashboard, etc.)
- `components/{feature}/` — React components grouped by domain
- `lib/api/` — API client + TanStack Query hooks
- `lib/providers/` — ReduxProvider, QueryProvider
- `lib/exceptions/` — Frontend exception class
- `store/` — Redux Toolkit (auth slice)
- `__tests__/` — Test setup

### Component Patterns
- Interactive components: `'use client'`
- Default exports only
- PascalCase matching filename
- Under 100 lines (guideline)
- Accessibility: aria-label, role="alert", role="progressbar", aria-invalid, keyboard support

### Styling Options
- Inline style props, Tailwind CSS, CSS modules, styled-components/Emotion, CSS variables + design tokens

### State Management
- Client state: Redux Toolkit, Zustand, Jotai, MobX
- Server state: TanStack Query (standard)
- Forms: React Hook Form, Formik, TanStack Form

### API Client
- Axios instance with baseURL + timeout
- Request interceptor: attach Bearer token from localStorage
- Response interceptor: 401 → clear storage + redirect to /login
- SSR guard: `typeof window !== 'undefined'`

### API Hook Patterns
- Named `use{Resource}` or `use{Resource}With{Feature}`
- Response unwrapping: `response.data.data`
- Mutations return `response.data.data`
- Upload: `onUploadProgress` for progress tracking

### Error Handling
- `getApiErrorMessage(error)` helper that extracts message from Axios error response
- Display errors with `role="alert"`, red color
- Frontend exception class (optional)

---

## 📐 Coding Standards — Cross-Cutting

### Naming Conventions
| Element | Convention | Example |
|---------|------------|---------|
| Files | Dot notation (lowercase) | `auth.service.ts` |
| Classes | PascalCase matching filename | `AuthService` |
| Functions | camelCase | `getUserById` |
| Variables | camelCase | `authHeader` |
| Constants | UPPER_SNAKE_CASE | `BCRYPT_COST` |
| Types/Interfaces | PascalCase | `AuthenticatedRequest` |
| Booleans | is/has/can prefix | `isAuthenticated` |
| Repositories | `{module}.schema.repository.ts` | `auth.schema.repository.ts` |
| Test files | Co-located, same name + `.test.ts` | `auth.service.test.ts` |
| Directories | kebab-case | `auth/`, `file/` |
| Component exports | Default export only | `export default function LoginForm()` |

### Testing Standards
- Unit: Jest, Vitest — co-located `*.test.ts`
- Integration: Jest + Supertest (backend), Testing Library (frontend)
- E2E: Playwright (frontend), Cypress
- Visual Regression: Chromatic, Percy
- Mock external libs at module level with `jest.mock()`
- Use `jest.mocked()` for type safety
- NEVER call real DBs, JWT, bcrypt, S3, or fs in tests
- Coverage targets: service 90%+, routes 90%+, middleware 90%+, components 80%+

### Code Quality Rules
- DO: Follow existing patterns, Zod validation in controllers (not services), typed exceptions, async/await, strict TS, JSDoc, co-located tests
- DO: Extract shared logic to `utils/` (backend) or `lib/` (frontend)
- DO NOT: Business logic in controllers, console.log in production, cross-imports between services, skip tests, commit secrets, use `.then()` chains, change response envelope format, add TODO/placeholder code, create one exception file per error type

### Git Conventions
- Branch: `<type>/<short-description>` — types: feat, fix, chore, refactor, docs
- Commit: `<type>(<scope>): <description>` — scopes: backend, frontend, root, docs
- PR: title matches commit convention, description with what/why/how, link to artifacts, all tests pass, no console.log, no .env

### Architecture Principles
- Modules are independent — no cross-imports between modules
- Shared infrastructure at `src/` root
- Dependency direction: routes → controllers → services → repositories
- Prefer duplication over premature abstraction (extract after 3rd occurrence); document why duplication exists and when to remove it
- No shared types package between frontend and backend

### AI Agent Coding Rules
- Before: read rules.md, read engineering docs, read neighboring files, check deferred-decisions.md
- While: mirror module structure, use existing deps, use project abstractions, co-locate tests, no comments restating code
- After: verify compilation (tsc --noEmit), verify tests pass, update docs, update story artifacts
- Forbidden: console.log in production, sync I/O in handlers, business logic in controllers, per-error exception files, new state mgmt libs beyond RTK+TQ, `any` without justification, TODO placeholders, .env commits

---

## ⚡ What to Standardize Per Project

| Area | Backend | Frontend |
|------|---------|----------|
| Framework | — | — |
| API style | — | — |
| Styling | — | — |
| Components | — | — |
| Validation | — | — |
| ORM/Data | — | — |
| State (client) | — | — |
| State (server) | — | — |
| Forms | — | — |
| Auth | — | — |
| Logging | — | — |
| Testing | — | — |
| Realtime | — | — |
| Queue/Async | — | — |
| Cache | — | — |
| 3D/Graphics | — | — |
| AI | — | — |
| Monitoring | — | — |
| Hosting/Infra | — | — |
| CI/CD | — | — |
| Monorepo | — | — |
| Build tool | — | — |
| Runtime | — | — |
| Package mgr | — | — |
| Formatting | — | — |
| Architecture | — | — |
| Module structure | — | — |
| Controller pattern | — | — |
| Service pattern | — | — |
| Repository pattern | — | — |
| Exception pattern | — | — |
| Middleware pattern | — | — |
| DB conventions | — | — |
| Naming conventions | — | — |
| Styling approach | — | — |
| Error handling | — | — |
| Git conventions | — | — |
| AI coding rules | — | — |
