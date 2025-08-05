# Before vs After: Migration Examples

This document showcases the practical differences between the old Knex-based approach and the new Drizzle + DDD architecture.

## 1. Database Connection & Schema

### Before (Knex)
```typescript
// connection.ts
import knex, { Knex } from 'knex';
import { globalConfig } from '$lib/core/shared/config/env/config';

export const knexInstance: Knex = await knex(globalConfig.database[DATABASE_TYPE]);

// schema.ts (JavaScript object)
export let tables = {
  users: {
    id: { type: 'string', maxlength: 24, nullable: false, primary: true },
    name: { type: 'string', maxlength: 191, nullable: false },
    email: { type: 'string', maxlength: 191, nullable: false, unique: true }
    // ... no type safety, no validation
  }
};
```

### After (Drizzle + TypeScript)
```typescript
// drizzleClient.ts
import { drizzle } from 'drizzle-orm/postgres-js';
import { drizzle as drizzleSqlite } from 'drizzle-orm/better-sqlite3';

const db = DATABASE_TYPE === 'sqlite' 
  ? drizzleSqlite(sqlite, { schema }) 
  : drizzle(connection, { schema });

// schema/user.ts (Type-safe schema)
export const users = pgTable('users', {
  id: varchar('id', { length: 24 }).primaryKey(),
  name: varchar('name', { length: 191 }).notNull(),
  email: varchar('email', { length: 191 }).notNull().unique(),
  // ... full type safety and validation
});

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
```

## 2. API Endpoints

### Before (Direct Database Access)
```typescript
// users/+server.ts
export async function GET({ url, params }) {
  try {
    const rows: any[] = await knexInstance
      .select('u.*', 'r.name as role_name')
      .from('roles_users as ru')
      .leftJoin('roles as r', 'r.id', 'ru.role_id')
      .leftJoin('users as u', 'u.id', 'ru.user_id')
      .where({ status: 'active' });
    
    return new Response(JSON.stringify(rows), { status: 200 });
  } catch (error) {
    // Basic error handling
    return new Response(JSON.stringify({ error }), { status: 500 });
  }
}
```

### After (Domain-Driven Architecture)
```typescript
// users/drizzle/+server.ts
export const GET = (async ({ url }) => {
  try {
    const container = Container.getInstance();
    const userService = container.getUserService();

    const options = {
      limit: url.searchParams.get('limit') ? parseInt(url.searchParams.get('limit')!, 10) : undefined,
      orderBy: url.searchParams.get('orderBy') as 'createdAt' | 'name' | 'email' | null || 'createdAt',
      order: url.searchParams.get('order') as 'asc' | 'desc' | null || 'desc'
    };

    const users = await userService.getAllUsers(options);
    const totalCount = await userService.getUserCount();

    const response = {
      users: users.filter(user => user.isActive()).map(user => ({
        id: user.id,
        name: user.name,
        email: user.email,
        // ... type-safe properties
      })),
      meta: { total: totalCount, ...options }
    };

    return json(response);
  } catch (err) {
    throw error(500, {
      message: 'Failed to fetch users',
      details: err instanceof Error ? err.message : 'Unknown error'
    });
  }
}) satisfies RequestHandler;
```

## 3. Data Access Patterns

### Before (Raw SQL + Manual Type Handling)
```typescript
// Direct Knex usage scattered throughout codebase
async function getUser(slug: string) {
  const user = await knexInstance
    .select('*')
    .from('users')
    .where({ slug })
    .first();
  
  // No type safety, manual validation
  if (!user) return null;
  return user; // any type
}

async function createUser(userData: any) {
  // Manual validation, no business logic encapsulation
  const [newUser] = await knexInstance('users')
    .insert(userData)
    .returning('*');
  
  return newUser; // any type
}
```

### After (Repository Pattern + Domain Logic)
```typescript
// Repository Interface
export interface UserRepository {
  findBySlug(slug: UserSlug): Promise<User | null>;
  create(user: User): Promise<User>;
  // ... other methods with full type safety
}

// Domain Service
export class UserService {
  async createUser(data: CreateUserData): Promise<User> {
    // Input validation with Zod
    const validatedEmail = EmailSchema.parse(data.email);
    const validatedName = UserNameSchema.parse(data.name);

    // Business logic
    const existingUser = await this.userRepository.existsByEmail(validatedEmail);
    if (existingUser) {
      throw new Error('User with this email already exists');
    }

    // Domain entity creation
    const user = User.create({
      id: this.generateUserId(),
      name: validatedName,
      email: validatedEmail,
      // ... other validated properties
    });

    return await this.userRepository.create(user);
  }
}

// Type-safe Repository Implementation
export class DrizzleUserRepository implements UserRepository {
  async findBySlug(slug: UserSlug): Promise<User | null> {
    const result = await this.db
      .select()
      .from(this.usersTable)
      .where(eq(this.usersTable.slug, slug))
      .limit(1);
    
    return result.length > 0 ? User.fromData(result[0]!) : null;
  }
}
```

## 4. Domain Logic

### Before (Anemic Domain Model)
```typescript
// No encapsulation, scattered business logic
function updateUserProfile(userId: string, updates: any) {
  // Validation scattered across different files
  if (!updates.name || updates.name.length > 191) {
    throw new Error('Invalid name');
  }
  
  // Direct database update, no business logic
  return knexInstance('users')
    .where({ id: userId })
    .update({
      ...updates,
      updated_at: new Date()
    });
}
```

### After (Rich Domain Model)
```typescript
// Domain Entity with Business Logic
export class User {
  updateProfile(updates: ProfileUpdates): User {
    // Business logic encapsulated in entity
    this.validateProfileUpdates(updates);
    
    return new User(
      this.id,
      updates.name || this.name,
      this.slug,
      this.email,
      // ... immutable updates with business rules
      new Date() // updatedAt
    );
  }

  isActive(): boolean {
    return this.status === 'active';
  }

  canUpdateProfile(currentUser: User): boolean {
    return this.id === currentUser.id || currentUser.hasRole('admin');
  }

  private validateProfileUpdates(updates: ProfileUpdates): void {
    if (updates.website && !this.isValidUrl(updates.website)) {
      throw new Error('Invalid website URL');
    }
    // ... other business validations
  }
}
```

## 5. Testing

### Before (Difficult to Test)
```typescript
// Hard to test due to direct database dependencies
// Mock entire Knex instance or use real database
test('should get users', async () => {
  // Complex setup with database mocking
  const mockKnex = jest.fn();
  // ... complex mocking setup
});
```

### After (Easy to Test with Dependency Injection)
```typescript
// Clean, focused tests with proper mocking
describe('UserService', () => {
  let userService: UserService;
  let mockUserRepository: UserRepository;

  beforeEach(() => {
    mockUserRepository = {
      findById: vi.fn(),
      create: vi.fn(),
      // ... clean interface mocking
    };
    userService = new UserService(mockUserRepository);
  });

  it('should create user successfully', async () => {
    // Arrange
    const userData = { name: 'John', email: 'john@example.com' };
    vi.mocked(mockUserRepository.existsByEmail).mockResolvedValue(false);
    vi.mocked(mockUserRepository.create).mockResolvedValue(expectedUser);

    // Act
    const result = await userService.createUser(userData);

    // Assert
    expect(result.name).toBe(userData.name);
  });
});
```

## 6. Error Handling

### Before (Basic Error Handling)
```typescript
export async function GET({ params }) {
  let returnRows: any;
  await getAllRows(params)
    .then((rows) => {
      returnRows = rows;
    })
    .catch((error) => {
      console.error(error);
      returnRows = error; // Returning error object directly
    });
  return new Response(JSON.stringify(returnRows), { status: 200 });
}
```

### After (Structured Error Handling)
```typescript
export const GET = (async ({ params }) => {
  try {
    const userService = container.getUserService();
    const user = await userService.getUserBySlug(params.slug);

    if (!user) {
      throw error(404, { message: 'User not found' });
    }

    return json({ user: user.toPublicView() });
  } catch (err) {
    console.error(`Error fetching user:`, err);
    
    if (err instanceof Error && 'status' in err) {
      throw err; // Re-throw SvelteKit errors
    }
    
    throw error(500, {
      message: 'Failed to fetch user',
      details: err instanceof Error ? err.message : 'Unknown error'
    });
  }
}) satisfies RequestHandler;
```

## Key Benefits of the New Architecture

1. **Type Safety**: Compile-time error checking prevents runtime errors
2. **Business Logic Encapsulation**: Domain entities contain business rules
3. **Testability**: Clean separation enables easy unit testing
4. **Maintainability**: Clear structure and patterns for future development
5. **Performance**: Optimized queries with Drizzle's query builder
6. **Developer Experience**: Excellent autocomplete and intellisense

## Migration Strategy

1. **Gradual Migration**: Implement new endpoints alongside existing ones
2. **API Versioning**: Use `/drizzle/` paths for new architecture
3. **Feature Parity**: Ensure new endpoints provide same functionality
4. **Testing**: Comprehensive tests for new architecture
5. **Documentation**: Clear examples and migration guides
6. **Performance Testing**: Benchmark against existing implementation

The new architecture provides a solid foundation for scalable, maintainable, and type-safe development while preserving all existing functionality.