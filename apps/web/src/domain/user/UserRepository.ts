import type { User } from './User';
import type { Email, UserSlug } from '../../../infrastructure/db/schema/user';

export interface UserRepository {
	findById(id: string): Promise<User | null>;
	findByEmail(email: Email): Promise<User | null>;
	findBySlug(slug: UserSlug): Promise<User | null>;
	save(user: User): Promise<User>;
	create(user: User): Promise<User>;
	update(user: User): Promise<User>;
	delete(id: string): Promise<void>;
	findAll(options?: {
		limit?: number;
		offset?: number;
		orderBy?: 'createdAt' | 'name' | 'email';
		order?: 'asc' | 'desc';
	}): Promise<User[]>;
	count(): Promise<number>;
	existsByEmail(email: Email): Promise<boolean>;
	existsBySlug(slug: UserSlug): Promise<boolean>;
}