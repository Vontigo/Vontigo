import { describe, it, expect, beforeEach, vi } from 'vitest';
import { Settings } from '../../../src/domain/settings/Settings';
import { SettingsService } from '../../../src/domain/settings/SettingsService';
import type { SettingsRepository } from '../../../src/domain/settings/SettingsRepository';

// Mock SettingsRepository
const mockSettingsRepository: SettingsRepository = {
	getGroups: vi.fn(),
	getByGroup: vi.fn(),
	getByKey: vi.fn(),
	create: vi.fn(),
	update: vi.fn(),
	deleteByKey: vi.fn()
};

describe('SettingsService', () => {
	let settingsService: SettingsService;

	beforeEach(() => {
		settingsService = new SettingsService(mockSettingsRepository);
		vi.clearAllMocks();
	});

	describe('getGroups', () => {
		it('should return all settings groups', async () => {
			// Arrange
			const expectedGroups = [
				{ group: 'site' },
				{ group: 'theme' },
				{ group: 'mail' }
			];
			vi.mocked(mockSettingsRepository.getGroups).mockResolvedValue(expectedGroups);

			// Act
			const result = await settingsService.getGroups();

			// Assert
			expect(mockSettingsRepository.getGroups).toHaveBeenCalledOnce();
			expect(result).toEqual(expectedGroups);
		});
	});

	describe('getByGroup', () => {
		it('should return settings for a valid group', async () => {
			// Arrange
			const group = 'site';
			const expectedSettings = [
				Settings.create({
					id: 'test-id-1',
					group: 'site',
					key: 'title',
					value: 'My Blog',
					createdBy: 'test-user'
				})
			];
			vi.mocked(mockSettingsRepository.getByGroup).mockResolvedValue(expectedSettings);

			// Act
			const result = await settingsService.getByGroup(group);

			// Assert
			expect(mockSettingsRepository.getByGroup).toHaveBeenCalledWith(group);
			expect(result).toEqual(expectedSettings);
		});

		it('should trim whitespace from group parameter', async () => {
			// Arrange
			const group = '  site  ';
			vi.mocked(mockSettingsRepository.getByGroup).mockResolvedValue([]);

			// Act
			await settingsService.getByGroup(group);

			// Assert
			expect(mockSettingsRepository.getByGroup).toHaveBeenCalledWith('site');
		});

		it('should throw error for empty group', async () => {
			// Act & Assert
			await expect(settingsService.getByGroup('')).rejects.toThrow('Group is required');
			await expect(settingsService.getByGroup('   ')).rejects.toThrow('Group is required');
		});
	});

	describe('getByKey', () => {
		it('should return setting for a valid key', async () => {
			// Arrange
			const key = 'title';
			const expectedSetting = Settings.create({
				id: 'test-id-1',
				group: 'site',
				key: 'title',
				value: 'My Blog',
				createdBy: 'test-user'
			});
			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(expectedSetting);

			// Act
			const result = await settingsService.getByKey(key);

			// Assert
			expect(mockSettingsRepository.getByKey).toHaveBeenCalledWith(key);
			expect(result).toEqual(expectedSetting);
		});

		it('should return null for non-existent key', async () => {
			// Arrange
			const key = 'non-existent';
			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(null);

			// Act
			const result = await settingsService.getByKey(key);

			// Assert
			expect(result).toBeNull();
		});

		it('should trim whitespace from key parameter', async () => {
			// Arrange
			const key = '  title  ';
			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(null);

			// Act
			await settingsService.getByKey(key);

			// Assert
			expect(mockSettingsRepository.getByKey).toHaveBeenCalledWith('title');
		});

		it('should throw error for empty key', async () => {
			// Act & Assert
			await expect(settingsService.getByKey('')).rejects.toThrow('Key is required');
			await expect(settingsService.getByKey('   ')).rejects.toThrow('Key is required');
		});
	});

	describe('createSetting', () => {
		it('should create a new setting successfully', async () => {
			// Arrange
			const settingData = {
				group: 'site',
				key: 'title',
				value: 'My Blog',
				type: 'string',
				flags: null,
				createdBy: 'test-user'
			};

			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(null);
			vi.mocked(mockSettingsRepository.create).mockImplementation(async (settings) => settings);

			// Act
			const result = await settingsService.createSetting(settingData);

			// Assert
			expect(mockSettingsRepository.getByKey).toHaveBeenCalledWith('title');
			expect(mockSettingsRepository.create).toHaveBeenCalled();
			expect(result.group).toBe('site');
			expect(result.key).toBe('title');
			expect(result.value).toBe('My Blog');
		});

		it('should throw error if key already exists', async () => {
			// Arrange
			const settingData = {
				group: 'site',
				key: 'title',
				value: 'My Blog',
				createdBy: 'test-user'
			};

			const existingSetting = Settings.create({
				id: 'existing-id',
				group: 'site',
				key: 'title',
				value: 'Existing Blog',
				createdBy: 'existing-user'
			});

			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(existingSetting);

			// Act & Assert
			await expect(settingsService.createSetting(settingData)).rejects.toThrow(
				"Setting with key 'title' already exists"
			);
		});

		it('should throw error for missing required fields', async () => {
			// Act & Assert
			await expect(settingsService.createSetting({
				group: '',
				key: 'title',
				createdBy: 'test-user'
			})).rejects.toThrow('Group is required');

			await expect(settingsService.createSetting({
				group: 'site',
				key: '',
				createdBy: 'test-user'
			})).rejects.toThrow('Key is required');

			await expect(settingsService.createSetting({
				group: 'site',
				key: 'title',
				createdBy: ''
			})).rejects.toThrow('CreatedBy is required');
		});

		it('should trim whitespace from input data', async () => {
			// Arrange
			const settingData = {
				group: '  site  ',
				key: '  title  ',
				value: 'My Blog',
				createdBy: '  test-user  '
			};

			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(null);
			vi.mocked(mockSettingsRepository.create).mockImplementation(async (settings) => settings);

			// Act
			const result = await settingsService.createSetting(settingData);

			// Assert
			expect(result.group).toBe('site');
			expect(result.key).toBe('title');
			expect(result.createdBy).toBe('test-user');
		});
	});

	describe('updateSettingValue', () => {
		it('should update setting value successfully', async () => {
			// Arrange
			const key = 'title';
			const newValue = 'Updated Blog Title';
			const updatedBy = 'test-user';

			const existingSetting = Settings.create({
				id: 'test-id',
				group: 'site',
				key: 'title',
				value: 'Old Title',
				createdBy: 'creator'
			});

			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(existingSetting);
			vi.mocked(mockSettingsRepository.update).mockImplementation(async (settings) => settings);

			// Act
			const result = await settingsService.updateSettingValue(key, newValue, updatedBy);

			// Assert
			expect(mockSettingsRepository.getByKey).toHaveBeenCalledWith(key);
			expect(mockSettingsRepository.update).toHaveBeenCalled();
			expect(result.value).toBe(newValue);
			expect(result.updatedBy).toBe(updatedBy);
		});

		it('should throw error if setting not found', async () => {
			// Arrange
			const key = 'non-existent';
			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(null);

			// Act & Assert
			await expect(settingsService.updateSettingValue(key, 'value', 'user')).rejects.toThrow(
				"Setting with key 'non-existent' not found"
			);
		});

		it('should throw error for missing required fields', async () => {
			// Act & Assert
			await expect(settingsService.updateSettingValue('', 'value', 'user')).rejects.toThrow('Key is required');
			await expect(settingsService.updateSettingValue('key', 'value', '')).rejects.toThrow('UpdatedBy is required');
		});
	});

	describe('deleteSetting', () => {
		it('should delete setting successfully', async () => {
			// Arrange
			const key = 'title';
			const existingSetting = Settings.create({
				id: 'test-id',
				group: 'site',
				key: 'title',
				value: 'Blog Title',
				createdBy: 'creator'
			});

			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(existingSetting);
			vi.mocked(mockSettingsRepository.deleteByKey).mockResolvedValue(undefined);

			// Act
			await settingsService.deleteSetting(key);

			// Assert
			expect(mockSettingsRepository.getByKey).toHaveBeenCalledWith(key);
			expect(mockSettingsRepository.deleteByKey).toHaveBeenCalledWith(key);
		});

		it('should throw error if setting not found', async () => {
			// Arrange
			const key = 'non-existent';
			vi.mocked(mockSettingsRepository.getByKey).mockResolvedValue(null);

			// Act & Assert
			await expect(settingsService.deleteSetting(key)).rejects.toThrow(
				"Setting with key 'non-existent' not found"
			);
		});

		it('should throw error for empty key', async () => {
			// Act & Assert
			await expect(settingsService.deleteSetting('')).rejects.toThrow('Key is required');
		});
	});
});