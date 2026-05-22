# Project Rules

This is the single authoritative reference for how the hyper-image-to-text-program codebase is structured and maintained. Every contributor (human or AI) must follow these rules.

---

## 1. Project Architecture

### Service Topology

```
Frontend (Next.js 14)  :3000  →  Backend (Express)  :3001  →  Image Processing (Express + LangGraph)  :3002
                                     ↕ Prisma                             ↕ Prisma
                               PostgreSQL 16                        MinIO (S3-compatible)
```

### Repository Structure (Monorepo, no workspace manager)

```
hyper-image-to-text-program/
├── backend/                    # Express API (CommonJS)
│   ├── src/
│   │   ├── app.ts              # Express setup
│   │   ├── server.ts           # Entry point
│   │   ├── exceptions/         # Typed exception classes
│   │   ├── middleware/          # Auth, upload, error handling
│   │   ├── modules/            # Feature modules (auth/, file/)
│   │   ├── types/              # Shared TS types (currently empty)
│   │   └── utils/              # Prisma client, S3 utils, validators
│   ├── prisma/
│   │   ├── schema.prisma       # Database schema
│   │   └── migrations/         # Prisma migrations (gitignored)
│   ├── keys/                   # RSA keypair for JWT
│   ├── .env                    # Backend env config
│   ├── jest.config.js
│   ├── tsconfig.json
│   └── package.json
├── frontend/                   # Next.js 14 App Router (ESM)
│   ├── src/
│   │   ├── app/                # App Router pages (layout, login, register, dashboard, upload, documents)
│   │   ├── components/         # React components (auth/, files/, layout/)
│   │   ├── lib/                # API client, hooks, providers, exceptions
│   │   └── store/              # Redux Toolkit (auth slice)
│   │   └── __tests__/          # Test setup
│   ├── e2e/                    # Playwright E2E tests
│   ├── jest.config.cjs
│   ├── tsconfig.json
│   └── package.json
├── image-processing-service/   # Scaffolded only (no src/ yet)
├── docker-compose.yml          # PostgreSQL 16 + MinIO + all services
├── .husky/pre-commit           # Config safety hook
├── .configignore               # Files that get .example templates
└── docs/                       # Engineering docs, OpenAPI spec
```

### Module Boundaries

Backend modules are independent — no cross-imports between modules. Shared infrastructure lives at `src/` root.

Frontend feature directories are independent — no cross-imports between component feature directories.

---

## 2. Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Files | Dot notation (lowercase) | `auth.service.ts`, `error.middleware.ts` |
| Classes (default export) | PascalCase matching filename | `AuthService`, `UserException` |
| Functions | camelCase | `getUserById`, `handleLogout` |
| Variables | camelCase | `authHeader`, `passwordHash` |
| Constants | UPPER_SNAKE_CASE | `BCRYPT_COST`, `JWT_EXPIRES_IN` |
| Types/Interfaces | PascalCase | `AuthenticatedRequest`, `LoginInput` |
| Enums (TS) | PascalCase | `DocumentStatus`, `ConversionStatus` |
| Enums (DB) | SCREAMING_SNAKE_CASE | `UPLOADED`, `PROCESSING`, `COMPLETED`, `FAILED` |
| Booleans | `is`/`has`/`can` prefix | `isAuthenticated`, `hasErrors`, `canDownload` |
| Repository files | `{module}.schema.repository.ts` | `auth.schema.repository.ts` |
| Test files | Co-located, same name + `.test.ts` | `auth.service.test.ts` next to `auth.service.ts` |
| Directories | kebab-case | `auth/`, `file/`, `image-processing-service/` |
| Component exports | Default export only | `export default function LoginForm()` |
| Git branches | `<type>/<short-description>` | `feat/pdf-upload-progress` |
| Commits | `<type>(<scope>): <description>` | `feat(backend): add POST /api/v1/auth/register` |

---

## 3. Backend — Complete Reference

### 3.1 Module File Structure

```
modules/{feature}/
├── {feature}.routes.ts               # Express Router, middleware chains
├── {feature}.controller.ts           # Request parsing + response formatting
├── {feature}.service.ts              # Business logic (orchestration)
├── {feature}.schema.repository.ts    # Prisma data access layer
├── {feature}.dto.ts                  # Zod schemas + inferred types
├── {feature}.service.test.ts         # Unit tests (mocked repo/externals)
├── {feature}.routes.test.ts          # Integration tests (supertest)
└── {feature}.schema.repository.test.ts  # Repository unit tests (mocked prisma)
```

### 3.2 Dependency Flow

```
Routes → Controller → Service → Repository → Prisma
                              ↘ Exceptions
Middleware (auth, upload) → next(err) → errorMiddleware
```

- Controllers never call repositories directly.
- Services never format HTTP responses.
- Controllers never write inline JSON error responses — always throw typed exceptions or pass to `next(err)`.

### 3.3 Routes Pattern

```typescript
import { Router } from 'express';
import AuthController from './auth.controller';
import authMiddleware from '../../middleware/auth.middleware';

const router = Router();
router.post('/register', AuthController.registerHandler);
router.get('/me', authMiddleware, someHandler);
export default router;
```

- All routes use default exports.
- Routes define the middleware chain: `[auth,] [upload,] handler`.
- API prefix is `/api/v1/{module}` (set in `app.ts`).

### 3.4 Controller Pattern

```typescript
export default class AuthController {
  static async registerHandler(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const user = await AuthService.register(req.body);
      res.status(201).json({ success: true, data: { ... }, error: null, meta: { version: '1.0.0' } });
    } catch (err) {
      next(err);
    }
  }
}
```

- Controllers are classes with static methods. **OR** they can be standalone exported functions (see `file.controller.ts` for the function-based variant).
- Response envelope: `{ success: boolean, data: T | null, error: null | { message, code, status, details }, meta?: { version: '1.0.0' } }`.
- Controllers must be kept under 30 lines.

### 3.5 Response Envelope

**Success:**
```json
{ "success": true, "data": { ... }, "error": null, "meta": { "version": "1.0.0" } }
```

**Error:**
```json
{ "success": false, "data": null, "error": { "message": "...", "code": "...", "status": 409, "details": {} } }
```

### 3.6 Service Pattern

```typescript
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import AuthSchemaRepository from './auth.schema.repository';
import UserException from '../../exceptions/UserException';
import { registerSchema, RegisterInput } from './auth.dto';

const BCRYPT_COST = 5;

export default class AuthService {
  static async register(input: RegisterInput) {
    const parsed = registerSchema.parse(input);
    // ... business logic
    throw UserException.alreadyRegistered();
  }
}
```

- Services are classes with static methods.
- Zod validation happens at the service layer (not controller).
- Business exceptions are thrown from services.
- Services are under 50 lines per method.
- Email normalization: always lowercase + trim.

### 3.7 DTO / Zod Pattern

```typescript
import { z } from 'zod';

export const registerSchema = z.object({
  email: z.string().email('Invalid email format'),
  password: z.string().min(8, 'Password must be at least 8 characters'),
});

export type RegisterInput = z.infer<typeof registerSchema>;
```

- One `dto.ts` per module.
- Zod schemas define all API input validation.
- Inferred types are exported for reuse.
- Use `z.literal()` for enum-like constraints (see `file.dto.ts`).

### 3.8 Repository Pattern

```typescript
import prisma from '../../utils/prisma';

export type CreateUserData = { email: string; passwordHash: string; };
export type SafeUser = Omit<User, 'passwordHash'>;

export default class AuthSchemaRepository {
  static async create(data: CreateUserData): Promise<User> {
    return prisma.user.create({ data });
  }

  static toSafeUser(user: User): SafeUser {
    const { passwordHash, ...safe } = user;
    return safe;
  }

  static async findByEmail(email: string): Promise<User | null> {
    return prisma.user.findUnique({ where: { email } });
  }
}
```

- Can be a class with static methods OR standalone exported functions (see `file.schema.repository.ts` for the function variant).
- Repository layer wraps Prisma queries — services stay agnostic of the database driver.
- Owner-check pattern: `findFirst` with both `id` and `userId` filters (see `file.schema.repository.ts`).
- Filename suffix `.schema.repository.ts` for SQL (schema-based) databases.

### 3.9 Exception Pattern

**Base (`AppException.ts`):**
```typescript
export default class AppException extends Error {
  public readonly code: string;
  public readonly status: number;
  public readonly details?: Record<string, unknown>;
  constructor(message: string, code: string, status: number, details?: Record<string, unknown>) {
    super(message);
    this.code = code;
    this.status = status;
    this.details = details;
    this.name = this.constructor.name;
  }
}
```

**Domain Exception (`AuthException.ts`):**
```typescript
export default class AuthException extends AppException {
  constructor(message, code, status, details?) { super(message, code, status, details); }

  static invalidCredentials(): AuthException {
    return new AuthException('Invalid email or password', 'INVALID_CREDENTIALS', StatusCodes.UNAUTHORIZED);
  }
  static tokenExpired(): AuthException { ... }
  static noToken(): AuthException { ... }
  static invalidToken(): AuthException { ... }
}
```

Rules:
- All exceptions extend `AppException`.
- One exception file per domain with static factory methods.
- Use static factories everywhere: `throw AuthException.invalidCredentials()`, never `throw new AuthException(...)`.
- Use `AppException` directly only inside exception class files.
- Exception factories live in `src/exceptions/`.

**Current exception classes:**
| File | Exceptions |
|------|-----------|
| `AuthException.ts` | `invalidCredentials()` (401), `tokenExpired()` (401), `noToken()` (401), `invalidToken()` (401) |
| `UserException.ts` | `alreadyRegistered()` (409), `notFound(id?)` (404), `validationFailed(details)` (400) |
| `FileException.ts` | `missingFile()` (400), `tooLarge()` (413), `invalidType()` (400), `multerError(field,code)` (400), `unauthorized()` (401), `documentNotFound()` (404), `notDownloadable()` (400), `conversionNotFound()` (404) |

### 3.10 Middleware

**Auth Middleware (`auth.middleware.ts`):**
- Extracts Bearer token from `Authorization` header.
- Verifies JWT with RS256 using public key (`fs.readFileSync` on every request — known tech debt).
- Attaches `req.user = { id, email }` to `AuthenticatedRequest`.
- Handles: missing header, non-Bearer format, expired token, invalid signature, string decoded.
- Exports `AuthenticatedRequest` interface extending `Request`.

**Upload Middleware (`upload.middleware.ts`):**
- Uses `multer` with `memoryStorage()`.
- 50MB file size limit.
- File filter: only `application/pdf` mimetype.
- `handleFileUpload(fieldName)` factory returns Express middleware.
- Handles `MulterError` (LIMIT_FILE_SIZE) and custom errors, passes typed `FileException` to `next(err)`.

**Error Middleware (`error.middleware.ts`):**
- Global Express error handler (4-arg signature).
- Order: `AppException` (semantic) → `ZodError` (400 with field-level details) → everything else (500).
- `AppException` → `{ success: false, data: null, error: { message, code, status, details } }`.
- `ZodError` → 400 with `validationFailed` details.
- Unknown errors → 500 INTERNAL_ERROR (with `console.error` — known tech debt).

### 3.11 Utility Files

**`prisma.ts`:**
```typescript
import { PrismaClient } from '../generated/prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL! });
const prisma = new PrismaClient({ adapter });
export default prisma;
```
- Singleton PrismaClient with `@prisma/adapter-pg` driver adapter.
- Prisma output directory: `src/generated/prisma/`.

**`s3.utils.ts`:**
- MinIO-compatible S3 client (AWS SDK v3).
- `ensureBucket()` auto-creates `uploads` bucket.
- `uploadFile(key, buffer, mimeType)` — PUT object.
- `deleteFile(key)` — DELETE object.
- `generatePresignedUrl(key, expiresIn=3600)` — GET presigned URL.
- `forcePathStyle: true` for MinIO compatibility.
- Defaults: localhost:9000, minioadmin/minioadmin.

**`validator.utils.ts`:**
- `validatePdf(buffer)` checks PDF magic bytes (`%PDF` = `0x25 0x50 0x44 0x46`).
- Returns `{ valid: boolean, error?: string }`.

### 3.12 Entry Points

**`app.ts`** — Express app setup:
```typescript
const app = express();
app.use(cors());
app.use(express.json());
app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/files', fileRoutes);
app.use(errorMiddleware);
export default app;
```

**`server.ts`** — Startup:
```typescript
async function main() {
  await prisma.$connect();
  app.listen(PORT, () => console.log(`Backend server running on port ${PORT}`));
}
main().catch((err) => { console.error('Failed to start server:', err); process.exit(1); });
```
- SIGTERM/SIGINT handlers disconect Prisma.
- `unhandledRejection` handler logs the error.

### 3.13 API Routes (v1)

| Method | Path | Auth | Handler |
|--------|------|------|---------|
| POST | `/api/v1/auth/register` | No | `AuthController.registerHandler` → `AuthService.register` |
| POST | `/api/v1/auth/login` | No | `AuthController.loginHandler` → `AuthService.login` |
| GET | `/api/v1/auth/me` | Yes | Inline handler (returns user from decoded JWT) |
| POST | `/api/v1/files/upload` | Yes | `fileController.upload` → `fileService.uploadPdf` (multer `file` field) |
| GET | `/api/v1/files` | Yes | `fileController.getDocuments` → `fileService.getDocumentsByUserId` |
| GET | `/api/v1/files/:documentId/conversions` | Yes | `fileController.getDocumentConversions` → `fileService.getDocumentWithConversions` |
| GET | `/api/v1/files/conversions/:conversionId/download` | Yes | `fileController.downloadConversion` → `fileService.getFileDownloadUrl` |

---

## 4. Frontend — Complete Reference

### 4.1 Directory Structure

```
src/
├── app/                    # Next.js 14 App Router
│   ├── layout.tsx           # Root layout (server component)
│   ├── login/page.tsx       # 'use client'
│   ├── register/page.tsx    # Server component (RegisterForm is client)
│   ├── dashboard/page.tsx   # 'use client', ProtectedRoute
│   ├── upload/page.tsx      # 'use client', ProtectedRoute
│   ├── documents/page.tsx   # 'use client', ProtectedRoute
│   └── documents/[id]/page.tsx  # 'use client', ProtectedRoute
├── components/
│   ├── auth/
│   │   ├── LoginForm.tsx
│   │   ├── RegisterForm.tsx
│   │   ├── ProtectedRoute.tsx
│   │   └── SessionRestore.tsx
│   ├── files/
│   │   ├── FileUpload.tsx
│   │   ├── DocumentList.tsx
│   │   └── ConversionHistory.tsx
│   └── layout/
│       └── Header.tsx
├── lib/
│   ├── api/
│   │   ├── client.ts        # Axios instance with interceptors
│   │   ├── useDocuments.ts  # TanStack Query hook
│   │   ├── useUpload.ts     # TanStack Query mutation hook
│   │   └── useConversions.ts # TanStack Query hook
│   ├── providers/
│   │   ├── ReduxProvider.tsx
│   │   └── QueryProvider.tsx
│   └── exceptions/
│       └── AppException.ts  # Frontend error class (no code/status)
├── store/
│   ├── index.ts             # configureStore
│   └── authSlice.ts         # Redux slice (token, user, isAuthenticated)
└── __tests__/
    └── setup.ts             # @testing-library/jest-dom import
```

### 4.2 App Router Patterns

**Root Layout (`layout.tsx`):**
- Server component (no `'use client'`).
- Wraps children in: `ReduxProvider` → `SessionRestore` → `Header` → `QueryProvider`.
- Metadata exported as `const metadata: Metadata`.

**Page composition:**
- Pages import components and data hooks directly.
- Protected pages wrap content in `<ProtectedRoute>`.
- No `loading.tsx`, `error.tsx`, or segment-specific layouts exist.

**Protected route pattern:**
```typescript
'use client';
import ProtectedRoute from '@/components/auth/ProtectedRoute';
import SomeComponent from '@/components/...';

export default function ProtectedPage() {
  return (
    <ProtectedRoute>
      <main>
        <SomeComponent />
      </main>
    </ProtectedRoute>
  );
}
```

**Login page guards authenticated users:**
```typescript
const { isAuthenticated } = useSelector((state: RootState) => state.auth);
useEffect(() => { if (isAuthenticated) router.push('/dashboard'); }, [isAuthenticated, router]);
if (isAuthenticated) return null;
```

### 4.3 Component Patterns

- All interactive components use `'use client'`.
- Default exports only.
- PascalCase names matching filename.
- Components under 100 lines (guideline).

**Styling:**
- **Inline `style` props exclusively** — NO Tailwind classes, NO CSS modules, NO CSS-in-JS libraries.
- Color palette: primary `#3b82f6` (blue), success `#16a34a` (green), error `#dc2626` (red), gray `#6b7280`, border `#e5e7eb`.

**Accessibility requirements:**
- `aria-label` on interactive elements (forms, buttons, upload zones).
- `role="alert"` on error messages.
- `role="progressbar"` with `aria-valuenow/min/max` on progress indicators.
- `aria-invalid` and `aria-describedby` on invalid form fields.
- `noValidate` on forms (custom validation).
- Keyboard support: `tabIndex={0}`, `onKeyDown` for Enter/Space on clickable divs.

### 4.4 State Management

**Redux Toolkit** (client state):
- Single `auth` reducer in `store/authSlice.ts`.
- State: `{ token: string | null, user: { id, email } | null, isAuthenticated: boolean }`.
- Persisted to localStorage keys: `auth_token`, `auth_user`.
- JWT expiry checked at load: `atob(token.split('.')[1])` for base64-decoded payload.
- Actions: `loginSuccess`, `logout`, `restoreSession`.
- Store exports `RootState` and `AppDispatch` types.

**TanStack React Query** (server state):
- All API data fetching via `useQuery` / `useMutation`.
- Query keys: `['documents']`, `['conversions', documentId]`.
- Mutations: upload, download conversion.
- QueryClient created lazily in `QueryProvider` (singleton per session).

### 4.5 API Client Pattern

```typescript
import axios from 'axios';

const apiClient = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001/api/v1',
  timeout: 10000,
  headers: { 'Content-Type': 'application/json' },
});

apiClient.interceptors.request.use((config) => {
  if (typeof window !== 'undefined') {
    const token = localStorage.getItem('auth_token');
    if (token) config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401 && typeof window !== 'undefined') {
      localStorage.removeItem('auth_token');
      localStorage.removeItem('auth_user');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  },
);

export default apiClient;
```

- Import alias: `import apiClient from '@/lib/api/client'`.
- `typeof window !== 'undefined'` guard for SSR safety.
- 401 response → clears localStorage + redirects to `/login`.

### 4.6 API Hook Patterns

```typescript
'use client';
import { useQuery } from '@tanstack/react-query';
import apiClient from './client';

export function useDocuments() {
  return useQuery({
    queryKey: ['documents'],
    queryFn: async () => {
      const response = await apiClient.get<{ success: boolean; data: Document[] }>('/files');
      return response.data.data;
    },
  });
}
```

- Hooks are named `use{Resource}` or `use{Resource}With{Feature}`.
- Types/interfaces defined in the same file.
- Response unwrapping: always `response.data.data`.
- Mutations return `response.data.data`.
- Upload hook uses `onUploadProgress` for progress tracking (120s timeout).

### 4.7 Error Handling (Frontend)

```typescript
function getApiErrorMessage(error: unknown): string {
  if (error && typeof error === 'object' && 'response' in error) {
    const axiosErr = error as { response?: { data?: { error?: { message?: string } } } };
    return axiosErr.response?.data?.error?.message || 'An error occurred';
  }
  return 'An error occurred';
}
```

- `AppException` class exists in `lib/exceptions/` but is **not currently used**.
- Inline error handling via `getApiErrorMessage()` helper in components.
- Error messages displayed with `role="alert"` and red color (`#dc2626`).

---

## 5. Database (Prisma)

### Schema Overview

```prisma
generator client { provider = "prisma-client"; output = "../src/generated/prisma"; }
datasource db { provider = "postgresql"; }

model User {
  id           String     @id @default(uuid())
  email        String     @unique
  passwordHash String     @map("password_hash")
  createdAt    DateTime   @default(now()) @map("created_at")
  updatedAt    DateTime   @updatedAt @map("updated_at")
  documents    Document[]
  @@map("users")
}

model Document {
  id           String         @id @default(uuid())
  userId       String         @map("user_id")
  filename     String
  originalName String         @map("original_name")
  mimeType     String         @map("mime_type")
  fileSize     Int            @map("file_size")
  storageKey   String         @map("storage_key")
  status       DocumentStatus @default(UPLOADED)    // UPLOADED | PROCESSING | COMPLETED | FAILED
  createdAt    DateTime       @default(now()) @map("created_at")
  updatedAt    DateTime       @updatedAt @map("updated_at")
  user         User           @relation(fields: [userId], references: [id], onDelete: Cascade)
  conversions  Conversion[]
  @@index([userId])
  @@map("documents")
}

model Conversion {
  id               String           @id @default(uuid())
  documentId       String           @map("document_id")
  status           ConversionStatus @default(PROCESSING)  // PROCESSING | COMPLETED | FAILED
  totalPages       Int?             @map("total_pages")
  completedPages   Int?             @map("completed_pages")
  outputStorageKey String?          @map("output_storage_key")
  errorMessage     String?          @map("error_message")
  startedAt        DateTime         @default(now()) @map("started_at")
  completedAt      DateTime?        @map("completed_at")
  createdAt        DateTime         @default(now()) @map("created_at")
  updatedAt        DateTime         @updatedAt @map("updated_at")
  document         Document         @relation(fields: [documentId], references: [id], onDelete: Cascade)
  @@index([documentId])
  @@map("conversions")
}
```

### Conventions
- All column names: `snake_case` with `@map()`.
- All table names: plural `snake_case` with `@@map()`.
- All IDs: `String @id @default(uuid())`.
- All timestamps: `createdAt` (default `now()`), `updatedAt` (`@updatedAt`).
- Foreign keys: explicit `@map("snake_case")`.
- Indexes: `@@index([userId])`, `@@index([documentId])`.
- Cascade deletes on all relations.

### Migration Commands
```bash
npx prisma generate      # Generates client to src/generated/prisma/
npx prisma migrate dev   # Creates + applies migration
```

---

## 6. Auth & Security

### Authentication Flow
1. User registers → bcrypt hash (cost 5) stored in `users.password_hash`.
2. User logs in → compare hash → RS256 JWT signed with private key.
3. JWT payload: `{ sub: userId, email }`, expiry from `JWT_EXPIRY_SECONDS` (default 604800 = 7 days).
4. Frontend stores token in localStorage key `auth_token`.
5. Every request: `Authorization: Bearer <token>` header via Axios interceptor.
6. Backend verifies JWT with public key via `authMiddleware`.

### JWT Configuration
- Algorithm: RS256 (asymmetric RSA keypair).
- Keys stored in `backend/keys/private.pem` and `backend/keys/public.pem`.
- Stats: JWT is stateless — no server-side session store.
- Known tech debt: `fs.readFileSync` on every request for key loading.

### File Upload
- Multer memory storage, 50MB limit.
- PDF-only: mimetype filter (middleware) + magic byte validation (service layer).
- Storage key pattern: `users/{userId}/{uuid}-{sanitizedFilename}`.
- S3/MinIO upload with auto bucket creation.
- S3 rollback on DB failure (delete S3 object if DB write fails).

---

## 7. Testing Strategy

### Test Levels

| Level | Tool | Location | Scope |
|-------|------|----------|-------|
| Unit | Jest | Co-located `*.test.ts` | Service logic, utilities, slices |
| Integration (routes) | Jest + Supertest | Co-located `*.test.ts` | HTTP endpoints with mocked dependencies |
| E2E | Playwright | `frontend/e2e/` | Full user flows (browser) |

### Running Tests
```bash
cd backend && npm test                    # Backend unit + integration
cd frontend && npm test                   # Frontend unit + component
cd frontend && npm run test:e2e           # Frontend E2E (Playwright)
```

### Backend Test Patterns

**Service tests** (`auth.service.test.ts`):
```typescript
jest.mock('./auth.schema.repository');
jest.mock('bcryptjs', () => ({ hash: jest.fn(), compare: jest.fn() }));
jest.mock('jsonwebtoken', () => ({ sign: jest.fn() }));
jest.mock('fs', () => ({ ...jest.requireActual('fs'), readFileSync: jest.fn() }));

const MockedRepo = jest.mocked(AuthSchemaRepository);
// Mock external libraries at module level
// Use jest.mocked() for type safety
// Clear mocks in beforeEach: jest.clearAllMocks()
// Test success + error paths + edge cases (email normalization, P2002 race condition)
```

**Route tests** (`auth.routes.test.ts`):
```typescript
jest.mock('./auth.service', () => ({
  __esModule: true,
  default: { register: jest.fn(), login: jest.fn() },
}));

const app = express();
app.use(express.json());
app.use('/api/v1/auth', authRoutes);
app.use(errorMiddleware);
// Use supertest: request(app).post('/api/v1/auth/register').send({...})
// Test: 200/201 success, 400/401/409 errors, 500 unexpected
```

**Middleware tests** (`auth.middleware.test.ts`):
```typescript
function createReq(headers): Request { return { headers } as Request; }
function createRes(): Response {
  const res: Partial<Response> = {};
  res.status = jest.fn().mockReturnValue(res);
  res.json = jest.fn().mockReturnValue(res);
  return res as Response;
}
// Test each branch: valid token, missing header, non-Bearer, expired, invalid, string decoded
```

### Frontend Test Patterns

**Store tests** (`authSlice.test.ts`):
- Pure reducer tests: `const state = authReducer(initialState, loginSuccess({ token, user }))`.
- Helper functions: `createMockToken(expiresInMs)` creates fake JWT with `btoa()`.
- `beforeEach` clears localStorage.
- Test: initial state, each action, edge cases (expired, missing, malformed).

**Component tests** (`FileUpload.test.tsx`):
```typescript
function renderWithProviders(ui: React.ReactElement) {
  const queryClient = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  return render(<QueryClientProvider client={queryClient}>{ui}</QueryClientProvider>);
}
```
- Mock hooks with `jest.mock('@/lib/api/useDocuments', ...)`.
- Helper: `selectFile(file)` using `document.querySelector` + `fireEvent.change`.
- Test: render, interaction, validation error, conditional rendering.

### E2E Test Pattern
```typescript
const TEST_USER = { email: `e2e-test-${Date.now()}@example.com`, password: 'TestPass123' };
// Unique email per run (Date.now())
// Playwright webServer config auto-starts backend + frontend
// Test: register → login → dashboard, logout → redirect, unauthenticated redirect
```

### Mocking Rules
- Mock external libraries at the top of test file with `jest.mock()`.
- Use `jest.mocked()` for type-safe mocks.
- Clear mocks in `beforeEach`: `jest.clearAllMocks()`.
- For route tests, mock the entire service module.
- NEVER call real databases, JWT, bcrypt, S3, or file system in tests.
- Frontend: localStorage is available in jsdom environment.

### Coverage Expectations
| Metric | Target |
|--------|--------|
| Service layer | 90%+ |
| Route handlers | 90%+ |
| Middleware | 90%+ |
| Frontend slices | 90%+ |
| Frontend components | 80%+ |
| E2E critical flows | 100% pass |

---

## 8. Known Tech Debt

| Issue | Location | Impact |
|-------|----------|--------|
| Synchronous `fs.readFileSync` for JWT keys on every request | `auth.middleware.ts:58`, `auth.service.ts:88` | Blocks event loop on every authenticated request |
| `console.error` for error logging | `error.middleware.ts:59`, `server.ts:7` | No structured logging, no log levels |
| No ESLint configuration files | Root, backend, frontend | Lint scripts exist but no config — they do nothing |
| `SessionRestore` component is redundant | `frontend/src/components/auth/SessionRestore.tsx` | `loadPersistedAuth()` already runs at module scope in `authSlice` initial state |
| No server-side JWT invalidation on logout | Backend auth module | Tokens remain valid until expiry |
| `/register` page not guarded for authenticated users | `frontend/src/app/register/page.tsx` | Authenticated users can visit /register |
| No CI workflows | `.github/workflows/` missing | Tests not automatically run |
| image-processing-service has no `src/` | `image-processing-service/` | Only `package.json` and `tsconfig.json` exist |
| `backend/types/` directory is empty | `backend/src/types/` | Planned for shared types but never populated |
| `src/tests/` directory is empty | `src/tests/` | Root test directory exists but unused |
| Module type inconsistency | All packages | Frontend + image-processing-service use `"type": "module"`, backend uses CommonJS |
| No Tailwind CSS config files | Frontend | Tailwind in package.json but no config, all styling is inline |
| `AppException` in frontend not used | `frontend/src/lib/exceptions/AppException.ts` | Class defined but never imported or thrown |

---

## 9. Tooling & Scripts

### Backend (`backend/package.json`)
| Script | Command |
|--------|---------|
| `npm run dev` | `nodemon src/server.ts` |
| `npm run build` | `tsc` |
| `npm start` | `node dist/server.js` |
| `npm test` | `jest` |
| `npm run lint` | `eslint src --ext .ts` (no config — effectively no-op) |
| `npm run prisma:generate` | `prisma generate` |
| `npm run prisma:migrate` | `prisma migrate dev` |

### Frontend (`frontend/package.json`)
| Script | Command |
|--------|---------|
| `npm run dev` | `next dev` |
| `npm run build` | `next build` |
| `npm start` | `next start` |
| `npm test` | `jest` |
| `npm run test:e2e` | `playwright test` |
| `npm run lint` | `next lint` |

### Root
| Script | Command |
|--------|---------|
| `npm run prepare` | `husky` (installs git hooks) |

### Infrastructure
- **Node.js:** 24.13.0 (pinned via Volta in all `package.json`)
- **Docker Compose:** PostgreSQL 16 + MinIO + all 3 services
- **No CI pipeline** yet (deferred)

---

## 10. Environment & Configuration

### Backend `.env`
```
DATABASE_URL="postgresql://postgres:postgres@127.0.0.1:5432/hyper_image_to_text"
JWT_SECRET_PRIVATE_PATH="./keys/private.pem"
JWT_SECRET_PUBLIC_PATH="./keys/public.pem"
JWT_EXPIRY_SECONDS=604800
PORT=3001
NODE_ENV=development
CORS_ORIGIN=http://localhost:3000
```

### Frontend
- Only env var: `NEXT_PUBLIC_API_URL` (defaults to `http://localhost:3001/api/v1`).
- No `.env` or `.env.example` file exists.

### Config Safety System
- `.configignore` lists files that should never be committed (`.env`, `*.pem`, `*.key`, etc.).
- Husky pre-commit hook reads `.configignore`, generates `{filename}.example` templates with placeholder values.
- `.gitignore` excludes actual config files but NOT `.example` files.
- `.example` files ARE committed as onboarding templates.

---

## 11. Git Conventions

### Branch Naming
```
<type>/<short-description>
```
Types: `feat/`, `fix/`, `chore/`, `refactor/`, `docs/`

### Commit Message Format
```
<type>(<scope>): <short description>
```
Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`, `style`
Scopes: `backend`, `frontend`, `image-processing`, `root`, `docs`

Examples:
```
feat(backend): add POST /api/v1/auth/register endpoint
fix(frontend): handle expired token redirect loop
```

### PR Expectations
- Title matches commit convention format.
- Description: what changed, why, how to test.
- Link to story artifact in `_bmad-output/implementation-artifacts/`.
- All tests pass before requesting review.
- No `console.error`/`console.log` in new production code.
- No `.env` files committed.

---

## 12. Code Quality & Style Rules

### DO
- Follow existing patterns — co-located tests, dot-notation filenames, default exports.
- Add Zod schemas for all API inputs.
- Use typed exception classes with static factory methods.
- Add tests for new modules (unit + route).
- Use `async/await` — no raw `.then()` chains.
- Use `strict: true` TypeScript — no `any` without justification comment.
- Add JSDoc for public API of classes.
- Extract shared logic to `src/utils/` (backend) or `src/lib/` (frontend).
- Prefer duplication over premature abstraction (extract after 3rd occurrence).

### DO NOT
- Put business logic in controllers (controllers delegate to services).
- Add `console.error`/`console.log` in new production code.
- Import from `backend/` code in `frontend/` or vice versa.
- Skip tests for new endpoints or service methods.
- Commit secrets, `.env` files, or `*.pem`/`*.key` files.
- Use `.then()` or `.catch()` chains — always `async/await`.
- Change the API response envelope format (`{ success, data, error, meta }`).
- Create new exception files for each error type (one per domain).
- Add TODO comments or placeholder code.
- Create a shared types package between frontend and backend.

---

## 13. Documentation Maintenance

When making changes, update:
- **API endpoints** → `docs/backend/openapi.yaml`
- **Module structure** → `docs/{service}/index.md`
- **Architecture patterns** → `docs/engineering/architecture.md`
- **Story artifacts** → `_bmad-output/implementation-artifacts/{story}.md`
- **Sprint status** → `_bmad-output/implementation-artifacts/sprint-status.yaml`
- **New deferred work** → `docs/engineering/deferred-decisions.md`

---

## 14. Image Processing Service

- Location: `image-processing-service/`.
- Dependencies: express, @langchain/langgraph, @langchain/openai, @prisma/client, zod, pdf-lib, sharp, langchain.
- Port: 3002.
- **Currently scaffolded only** — `package.json` and `tsconfig.json` exist, no `src/` code.
- Type: `"module": "ESM"`.

---

## 15. AI Agent Coding Rules

### Before writing code
1. Read this `rules.md` file.
2. Read the relevant engineering docs (`coding-standards.md`, `architecture.md`).
3. Read neighboring files in the same module to understand existing patterns.
4. Check `docs/engineering/deferred-decisions.md` — verify the task isn't already parked.

### While writing code
1. Mirror existing module structure exactly.
2. Use existing dependencies — do not add new packages if an existing one works.
3. Use project-specific abstractions (`AppException` subclasses, not generic `Error`).
4. Co-locate tests next to every new source file.
5. Follow naming conventions exactly.
6. Do not add comments that restate what code does.

### After writing code
1. Verify compilation: `npx tsc --noEmit` in the affected service.
2. Verify tests pass: `npm test` in the affected service.
3. Update documentation if API, module structure, or architecture changed.
4. Update story artifacts in `_bmad-output/implementation-artifacts/`.

### Forbidden patterns
1. No `console.error`/`console.log` in new production code.
2. No synchronous I/O in request handlers.
3. No business logic in controllers.
4. No new exception files per error type (one per domain).
5. No new state management libraries (Redux Toolkit + TanStack Query only).
6. No `any` types without justification comment.
7. No TODO comments or placeholder code.
8. No `.env` files or secrets committed.
