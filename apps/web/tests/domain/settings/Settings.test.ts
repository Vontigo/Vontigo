import { describe, it, expect } from 'vitest';
import { Settings } from '../../../src/domain/settings/Settings';

describe('Settings Entity', () => {
	describe('create', () => {
		it('should create a new Settings instance with required fields', () => {
			// Arrange
			const settingsData = {
				id: 'test-id-123',
				group: 'site',
				key: 'title',
				value: 'My Blog',
				createdBy: 'test-user'
			};

			// Act
			const settings = Settings.create(settingsData);

			// Assert
			expect(settings.id).toBe('test-id-123');
			expect(settings.group).toBe('site');
			expect(settings.key).toBe('title');
			expect(settings.value).toBe('My Blog');
			expect(settings.type).toBe('blog'); // default value
			expect(settings.flags).toBeNull(); // default value
			expect(settings.createdBy).toBe('test-user');
			expect(settings.createdAt).toBeInstanceOf(Date);
			expect(settings.updatedAt).toBeNull();
			expect(settings.updatedBy).toBeNull();
		});

		it('should create a Settings instance with all optional fields', () => {
			// Arrange
			const settingsData = {
				id: 'test-id-123',
				group: 'site',
				key: 'title',
				value: 'My Blog',
				type: 'string',
				flags: 'PUBLIC,READONLY',
				createdBy: 'test-user'
			};

			// Act
			const settings = Settings.create(settingsData);

			// Assert
			expect(settings.type).toBe('string');
			expect(settings.flags).toBe('PUBLIC,READONLY');
		});

		it('should create a Settings instance with null value', () => {
			// Arrange
			const settingsData = {
				id: 'test-id-123',
				group: 'site',
				key: 'title',
				value: null,
				createdBy: 'test-user'
			};

			// Act
			const settings = Settings.create(settingsData);

			// Assert
			expect(settings.value).toBeNull();
		});

		it('should validate group during creation', () => {
			// Act & Assert
			expect(() => Settings.create({
				id: 'test-id',
				group: '', // invalid group
				key: 'title',
				createdBy: 'user'
			})).toThrow('Group cannot be empty');

			expect(() => Settings.create({
				id: 'test-id',
				group: 'a'.repeat(51), // too long group
				key: 'title',
				createdBy: 'user'
			})).toThrow('Group too long');
		});

		it('should validate key during creation', () => {
			// Act & Assert
			expect(() => Settings.create({
				id: 'test-id',
				group: 'site',
				key: '', // invalid key
				createdBy: 'user'
			})).toThrow('Key cannot be empty');

			expect(() => Settings.create({
				id: 'test-id',
				group: 'site',
				key: 'a'.repeat(51), // too long key
				createdBy: 'user'
			})).toThrow('Key too long');
		});
	});

	describe('updateValue', () => {
		it('should update setting value and set updated fields', () => {
			// Arrange
			const originalSettings = Settings.create({
				id: 'test-id',
				group: 'site',
				key: 'title',
				value: 'Original Title',
				createdBy: 'creator'
			});

			// Act
			const updatedSettings = originalSettings.updateValue('New Title', 'updater');

			// Assert
			expect(updatedSettings.value).toBe('New Title');
			expect(updatedSettings.updatedBy).toBe('updater');
			expect(updatedSettings.updatedAt).toBeInstanceOf(Date);
			
			// Original values should remain unchanged
			expect(updatedSettings.id).toBe(originalSettings.id);
			expect(updatedSettings.group).toBe(originalSettings.group);
			expect(updatedSettings.key).toBe(originalSettings.key);
			expect(updatedSettings.createdBy).toBe(originalSettings.createdBy);
			expect(updatedSettings.createdAt).toBe(originalSettings.createdAt);
		});

		it('should update setting value to null', () => {
			// Arrange
			const originalSettings = Settings.create({
				id: 'test-id',
				group: 'site',
				key: 'title',
				value: 'Original Title',
				createdBy: 'creator'
			});

			// Act
			const updatedSettings = originalSettings.updateValue(null, 'updater');

			// Assert
			expect(updatedSettings.value).toBeNull();
			expect(updatedSettings.updatedBy).toBe('updater');
		});

		it('should not modify the original instance (immutability)', () => {
			// Arrange
			const originalSettings = Settings.create({
				id: 'test-id',
				group: 'site',
				key: 'title',
				value: 'Original Title',
				createdBy: 'creator'
			});

			// Act
			const updatedSettings = originalSettings.updateValue('New Title', 'updater');

			// Assert
			expect(originalSettings.value).toBe('Original Title');
			expect(originalSettings.updatedBy).toBeNull();
			expect(originalSettings.updatedAt).toBeNull();
			expect(updatedSettings).not.toBe(originalSettings);
		});
	});

	describe('toJSON', () => {
		it('should serialize to JSON object correctly', () => {
			// Arrange
			const settings = Settings.create({
				id: 'test-id-123',
				group: 'site',
				key: 'title',
				value: 'My Blog',
				type: 'string',
				flags: 'PUBLIC',
				createdBy: 'test-user'
			});

			// Act
			const json = settings.toJSON();

			// Assert
			expect(json).toEqual({
				id: 'test-id-123',
				group: 'site',
				key: 'title',
				value: 'My Blog',
				type: 'string',
				flags: 'PUBLIC',
				createdAt: settings.createdAt,
				createdBy: 'test-user',
				updatedAt: null,
				updatedBy: null
			});
		});

		it('should serialize updated settings correctly', () => {
			// Arrange
			const originalSettings = Settings.create({
				id: 'test-id',
				group: 'site',
				key: 'title',
				value: 'Original',
				createdBy: 'creator'
			});

			const updatedSettings = originalSettings.updateValue('Updated', 'updater');

			// Act
			const json = updatedSettings.toJSON();

			// Assert
			expect(json.value).toBe('Updated');
			expect(json.updatedBy).toBe('updater');
			expect(json.updatedAt).toBeInstanceOf(Date);
		});
	});

	describe('constructor validation', () => {
		it('should validate group and key in constructor', () => {
			// Act & Assert
			expect(() => new Settings(
				'id', 
				'', // invalid group
				'key', 
				'value', 
				'type', 
				null, 
				new Date(), 
				'creator', 
				null, 
				null
			)).toThrow('Group cannot be empty');

			expect(() => new Settings(
				'id', 
				'group', 
				'', // invalid key
				'value', 
				'type', 
				null, 
				new Date(), 
				'creator', 
				null, 
				null
			)).toThrow('Key cannot be empty');
		});
	});
});