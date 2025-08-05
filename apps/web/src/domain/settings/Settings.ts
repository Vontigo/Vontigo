import { z } from 'zod';
import { SettingsKeySchema, SettingsGroupSchema } from '../../infrastructure/db/schema/settings';

export class Settings {
	constructor(
		public readonly id: string,
		public readonly group: string,
		public readonly key: string,
		public readonly value: string | null,
		public readonly type: string,
		public readonly flags: string | null,
		public readonly createdAt: Date,
		public readonly createdBy: string,
		public readonly updatedAt: Date | null,
		public readonly updatedBy: string | null
	) {
		// Validate domain invariants
		this.validateGroup(group);
		this.validateKey(key);
	}

	private validateGroup(group: string): void {
		const result = SettingsGroupSchema.safeParse(group);
		if (!result.success) {
			throw new Error(`Invalid settings group: ${result.error.message}`);
		}
	}

	private validateKey(key: string): void {
		const result = SettingsKeySchema.safeParse(key);
		if (!result.success) {
			throw new Error(`Invalid settings key: ${result.error.message}`);
		}
	}

	/**
	 * Create a new Settings instance
	 */
	static create(data: {
		id: string;
		group: string;
		key: string;
		value?: string | null;
		type?: string;
		flags?: string | null;
		createdBy: string;
	}): Settings {
		return new Settings(
			data.id,
			data.group,
			data.key,
			data.value ?? null,
			data.type ?? 'blog',
			data.flags ?? null,
			new Date(),
			data.createdBy,
			null,
			null
		);
	}

	/**
	 * Update settings value
	 */
	updateValue(value: string | null, updatedBy: string): Settings {
		return new Settings(
			this.id,
			this.group,
			this.key,
			value,
			this.type,
			this.flags,
			this.createdAt,
			this.createdBy,
			new Date(),
			updatedBy
		);
	}

	/**
	 * Convert to plain object for serialization
	 */
	toJSON() {
		return {
			id: this.id,
			group: this.group,
			key: this.key,
			value: this.value,
			type: this.type,
			flags: this.flags,
			createdAt: this.createdAt,
			createdBy: this.createdBy,
			updatedAt: this.updatedAt,
			updatedBy: this.updatedBy
		};
	}
}