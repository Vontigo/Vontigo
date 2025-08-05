import { eq, and } from 'drizzle-orm';
import { sql } from 'drizzle-orm';
import type { DrizzleDB } from '../db/drizzleClient';
import type { SettingsRepository } from '../../domain/settings/SettingsRepository';
import { Settings } from '../../domain/settings/Settings';
import { settings, settingsSqlite } from '../db/schema/settings';
import { DATABASE_TYPE } from '$env/static/private';

export class DrizzleSettingsRepository implements SettingsRepository {
	constructor(private db: DrizzleDB) {}

	private get table() {
		return DATABASE_TYPE === 'development' || DATABASE_TYPE === 'sqlite' 
			? settingsSqlite 
			: settings;
	}

	async getGroups(): Promise<Array<{ group: string }>> {
		const results = await this.db
			.selectDistinct({ group: this.table.group })
			.from(this.table)
			.orderBy(this.table.group);

		return results;
	}

	async getByGroup(group: string): Promise<Settings[]> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.group, group))
			.orderBy(this.table.key);

		return results.map(this.mapToEntity);
	}

	async getByKey(key: string): Promise<Settings | null> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.key, key))
			.limit(1);

		if (results.length === 0) {
			return null;
		}

		return this.mapToEntity(results[0]);
	}

	async create(settings: Settings): Promise<Settings> {
		const data = this.mapToTable(settings);
		
		await this.db.insert(this.table).values(data);
		
		// Return the created settings
		const created = await this.getByKey(settings.key);
		if (!created) {
			throw new Error('Failed to create settings');
		}
		return created;
	}

	async update(settings: Settings): Promise<Settings> {
		const data = this.mapToTable(settings);
		
		await this.db
			.update(this.table)
			.set(data)
			.where(eq(this.table.key, settings.key));
		
		// Return the updated settings
		const updated = await this.getByKey(settings.key);
		if (!updated) {
			throw new Error('Failed to update settings');
		}
		return updated;
	}

	async deleteByKey(key: string): Promise<void> {
		await this.db
			.delete(this.table)
			.where(eq(this.table.key, key));
	}

	private mapToEntity(row: any): Settings {
		return new Settings(
			row.id,
			row.group,
			row.key,
			row.value,
			row.type,
			row.flags,
			new Date(row.createdAt),
			row.createdBy,
			row.updatedAt ? new Date(row.updatedAt) : null,
			row.updatedBy
		);
	}

	private mapToTable(settings: Settings) {
		return {
			id: settings.id,
			group: settings.group,
			key: settings.key,
			value: settings.value,
			type: settings.type,
			flags: settings.flags,
			createdAt: settings.createdAt,
			createdBy: settings.createdBy,
			updatedAt: settings.updatedAt,
			updatedBy: settings.updatedBy
		};
	}
}