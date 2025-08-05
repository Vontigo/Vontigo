import { z } from 'zod';
import { MemberEmailSchema, MemberNameSchema } from '../../infrastructure/db/schema/membership';

export class Member {
	constructor(
		public readonly id: string,
		public readonly uuid: string | null,
		public readonly email: string,
		public readonly status: string,
		public readonly name: string | null,
		public readonly expertise: string | null,
		public readonly note: string | null,
		public readonly geolocation: string | null,
		public readonly enableCommentNotifications: boolean,
		public readonly emailCount: number,
		public readonly emailOpenedCount: number,
		public readonly emailOpenRate: number | null,
		public readonly lastSeenAt: Date | null,
		public readonly lastCommentedAt: Date | null,
		public readonly createdAt: Date,
		public readonly createdBy: string,
		public readonly updatedAt: Date | null,
		public readonly updatedBy: string | null
	) {
		// Validate domain invariants
		this.validateEmail(email);
		if (name !== null) {
			this.validateName(name);
		}
	}

	private validateEmail(email: string): void {
		const result = MemberEmailSchema.safeParse(email);
		if (!result.success) {
			throw new Error(`Invalid member email: ${result.error.message}`);
		}
	}

	private validateName(name: string): void {
		const result = MemberNameSchema.safeParse(name);
		if (!result.success) {
			throw new Error(`Invalid member name: ${result.error.message}`);
		}
	}

	/**
	 * Create a new Member instance
	 */
	static create(data: {
		id: string;
		uuid?: string | null;
		email: string;
		status?: string;
		name?: string | null;
		expertise?: string | null;
		note?: string | null;
		geolocation?: string | null;
		enableCommentNotifications?: boolean;
		createdBy: string;
	}): Member {
		return new Member(
			data.id,
			data.uuid ?? null,
			data.email,
			data.status ?? 'free',
			data.name ?? null,
			data.expertise ?? null,
			data.note ?? null,
			data.geolocation ?? null,
			data.enableCommentNotifications ?? true,
			0, // emailCount
			0, // emailOpenedCount
			null, // emailOpenRate
			null, // lastSeenAt
			null, // lastCommentedAt
			new Date(),
			data.createdBy,
			null,
			null
		);
	}

	/**
	 * Update member information
	 */
	update(data: {
		name?: string | null;
		expertise?: string | null;
		note?: string | null;
		geolocation?: string | null;
		enableCommentNotifications?: boolean;
		status?: string;
		updatedBy: string;
	}): Member {
		const name = data.name !== undefined ? data.name : this.name;
		
		// Validate if changed
		if (data.name !== undefined && data.name !== this.name && data.name !== null) {
			this.validateName(data.name);
		}

		return new Member(
			this.id,
			this.uuid,
			this.email,
			data.status ?? this.status,
			name,
			data.expertise !== undefined ? data.expertise : this.expertise,
			data.note !== undefined ? data.note : this.note,
			data.geolocation !== undefined ? data.geolocation : this.geolocation,
			data.enableCommentNotifications ?? this.enableCommentNotifications,
			this.emailCount,
			this.emailOpenedCount,
			this.emailOpenRate,
			this.lastSeenAt,
			this.lastCommentedAt,
			this.createdAt,
			this.createdBy,
			new Date(),
			data.updatedBy
		);
	}

	/**
	 * Update member activity (last seen, email stats)
	 */
	updateActivity(data: {
		lastSeenAt?: Date | null;
		lastCommentedAt?: Date | null;
		emailCount?: number;
		emailOpenedCount?: number;
		emailOpenRate?: number | null;
		updatedBy: string;
	}): Member {
		return new Member(
			this.id,
			this.uuid,
			this.email,
			this.status,
			this.name,
			this.expertise,
			this.note,
			this.geolocation,
			this.enableCommentNotifications,
			data.emailCount ?? this.emailCount,
			data.emailOpenedCount ?? this.emailOpenedCount,
			data.emailOpenRate !== undefined ? data.emailOpenRate : this.emailOpenRate,
			data.lastSeenAt !== undefined ? data.lastSeenAt : this.lastSeenAt,
			data.lastCommentedAt !== undefined ? data.lastCommentedAt : this.lastCommentedAt,
			this.createdAt,
			this.createdBy,
			new Date(),
			data.updatedBy
		);
	}

	/**
	 * Convert to plain object for serialization
	 */
	toJSON() {
		return {
			id: this.id,
			uuid: this.uuid,
			email: this.email,
			status: this.status,
			name: this.name,
			expertise: this.expertise,
			note: this.note,
			geolocation: this.geolocation,
			enableCommentNotifications: this.enableCommentNotifications,
			emailCount: this.emailCount,
			emailOpenedCount: this.emailOpenedCount,
			emailOpenRate: this.emailOpenRate,
			lastSeenAt: this.lastSeenAt,
			lastCommentedAt: this.lastCommentedAt,
			createdAt: this.createdAt,
			createdBy: this.createdBy,
			updatedAt: this.updatedAt,
			updatedBy: this.updatedBy
		};
	}
}