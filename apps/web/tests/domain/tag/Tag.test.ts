import { describe, it, expect } from 'vitest';
import { Tag } from '../../../src/domain/tag/Tag';

describe('Tag Entity', () => {
	describe('create', () => {
		it('should create a new Tag instance with required fields', () => {
			// Arrange
			const tagData = {
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'test-user'
			};

			// Act
			const tag = Tag.create(tagData);

			// Assert
			expect(tag.id).toBe('tag-123');
			expect(tag.name).toBe('JavaScript');
			expect(tag.slug).toBe('javascript');
			expect(tag.visibility).toBe('public'); // default value
			expect(tag.description).toBeNull(); // default value
			expect(tag.featureImage).toBeNull(); // default value
			expect(tag.createdBy).toBe('test-user');
			expect(tag.createdAt).toBeInstanceOf(Date);
			expect(tag.updatedAt).toBeNull();
			expect(tag.updatedBy).toBeNull();
		});

		it('should create a Tag instance with all optional fields', () => {
			// Arrange
			const tagData = {
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				description: 'Programming language',
				featureImage: '/images/js.png',
				visibility: 'internal',
				createdBy: 'test-user'
			};

			// Act
			const tag = Tag.create(tagData);

			// Assert
			expect(tag.description).toBe('Programming language');
			expect(tag.featureImage).toBe('/images/js.png');
			expect(tag.visibility).toBe('internal');
		});

		it('should create a Tag instance with null optional fields', () => {
			// Arrange
			const tagData = {
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				description: null,
				featureImage: null,
				createdBy: 'test-user'
			};

			// Act
			const tag = Tag.create(tagData);

			// Assert
			expect(tag.description).toBeNull();
			expect(tag.featureImage).toBeNull();
		});

		it('should validate name during creation', () => {
			// Act & Assert
			expect(() => Tag.create({
				id: 'tag-id',
				name: '', // invalid name
				slug: 'javascript',
				createdBy: 'user'
			})).toThrow('Name cannot be empty');

			expect(() => Tag.create({
				id: 'tag-id',
				name: 'a'.repeat(192), // too long name
				slug: 'javascript',
				createdBy: 'user'
			})).toThrow('Name too long');
		});

		it('should validate slug during creation', () => {
			// Act & Assert
			expect(() => Tag.create({
				id: 'tag-id',
				name: 'JavaScript',
				slug: '', // invalid slug
				createdBy: 'user'
			})).toThrow('Slug cannot be empty');

			expect(() => Tag.create({
				id: 'tag-id',
				name: 'JavaScript',
				slug: 'a'.repeat(192), // too long slug
				createdBy: 'user'
			})).toThrow('Slug too long');
		});
	});

	describe('update', () => {
		it('should update tag fields and set updated timestamp', () => {
			// Arrange
			const originalTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				description: 'Original description',
				visibility: 'public',
				createdBy: 'creator'
			});

			const updateData = {
				name: 'Updated JavaScript',
				description: 'Updated description',
				visibility: 'internal',
				updatedBy: 'updater'
			};

			// Act
			const updatedTag = originalTag.update(updateData);

			// Assert
			expect(updatedTag.name).toBe('Updated JavaScript');
			expect(updatedTag.description).toBe('Updated description');
			expect(updatedTag.visibility).toBe('internal');
			expect(updatedTag.updatedBy).toBe('updater');
			expect(updatedTag.updatedAt).toBeInstanceOf(Date);
			
			// Original values should remain unchanged for non-updated fields
			expect(updatedTag.id).toBe(originalTag.id);
			expect(updatedTag.slug).toBe(originalTag.slug);
			expect(updatedTag.createdBy).toBe(originalTag.createdBy);
			expect(updatedTag.createdAt).toBe(originalTag.createdAt);
		});

		it('should update partial fields only', () => {
			// Arrange
			const originalTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				description: 'Original description',
				featureImage: '/images/old.png',
				createdBy: 'creator'
			});

			const updateData = {
				name: 'Updated JavaScript',
				updatedBy: 'updater'
			};

			// Act
			const updatedTag = originalTag.update(updateData);

			// Assert
			expect(updatedTag.name).toBe('Updated JavaScript');
			expect(updatedTag.description).toBe('Original description'); // unchanged
			expect(updatedTag.featureImage).toBe('/images/old.png'); // unchanged
			expect(updatedTag.slug).toBe('javascript'); // unchanged
		});

		it('should validate name when updating', () => {
			// Arrange
			const originalTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			// Act & Assert
			expect(() => originalTag.update({
				name: '', // invalid name
				updatedBy: 'updater'
			})).toThrow('Name cannot be empty');
		});

		it('should validate slug when updating', () => {
			// Arrange
			const originalTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			// Act & Assert
			expect(() => originalTag.update({
				slug: '', // invalid slug
				updatedBy: 'updater'
			})).toThrow('Slug cannot be empty');
		});

		it('should not validate unchanged fields', () => {
			// Arrange
			const originalTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			// Act & Assert - should not throw even if we pass the same values
			expect(() => originalTag.update({
				name: 'JavaScript', // same name
				slug: 'javascript', // same slug
				updatedBy: 'updater'
			})).not.toThrow();
		});

		it('should not modify the original instance (immutability)', () => {
			// Arrange
			const originalTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			// Act
			const updatedTag = originalTag.update({
				name: 'Updated JavaScript',
				updatedBy: 'updater'
			});

			// Assert
			expect(originalTag.name).toBe('JavaScript');
			expect(originalTag.updatedBy).toBeNull();
			expect(originalTag.updatedAt).toBeNull();
			expect(updatedTag).not.toBe(originalTag);
		});
	});

	describe('toJSON', () => {
		it('should serialize to JSON object correctly', () => {
			// Arrange
			const tag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				description: 'Programming language',
				featureImage: '/images/js.png',
				visibility: 'public',
				createdBy: 'test-user'
			});

			// Act
			const json = tag.toJSON();

			// Assert
			expect(json).toEqual({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				description: 'Programming language',
				featureImage: '/images/js.png',
				visibility: 'public',
				ogImage: null,
				ogTitle: null,
				ogDescription: null,
				twitterImage: null,
				twitterTitle: null,
				twitterDescription: null,
				metaTitle: null,
				metaDescription: null,
				codeinjectionHead: null,
				codeinjectionFoot: null,
				canonicalUrl: null,
				accentColor: null,
				createdAt: tag.createdAt,
				createdBy: 'test-user',
				updatedAt: null,
				updatedBy: null
			});
		});

		it('should serialize updated tag correctly', () => {
			// Arrange
			const originalTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			const updatedTag = originalTag.update({
				name: 'Updated JavaScript',
				updatedBy: 'updater'
			});

			// Act
			const json = updatedTag.toJSON();

			// Assert
			expect(json.name).toBe('Updated JavaScript');
			expect(json.updatedBy).toBe('updater');
			expect(json.updatedAt).toBeInstanceOf(Date);
		});
	});

	describe('constructor validation', () => {
		it('should validate name and slug in constructor', () => {
			// Act & Assert
			expect(() => new Tag(
				'id', 
				'', // invalid name
				'slug', 
				null, 
				null, 
				'public', 
				null, null, null, null, null, null, null, null, null, null, null, null,
				new Date(), 
				'creator', 
				null, 
				null
			)).toThrow('Name cannot be empty');

			expect(() => new Tag(
				'id', 
				'name', 
				'', // invalid slug
				null, 
				null, 
				'public', 
				null, null, null, null, null, null, null, null, null, null, null, null,
				new Date(), 
				'creator', 
				null, 
				null
			)).toThrow('Slug cannot be empty');
		});
	});
});