import { db } from '../infrastructure/db/drizzleClient';
import { DrizzleUserRepository } from '../infrastructure/repositories/DrizzleUserRepository';
import { DrizzleSettingsRepository } from '../infrastructure/repositories/DrizzleSettingsRepository';
import { DrizzleTagRepository } from '../infrastructure/repositories/DrizzleTagRepository';
import { DrizzleMemberRepository } from '../infrastructure/repositories/DrizzleMemberRepository';
import { UserService } from '../domain/user/UserService';
import { SettingsService } from '../domain/settings/SettingsService';
import { TagService } from '../domain/tag/TagService';
import { MemberService } from '../domain/member/MemberService';
import { RegisterUserUseCase } from '../application/useCases/RegisterUser';

// Simple dependency injection container
export class Container {
	private static instance: Container;
	private userRepository: DrizzleUserRepository;
	private settingsRepository: DrizzleSettingsRepository;
	private tagRepository: DrizzleTagRepository;
	private memberRepository: DrizzleMemberRepository;
	private userService: UserService;
	private settingsService: SettingsService;
	private tagService: TagService;
	private memberService: MemberService;
	private registerUserUseCase: RegisterUserUseCase;

	private constructor() {
		// Initialize repositories
		this.userRepository = new DrizzleUserRepository(db);
		this.settingsRepository = new DrizzleSettingsRepository(db);
		this.tagRepository = new DrizzleTagRepository(db);
		this.memberRepository = new DrizzleMemberRepository(db);

		// Initialize domain services
		this.userService = new UserService(this.userRepository);
		this.settingsService = new SettingsService(this.settingsRepository);
		this.tagService = new TagService(this.tagRepository);
		this.memberService = new MemberService(this.memberRepository);

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

	getSettingsRepository(): DrizzleSettingsRepository {
		return this.settingsRepository;
	}

	getTagRepository(): DrizzleTagRepository {
		return this.tagRepository;
	}

	getMemberRepository(): DrizzleMemberRepository {
		return this.memberRepository;
	}

	getUserService(): UserService {
		return this.userService;
	}

	getSettingsService(): SettingsService {
		return this.settingsService;
	}

	getTagService(): TagService {
		return this.tagService;
	}

	getMemberService(): MemberService {
		return this.memberService;
	}

	getRegisterUserUseCase(): RegisterUserUseCase {
		return this.registerUserUseCase;
	}
}