import { UserService } from '../../domain/user/UserService';
import type { User } from '../../domain/user/User';

export interface RegisterUserRequest {
	name: string;
	email: string;
	password: string;
	slug?: string;
	profileImage?: string;
	bio?: string;
	website?: string;
	location?: string;
}

export interface RegisterUserResponse {
	user: User;
	success: boolean;
	message?: string;
}

export class RegisterUserUseCase {
	constructor(
		private userService: UserService,
		private passwordHasher: PasswordHasher
	) {}

	async execute(request: RegisterUserRequest): Promise<RegisterUserResponse> {
		try {
			// Validate input
			if (!request.name || !request.email || !request.password) {
				throw new Error('Name, email, and password are required');
			}

			if (request.password.length < 8) {
				throw new Error('Password must be at least 8 characters long');
			}

			// Hash password
			const hashedPassword = await this.passwordHasher.hash(request.password);

			// Create user
			const user = await this.userService.createUser({
				name: request.name,
				email: request.email,
				password: hashedPassword,
				slug: request.slug,
				profileImage: request.profileImage,
				bio: request.bio,
				website: request.website,
				location: request.location
			});

			return {
				user,
				success: true,
				message: 'User registered successfully'
			};
		} catch (error) {
			return {
				user: null as any,
				success: false,
				message: error instanceof Error ? error.message : 'Registration failed'
			};
		}
	}
}

export interface PasswordHasher {
	hash(password: string): Promise<string>;
	verify(password: string, hash: string): Promise<boolean>;
}