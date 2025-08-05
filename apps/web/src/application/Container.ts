import { db } from '../infrastructure/db/drizzleClient';
import { DrizzleUserRepository } from '../infrastructure/repositories/DrizzleUserRepository';
import { UserService } from '../domain/user/UserService';
import { RegisterUserUseCase } from '../application/useCases/RegisterUser';

// Simple dependency injection container
export class Container {
	private static instance: Container;
	private userRepository: DrizzleUserRepository;
	private userService: UserService;
	private registerUserUseCase: RegisterUserUseCase;

	private constructor() {
		// Initialize repositories
		this.userRepository = new DrizzleUserRepository(db);

		// Initialize domain services
		this.userService = new UserService(this.userRepository);

		// Initialize use cases
		this.registerUserUseCase = new RegisterUserUseCase(this.userService, {
			hash: async (password: string) => password, // TODO: Implement proper hashing
			verify: async (password: string, hash: string) => password === hash
		});
	}

	static getInstance(): Container {
		if (!Container.instance) {
			Container.instance = new Container();
		}
		return Container.instance;
	}

	getUserRepository(): DrizzleUserRepository {
		return this.userRepository;
	}

	getUserService(): UserService {
		return this.userService;
	}

	getRegisterUserUseCase(): RegisterUserUseCase {
		return this.registerUserUseCase;
	}
}