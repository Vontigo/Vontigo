import { describe, it, expect } from 'vitest';
import { Member } from '../../../src/domain/member/Member';

describe('Member Entity', () => {
	describe('create', () => {
		it('should create a new Member instance with required fields', () => {
			// Arrange
			const memberData = {
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				createdBy: 'admin'
			};

			// Act
			const member = Member.create(memberData);

			// Assert
			expect(member.id).toBe('member-123');
			expect(member.uuid).toBe('uuid-123');
			expect(member.email).toBe('test@example.com');
			expect(member.status).toBe('free'); // default value
			expect(member.name).toBeNull(); // default value
			expect(member.enableCommentNotifications).toBe(true); // default value
			expect(member.emailCount).toBe(0); // default value
			expect(member.emailOpenedCount).toBe(0); // default value
			expect(member.emailOpenRate).toBeNull(); // default value
			expect(member.lastSeenAt).toBeNull(); // default value
			expect(member.lastCommentedAt).toBeNull(); // default value
			expect(member.createdBy).toBe('admin');
			expect(member.createdAt).toBeInstanceOf(Date);
			expect(member.updatedAt).toBeNull();
			expect(member.updatedBy).toBeNull();
		});

		it('should create a Member instance with all optional fields', () => {
			// Arrange
			const memberData = {
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				status: 'paid',
				name: 'John Doe',
				expertise: 'JavaScript',
				note: 'Expert developer',
				geolocation: 'US',
				enableCommentNotifications: false,
				createdBy: 'admin'
			};

			// Act
			const member = Member.create(memberData);

			// Assert
			expect(member.status).toBe('paid');
			expect(member.name).toBe('John Doe');
			expect(member.expertise).toBe('JavaScript');
			expect(member.note).toBe('Expert developer');
			expect(member.geolocation).toBe('US');
			expect(member.enableCommentNotifications).toBe(false);
		});

		it('should create a Member instance with null optional fields', () => {
			// Arrange
			const memberData = {
				id: 'member-123',
				email: 'test@example.com',
				uuid: null,
				name: null,
				expertise: null,
				note: null,
				geolocation: null,
				createdBy: 'admin'
			};

			// Act
			const member = Member.create(memberData);

			// Assert
			expect(member.uuid).toBeNull();
			expect(member.name).toBeNull();
			expect(member.expertise).toBeNull();
			expect(member.note).toBeNull();
			expect(member.geolocation).toBeNull();
		});

		it('should validate email during creation', () => {
			// Act & Assert
			expect(() => Member.create({
				id: 'member-id',
				email: '', // invalid email
				createdBy: 'admin'
			})).toThrow('Invalid member email');

			expect(() => Member.create({
				id: 'member-id',
				email: 'invalid-email', // invalid format
				createdBy: 'admin'
			})).toThrow('Invalid member email');
		});

		it('should validate name when provided during creation', () => {
			// Act & Assert
			expect(() => Member.create({
				id: 'member-id',
				email: 'test@example.com',
				name: '', // invalid name
				createdBy: 'admin'
			})).toThrow('Name cannot be empty');

			expect(() => Member.create({
				id: 'member-id',
				email: 'test@example.com',
				name: 'a'.repeat(192), // too long name
				createdBy: 'admin'
			})).toThrow('Name too long');
		});

		it('should not validate null name during creation', () => {
			// Act & Assert
			expect(() => Member.create({
				id: 'member-id',
				email: 'test@example.com',
				name: null, // null name should not be validated
				createdBy: 'admin'
			})).not.toThrow();
		});
	});

	describe('update', () => {
		it('should update member fields and set updated timestamp', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				name: 'Original Name',
				expertise: 'Original Expertise',
				status: 'free',
				enableCommentNotifications: true,
				createdBy: 'creator'
			});

			const updateData = {
				name: 'Updated Name',
				expertise: 'Updated Expertise',
				status: 'paid',
				enableCommentNotifications: false,
				updatedBy: 'updater'
			};

			// Act
			const updatedMember = originalMember.update(updateData);

			// Assert
			expect(updatedMember.name).toBe('Updated Name');
			expect(updatedMember.expertise).toBe('Updated Expertise');
			expect(updatedMember.status).toBe('paid');
			expect(updatedMember.enableCommentNotifications).toBe(false);
			expect(updatedMember.updatedBy).toBe('updater');
			expect(updatedMember.updatedAt).toBeInstanceOf(Date);
			
			// Original values should remain unchanged for non-updated fields
			expect(updatedMember.id).toBe(originalMember.id);
			expect(updatedMember.email).toBe(originalMember.email);
			expect(updatedMember.createdBy).toBe(originalMember.createdBy);
			expect(updatedMember.createdAt).toBe(originalMember.createdAt);
		});

		it('should update partial fields only', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				name: 'Original Name',
				expertise: 'Original Expertise',
				note: 'Original Note',
				createdBy: 'creator'
			});

			const updateData = {
				name: 'Updated Name',
				updatedBy: 'updater'
			};

			// Act
			const updatedMember = originalMember.update(updateData);

			// Assert
			expect(updatedMember.name).toBe('Updated Name');
			expect(updatedMember.expertise).toBe('Original Expertise'); // unchanged
			expect(updatedMember.note).toBe('Original Note'); // unchanged
		});

		it('should handle undefined vs null values correctly', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				name: 'Original Name',
				expertise: 'Original Expertise',
				createdBy: 'creator'
			});

			// Act
			const updatedWithNull = originalMember.update({
				name: null, // explicitly set to null
				updatedBy: 'updater'
			});

			const updatedWithUndefined = originalMember.update({
				// name: undefined, // not provided, should keep original
				expertise: null, // explicitly set to null
				updatedBy: 'updater'
			});

			// Assert
			expect(updatedWithNull.name).toBeNull();
			expect(updatedWithUndefined.name).toBe('Original Name'); // should keep original
			expect(updatedWithUndefined.expertise).toBeNull();
		});

		it('should validate name when updating', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				createdBy: 'creator'
			});

			// Act & Assert
			expect(() => originalMember.update({
				name: '', // invalid name
				updatedBy: 'updater'
			})).toThrow('Name cannot be empty');
		});

		it('should not validate unchanged name', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				name: 'John Doe',
				createdBy: 'creator'
			});

			// Act & Assert - should not throw even if we pass the same name
			expect(() => originalMember.update({
				name: 'John Doe', // same name
				updatedBy: 'updater'
			})).not.toThrow();
		});

		it('should not modify the original instance (immutability)', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				name: 'Original Name',
				createdBy: 'creator'
			});

			// Act
			const updatedMember = originalMember.update({
				name: 'Updated Name',
				updatedBy: 'updater'
			});

			// Assert
			expect(originalMember.name).toBe('Original Name');
			expect(originalMember.updatedBy).toBeNull();
			expect(originalMember.updatedAt).toBeNull();
			expect(updatedMember).not.toBe(originalMember);
		});
	});

	describe('updateActivity', () => {
		it('should update activity fields and set updated timestamp', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				createdBy: 'creator'
			});

			const lastSeenAt = new Date();
			const lastCommentedAt = new Date();
			const activityData = {
				lastSeenAt,
				lastCommentedAt,
				emailCount: 10,
				emailOpenedCount: 7,
				emailOpenRate: 0.7,
				updatedBy: 'system'
			};

			// Act
			const updatedMember = originalMember.updateActivity(activityData);

			// Assert
			expect(updatedMember.lastSeenAt).toBe(lastSeenAt);
			expect(updatedMember.lastCommentedAt).toBe(lastCommentedAt);
			expect(updatedMember.emailCount).toBe(10);
			expect(updatedMember.emailOpenedCount).toBe(7);
			expect(updatedMember.emailOpenRate).toBe(0.7);
			expect(updatedMember.updatedBy).toBe('system');
			expect(updatedMember.updatedAt).toBeInstanceOf(Date);
			
			// Profile data should remain unchanged
			expect(updatedMember.name).toBe(originalMember.name);
			expect(updatedMember.expertise).toBe(originalMember.expertise);
		});

		it('should handle undefined vs null values correctly in activity update', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				createdBy: 'creator'
			});

			// First update with some values
			const memberWithActivity = originalMember.updateActivity({
				emailCount: 5,
				emailOpenRate: 0.5,
				updatedBy: 'system'
			});

			// Act - update with some fields as null, some undefined
			const updatedMember = memberWithActivity.updateActivity({
				emailOpenRate: null, // explicitly set to null
				emailOpenedCount: 3, // update this field
				// emailCount: undefined, // not provided, should keep original
				updatedBy: 'system'
			});

			// Assert
			expect(updatedMember.emailCount).toBe(5); // should keep original
			expect(updatedMember.emailOpenedCount).toBe(3); // updated
			expect(updatedMember.emailOpenRate).toBeNull(); // explicitly set to null
		});

		it('should not modify the original instance (immutability)', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				createdBy: 'creator'
			});

			// Act
			const updatedMember = originalMember.updateActivity({
				emailCount: 10,
				updatedBy: 'system'
			});

			// Assert
			expect(originalMember.emailCount).toBe(0);
			expect(originalMember.updatedBy).toBeNull();
			expect(originalMember.updatedAt).toBeNull();
			expect(updatedMember).not.toBe(originalMember);
		});
	});

	describe('toJSON', () => {
		it('should serialize to JSON object correctly', () => {
			// Arrange
			const member = Member.create({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				status: 'paid',
				name: 'John Doe',
				expertise: 'JavaScript',
				note: 'Expert developer',
				geolocation: 'US',
				enableCommentNotifications: false,
				createdBy: 'admin'
			});

			// Act
			const json = member.toJSON();

			// Assert
			expect(json).toEqual({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				status: 'paid',
				name: 'John Doe',
				expertise: 'JavaScript',
				note: 'Expert developer',
				geolocation: 'US',
				enableCommentNotifications: false,
				emailCount: 0,
				emailOpenedCount: 0,
				emailOpenRate: null,
				lastSeenAt: null,
				lastCommentedAt: null,
				createdAt: member.createdAt,
				createdBy: 'admin',
				updatedAt: null,
				updatedBy: null
			});
		});

		it('should serialize updated member correctly', () => {
			// Arrange
			const originalMember = Member.create({
				id: 'member-123',
				email: 'test@example.com',
				createdBy: 'creator'
			});

			const updatedMember = originalMember.update({
				name: 'Updated Name',
				updatedBy: 'updater'
			});

			// Act
			const json = updatedMember.toJSON();

			// Assert
			expect(json.name).toBe('Updated Name');
			expect(json.updatedBy).toBe('updater');
			expect(json.updatedAt).toBeInstanceOf(Date);
		});
	});

	describe('constructor validation', () => {
		it('should validate email in constructor', () => {
			// Act & Assert
			expect(() => new Member(
				'id', 
				'uuid', 
				'', // invalid email
				'free', 
				null, null, null, null, true, 0, 0, null, null, null,
				new Date(), 
				'creator', 
				null, 
				null
			)).toThrow('Invalid member email');
		});

		it('should validate name when provided in constructor', () => {
			// Act & Assert
			expect(() => new Member(
				'id', 
				'uuid', 
				'test@example.com', 
				'free', 
				'', // invalid name
				null, null, null, true, 0, 0, null, null, null,
				new Date(), 
				'creator', 
				null, 
				null
			)).toThrow('Name cannot be empty');
		});

		it('should not validate null name in constructor', () => {
			// Act & Assert
			expect(() => new Member(
				'id', 
				'uuid', 
				'test@example.com', 
				'free', 
				null, // null name should not be validated
				null, null, null, true, 0, 0, null, null, null,
				new Date(), 
				'creator', 
				null, 
				null
			)).not.toThrow();
		});
	});
});