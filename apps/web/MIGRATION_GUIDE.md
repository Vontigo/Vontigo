# Drizzle ORM + TypeScript + Domain-Driven Design Migration

This document describes the enhanced architecture using Drizzle ORM, strict TypeScript, and Domain-Driven Design patterns.

## Architecture Overview

### Directory Structure

```
src/
├── domain/                     # Domain layer (business logic)
│   ├── user/
│   │   ├── User.ts            # User entity
│   │   ├── UserRepository.ts  # Repository interface
│   │   └── UserService.ts     # Domain service
│   ├── post/
│   ├── newsletter/
│   └── shared/
├── infrastructure/             # Infrastructure layer (data access)
│   ├── db/
│   │   ├── schema/            # Drizzle schema definitions
│   │   │   ├── user.ts
│   │   │   ├── post.ts
│   │   │   └── ...
│   │   ├── migrations/        # Database migrations
│   │   └── drizzleClient.ts   # Database client setup
│   └── repositories/          # Repository implementations
│       └── DrizzleUserRepository.ts
├── application/               # Application layer (use cases)
│   ├── useCases/
│   │   └── RegisterUser.ts
│   ├── services/
│   └── Container.ts           # Dependency injection
└── routes/                    # API endpoints (presentation layer)
```

## Key Features

### 1. **Type-Safe Database Access**

- Uses Drizzle ORM for type-safe database queries
- Auto-generated TypeScript types from schema
- Compile-time query validation

```typescript
// Type-safe query example
const users = await db.select().from(users).where(eq(users.email, email));
```

### 2. **Domain-Driven Design**

- **Entities**: Rich domain objects with business logic
- **Repositories**: Abstract data access patterns
- **Services**: Domain business logic
- **Value Objects**: Validated data types

```typescript
// Domain entity example
export class User {
  updateProfile(updates: ProfileUpdates): User {
    // Business logic here
    return new User(/* updated data */);
  }
  
  isActive(): boolean {
    return this.status === 'active';
  }
}
```

### 3. **Strict TypeScript Configuration**

Enhanced `tsconfig.json` with:
- `strict: true`
- `noImplicitAny: true`
- `strictNullChecks: true`
- `noUncheckedIndexedAccess: true`
- `exactOptionalPropertyTypes: true`

### 4. **Validation with Zod**

All input data is validated using Zod schemas:

```typescript
export const EmailSchema = z.string().email().max(191);
export const UserNameSchema = z.string().min(1).max(191);
```

### 5. **Dependency Injection**

Simple container for managing dependencies:

```typescript
const container = Container.getInstance();
const userService = container.getUserService();
```

## Usage Examples

### Creating a New User

```typescript
// Use case layer
const registerUserUseCase = container.getRegisterUserUseCase();
const result = await registerUserUseCase.execute({
  name: 'John Doe',
  email: 'john@example.com',
  password: 'securepassword'
});
```

### Querying Users

```typescript
// Domain service layer
const userService = container.getUserService();
const users = await userService.getAllUsers({
  limit: 10,
  orderBy: 'createdAt',
  order: 'desc'
});
```

### API Endpoint

```typescript
// Route handler
export const GET = async ({ url }) => {
  const container = Container.getInstance();
  const userService = container.getUserService();
  
  const users = await userService.getAllUsers();
  return json({ users });
};
```

## Database Schema

### User Schema

```typescript
export const users = pgTable('users', {
  id: varchar('id', { length: 24 }).primaryKey(),
  name: varchar('name', { length: 191 }).notNull(),
  email: varchar('email', { length: 191 }).notNull().unique(),
  // ... other fields
});

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
```

## Migration Strategy

### Phase 1: Setup (✅ Complete)
- [x] Strengthen TypeScript configuration
- [x] Install Drizzle ORM dependencies
- [x] Create domain structure
- [x] Define schemas and entities

### Phase 2: Implementation
- [ ] Migrate existing repositories
- [ ] Update API endpoints
- [ ] Add comprehensive tests
- [ ] Create migrations

### Phase 3: Cleanup
- [ ] Remove Knex dependencies
- [ ] Update documentation
- [ ] Performance optimization

## Testing

Tests are written using Vitest with proper mocking:

```typescript
describe('UserService', () => {
  it('should create a new user successfully', async () => {
    // Test implementation
  });
});
```

## Configuration

### Drizzle Configuration

```typescript
// drizzle.config.ts
export default defineConfig({
  schema: './src/infrastructure/db/schema/*.ts',
  out: './src/infrastructure/db/migrations',
  dialect: 'postgresql', // or 'sqlite'
});
```

### Environment Variables

Required environment variables:
- `DATABASE_TYPE`: 'sqlite' | 'postgres'
- `POSTGRES_HOST`: PostgreSQL host
- `POSTGRES_USER`: PostgreSQL username
- `POSTGRES_PASSWORD`: PostgreSQL password
- `POSTGRES_DATABASE`: PostgreSQL database name

## Benefits

1. **Type Safety**: Compile-time error checking for database queries
2. **Domain Logic**: Business rules centralized in domain entities
3. **Testability**: Clear separation of concerns enables easy testing
4. **Maintainability**: Well-structured code following DDD principles
5. **Performance**: Optimized queries with Drizzle's query builder
6. **Developer Experience**: Excellent TypeScript intellisense and autocomplete

## Next Steps

1. **Migrate remaining entities** (Post, Newsletter, Member, etc.)
2. **Add integration tests** with test database
3. **Implement proper password hashing**
4. **Add authentication middleware**
5. **Create admin dashboard** using new architecture
6. **Performance monitoring** and optimization

## Resources

- [Drizzle ORM Documentation](https://orm.drizzle.team/)
- [Domain-Driven Design](https://martinfowler.com/bliki/DomainDrivenDesign.html)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Zod Documentation](https://zod.dev/)