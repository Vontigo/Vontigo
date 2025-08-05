import { eq, desc, asc, count } from 'drizzle-orm';
import type { DrizzleDB } from '../../infrastructure/db/drizzleClient';
import { users, usersSqlite } from '../../infrastructure/db/schema/user';
import type { UserRepository } from '../../domain/user/UserRepository';
import { User } from '../../domain/user/User';
import type { Email, UserSlug } from '../../infrastructure/db/schema/user';
import { DATABASE_TYPE } from '$env/static/private';

export class DrizzleUserRepository implements UserRepository {
	constructor(private db: DrizzleDB) {}

	// Use the appropriate table based on database type
	private get usersTable() {
		return DATABASE_TYPE === 'development' || DATABASE_TYPE === 'sqlite' ? usersSqlite : users;
	}

	async findById(id: string): Promise<User | null> {
		const result = await this.db.select().from(this.usersTable).where(eq(this.usersTable.id, id)).limit(1);
		return result.length > 0 ? User.fromData(result[0]!) : null;
	}

	async findByEmail(email: Email): Promise<User | null> {
		const result = await this.db.select().from(this.usersTable).where(eq(this.usersTable.email, email)).limit(1);
		return result.length > 0 ? User.fromData(result[0]!) : null;
	}

	async findBySlug(slug: UserSlug): Promise<User | null> {
		const result = await this.db.select().from(this.usersTable).where(eq(this.usersTable.slug, slug)).limit(1);
		return result.length > 0 ? User.fromData(result[0]!) : null;
	}

	async save(user: User): Promise<User> {
		const existingUser = await this.findById(user.id);
		if (existingUser) {
			return this.update(user);
		} else {
			return this.create(user);
		}
	}

	async create(user: User): Promise<User> {
		const newUserData = {
			id: user.id,
			name: user.name,
			slug: user.slug,
			email: user.email,
			password: user.password,
			profileImage: user.profileImage,
			coverImage: user.coverImage,
			bio: user.bio,
			website: user.website,
			location: user.location,
			facebook: user.facebook,
			twitter: user.twitter,
			status: user.status,
			visibility: user.visibility,
			createdAt: user.createdAt,
			createdBy: user.id, // Self-created
			updatedAt: user.updatedAt,
			updatedBy: null
		};

		const result = await this.db.insert(this.usersTable).values(newUserData).returning();
		return User.fromData(result[0]!);
	}

	async update(user: User): Promise<User> {
		const updateData = {
			name: user.name,
			slug: user.slug,
			email: user.email,
			profileImage: user.profileImage,
			coverImage: user.coverImage,
			bio: user.bio,
			website: user.website,
			location: user.location,
			facebook: user.facebook,
			twitter: user.twitter,
			status: user.status,
			visibility: user.visibility,
			updatedAt: new Date(),
			updatedBy: user.id,
			lastSeen: user.lastSeen
		};

		const result = await this.db
			.update(this.usersTable)
			.set(updateData)
			.where(eq(this.usersTable.id, user.id))
			.returning();

		return User.fromData(result[0]!);
	}

	async delete(id: string): Promise<void> {
		await this.db.delete(this.usersTable).where(eq(this.usersTable.id, id));
	}

	async findAll(options?: {
		limit?: number;
		offset?: number;
		orderBy?: 'createdAt' | 'name' | 'email';
		order?: 'asc' | 'desc';
	}): Promise<User[]> {
		let query = this.db.select().from(this.usersTable);

		// Apply ordering
		if (options?.orderBy) {
			const orderFn = options.order === 'desc' ? desc : asc;
			const orderField = this.usersTable[options.orderBy];
			query = query.orderBy(orderFn(orderField));
		}

		// Apply pagination
		if (options?.limit) {
			query = query.limit(options.limit);
		}
		if (options?.offset) {
			query = query.offset(options.offset);
		}

		const results = await query;
		return results.map(User.fromData);
	}

	async count(): Promise<number> {
		const result = await this.db.select({ count: count() }).from(this.usersTable);
		return result[0]?.count ?? 0;
	}

	async existsByEmail(email: Email): Promise<boolean> {
		const result = await this.db
			.select({ id: this.usersTable.id })
			.from(this.usersTable)
			.where(eq(this.usersTable.email, email))
			.limit(1);
		return result.length > 0;
	}

	async existsBySlug(slug: UserSlug): Promise<boolean> {
		const result = await this.db
			.select({ id: this.usersTable.id })
			.from(this.usersTable)
			.where(eq(this.usersTable.slug, slug))
			.limit(1);
		return result.length > 0;
	}
}