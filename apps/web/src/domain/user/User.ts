import type { User as UserData, Email, UserSlug, UserName } from '../../../infrastructure/db/schema/user';

export class User {
	private constructor(
		public readonly id: string,
		public readonly name: UserName,
		public readonly slug: UserSlug,
		public readonly email: Email,
		public readonly password: string,
		public readonly profileImage?: string | null,
		public readonly coverImage?: string | null,
		public readonly bio?: string | null,
		public readonly website?: string | null,
		public readonly location?: string | null,
		public readonly facebook?: string | null,
		public readonly twitter?: string | null,
		public readonly status: string = 'active',
		public readonly visibility: string = 'public',
		public readonly createdAt: Date = new Date(),
		public readonly updatedAt?: Date | null,
		public readonly lastSeen?: Date | null
	) {}

	static create(data: {
		id: string;
		name: string;
		slug: string;
		email: string;
		password: string;
		profileImage?: string | null;
		coverImage?: string | null;
		bio?: string | null;
		website?: string | null;
		location?: string | null;
		facebook?: string | null;
		twitter?: string | null;
	}): User {
		return new User(
			data.id,
			data.name as UserName,
			data.slug as UserSlug,
			data.email as Email,
			data.password,
			data.profileImage,
			data.coverImage,
			data.bio,
			data.website,
			data.location,
			data.facebook,
			data.twitter
		);
	}

	static fromData(data: UserData): User {
		return new User(
			data.id,
			data.name as UserName,
			data.slug as UserSlug,
			data.email as Email,
			data.password,
			data.profileImage,
			data.coverImage,
			data.bio,
			data.website,
			data.location,
			data.facebook,
			data.twitter,
			data.status,
			data.visibility,
			data.createdAt,
			data.updatedAt,
			data.lastSeen
		);
	}

	updateProfile(updates: {
		name?: string;
		bio?: string;
		website?: string;
		location?: string;
		profileImage?: string;
		coverImage?: string;
	}): User {
		return new User(
			this.id,
			(updates.name as UserName) || this.name,
			this.slug,
			this.email,
			this.password,
			updates.profileImage !== undefined ? updates.profileImage : this.profileImage,
			updates.coverImage !== undefined ? updates.coverImage : this.coverImage,
			updates.bio !== undefined ? updates.bio : this.bio,
			updates.website !== undefined ? updates.website : this.website,
			updates.location !== undefined ? updates.location : this.location,
			this.facebook,
			this.twitter,
			this.status,
			this.visibility,
			this.createdAt,
			new Date()
		);
	}

	updateLastSeen(): User {
		return new User(
			this.id,
			this.name,
			this.slug,
			this.email,
			this.password,
			this.profileImage,
			this.coverImage,
			this.bio,
			this.website,
			this.location,
			this.facebook,
			this.twitter,
			this.status,
			this.visibility,
			this.createdAt,
			new Date(),
			new Date()
		);
	}

	isActive(): boolean {
		return this.status === 'active';
	}

	isPublic(): boolean {
		return this.visibility === 'public';
	}
}