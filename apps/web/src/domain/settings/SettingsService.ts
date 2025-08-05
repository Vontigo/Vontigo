import type { SettingsRepository } from './SettingsRepository';
import { Settings } from './Settings';
import ObjectID from 'bson-objectid';

export class SettingsService {
	constructor(private settingsRepository: SettingsRepository) {}

	/**
	 * Get all settings groups
	 */
	async getGroups(): Promise<Array<{ group: string }>> {
		return await this.settingsRepository.getGroups();
	}

	/**
	 * Get settings by group
	 */
	async getByGroup(group: string): Promise<Settings[]> {
		if (!group || group.trim() === '') {
			throw new Error('Group is required');
		}
		return await this.settingsRepository.getByGroup(group.trim());
	}

	/**
	 * Get setting by key
	 */
	async getByKey(key: string): Promise<Settings | null> {
		if (!key || key.trim() === '') {
			throw new Error('Key is required');
		}
		return await this.settingsRepository.getByKey(key.trim());
	}

	/**
	 * Create new setting
	 */
	async createSetting(data: {
		group: string;
		key: string;
		value?: string | null;
		type?: string;
		flags?: string | null;
		createdBy: string;
	}): Promise<Settings> {
		// Validate input
		if (!data.group || data.group.trim() === '') {
			throw new Error('Group is required');
		}
		if (!data.key || data.key.trim() === '') {
			throw new Error('Key is required');
		}
		if (!data.createdBy || data.createdBy.trim() === '') {
			throw new Error('CreatedBy is required');
		}

		// Check if key already exists
		const existing = await this.settingsRepository.getByKey(data.key.trim());
		if (existing) {
			throw new Error(`Setting with key '${data.key}' already exists`);
		}

		// Create new settings
		const settings = Settings.create({
			id: new ObjectID().toHexString(),
			group: data.group.trim(),
			key: data.key.trim(),
			value: data.value,
			type: data.type,
			flags: data.flags,
			createdBy: data.createdBy.trim()
		});

		return await this.settingsRepository.create(settings);
	}

	/**
	 * Update setting value
	 */
	async updateSettingValue(key: string, value: string | null, updatedBy: string): Promise<Settings> {
		if (!key || key.trim() === '') {
			throw new Error('Key is required');
		}
		if (!updatedBy || updatedBy.trim() === '') {
			throw new Error('UpdatedBy is required');
		}

		const existing = await this.settingsRepository.getByKey(key.trim());
		if (!existing) {
			throw new Error(`Setting with key '${key}' not found`);
		}

		const updated = existing.updateValue(value, updatedBy.trim());
		return await this.settingsRepository.update(updated);
	}

	/**
	 * Delete setting by key
	 */
	async deleteSetting(key: string): Promise<void> {
		if (!key || key.trim() === '') {
			throw new Error('Key is required');
		}

		const existing = await this.settingsRepository.getByKey(key.trim());
		if (!existing) {
			throw new Error(`Setting with key '${key}' not found`);
		}

		await this.settingsRepository.deleteByKey(key.trim());
	}
}