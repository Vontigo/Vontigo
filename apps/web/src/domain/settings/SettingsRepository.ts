import type { Settings } from './Settings';

export interface SettingsRepository {
	/**
	 * Get all settings grouped by group
	 */
	getGroups(): Promise<Array<{ group: string }>>;

	/**
	 * Get settings by group
	 */
	getByGroup(group: string): Promise<Settings[]>;

	/**
	 * Get setting by key
	 */
	getByKey(key: string): Promise<Settings | null>;

	/**
	 * Create new setting
	 */
	create(settings: Settings): Promise<Settings>;

	/**
	 * Update setting
	 */
	update(settings: Settings): Promise<Settings>;

	/**
	 * Delete setting by key
	 */
	deleteByKey(key: string): Promise<void>;
}