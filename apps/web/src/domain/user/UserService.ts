import type { UserRepository } from './UserRepository';
import { User } from './User';
import type { Email, UserSlug, UserName } from '../../infrastructure/db/schema/user';
import { EmailSchema, UserSlugSchema, UserNameSchema } from '../../infrastructure/db/schema/user';
import { v4 as uuidv4 } from 'uuid';

export class UserService {
	constructor(private userRepository: UserRepository) {}

	async createUser(data: {
		name: string;
		email: string;
		password: string;
		slug?: string;
		profileImage?: string;
		bio?: string;
		website?: string;
		location?: string;
	}): Promise<User> {
		// Validate input data
		const validatedEmail = EmailSchema.parse(data.email);
		const validatedName = UserNameSchema.parse(data.name);

		// Check if email already exists
		const existingEmailUser = await this.userRepository.existsByEmail(validatedEmail);
		if (existingEmailUser) {
			throw new Error('User with this email already exists');
		}

		// Generate slug if not provided
		let slug = data.slug || this.generateSlugFromName(data.name);
		slug = await this.ensureUniqueSlug(slug);

		const validatedSlug = UserSlugSchema.parse(slug);

		// Create user entity
		const user = User.create({
			id: this.generateUserId(),
			name: validatedName,
			email: validatedEmail,
			password: data.password, // Note: Should be hashed before calling this service
			slug: validatedSlug,
			profileImage: data.profileImage,
			bio: data.bio,
			website: data.website,
			location: data.location
		});

		return await this.userRepository.create(user);
	}

	async getUserById(id: string): Promise<User | null> {
		return await this.userRepository.findById(id);
	}

	async getUserByEmail(email: string): Promise<User | null> {
		const validatedEmail = EmailSchema.parse(email);
		return await this.userRepository.findByEmail(validatedEmail);
	}

	async getUserBySlug(slug: string): Promise<User | null> {
		const validatedSlug = UserSlugSchema.parse(slug);
		return await this.userRepository.findBySlug(validatedSlug);
	}

	async updateUser(
		id: string,
		updates: {
			name?: string;
			bio?: string;
			website?: string;
			location?: string;
			profileImage?: string;
			coverImage?: string;
		}
	): Promise<User> {
		const existingUser = await this.userRepository.findById(id);
		if (!existingUser) {
			throw new Error('User not found');
		}

		const updatedUser = existingUser.updateProfile(updates);
		return await this.userRepository.update(updatedUser);
	}

	async updateUserLastSeen(id: string): Promise<User> {
		const existingUser = await this.userRepository.findById(id);
		if (!existingUser) {
			throw new Error('User not found');
		}

		const updatedUser = existingUser.updateLastSeen();
		return await this.userRepository.update(updatedUser);
	}

	async deleteUser(id: string): Promise<void> {
		const existingUser = await this.userRepository.findById(id);
		if (!existingUser) {
			throw new Error('User not found');
		}

		await this.userRepository.delete(id);
	}

	async getAllUsers(options?: {
		limit?: number;
		offset?: number;
		orderBy?: 'createdAt' | 'name' | 'email';
		order?: 'asc' | 'desc';
	}): Promise<User[]> {
		return await this.userRepository.findAll(options);
	}

	async getUserCount(): Promise<number> {
		return await this.userRepository.count();
	}

	private generateUserId(): string {
		// Generate a 24-character ID (similar to MongoDB ObjectId)
		return uuidv4().replace(/-/g, '').substring(0, 24);
	}

	private generateSlugFromName(name: string): string {
		return name
			.toLowerCase()
			.replace(/[^a-z0-9]/g, '-')
			.replace(/-+/g, '-')
			.replace(/^-|-$/g, '');
	}

	private async ensureUniqueSlug(baseSlug: string): Promise<string> {
		let slug = baseSlug;
		let counter = 1;

		while (await this.userRepository.existsBySlug(slug as UserSlug)) {
			slug = `${baseSlug}-${counter}`;
			counter++;
		}

		return slug;
	}
}