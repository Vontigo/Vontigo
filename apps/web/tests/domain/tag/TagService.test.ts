import { describe, it, expect, beforeEach, vi } from 'vitest';
import { Tag } from '../../../src/domain/tag/Tag';
import { TagService } from '../../../src/domain/tag/TagService';
import type { TagRepository } from '../../../src/domain/tag/TagRepository';

// Mock TagRepository
const mockTagRepository: TagRepository = {
	getByVisibilityWithPostCount: vi.fn(),
	getBySlug: vi.fn(),
	getById: vi.fn(),
	getAll: vi.fn(),
	create: vi.fn(),
	update: vi.fn(),
	deleteById: vi.fn(),
	slugExists: vi.fn()
};

describe('TagService', () => {
	let tagService: TagService;

	beforeEach(() => {
		tagService = new TagService(mockTagRepository);
		vi.clearAllMocks();
	});

	describe('getTagsByVisibility', () => {
		it('should return tags with post count for valid visibility', async () => {
			// Arrange
			const visibility = 'public';
			const expectedTags = [
				{ 
					...Tag.create({
						id: 'tag-1',
						name: 'JavaScript',
						slug: 'javascript',
						visibility: 'public',
						createdBy: 'user'
					}),
					totalPosts: 5 
				}
			];
			vi.mocked(mockTagRepository.getByVisibilityWithPostCount).mockResolvedValue(expectedTags);

			// Act
			const result = await tagService.getTagsByVisibility(visibility);

			// Assert
			expect(mockTagRepository.getByVisibilityWithPostCount).toHaveBeenCalledWith(visibility);
			expect(result).toEqual(expectedTags);
		});

		it('should trim whitespace from visibility parameter', async () => {
			// Arrange
			const visibility = '  public  ';
			vi.mocked(mockTagRepository.getByVisibilityWithPostCount).mockResolvedValue([]);

			// Act
			await tagService.getTagsByVisibility(visibility);

			// Assert
			expect(mockTagRepository.getByVisibilityWithPostCount).toHaveBeenCalledWith('public');
		});

		it('should throw error for empty visibility', async () => {
			// Act & Assert
			await expect(tagService.getTagsByVisibility('')).rejects.toThrow('Visibility is required');
			await expect(tagService.getTagsByVisibility('   ')).rejects.toThrow('Visibility is required');
		});

		it('should throw error for invalid visibility', async () => {
			// Act & Assert
			await expect(tagService.getTagsByVisibility('invalid')).rejects.toThrow(
				'Invalid visibility. Must be one of: public, internal'
			);
		});

		it('should accept valid visibility values', async () => {
			// Arrange
			vi.mocked(mockTagRepository.getByVisibilityWithPostCount).mockResolvedValue([]);

			// Act & Assert
			await expect(tagService.getTagsByVisibility('public')).resolves.not.toThrow();
			await expect(tagService.getTagsByVisibility('internal')).resolves.not.toThrow();
		});
	});

	describe('getBySlug', () => {
		it('should return tag for valid slug', async () => {
			// Arrange
			const slug = 'javascript';
			const expectedTag = Tag.create({
				id: 'tag-1',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'user'
			});
			vi.mocked(mockTagRepository.getBySlug).mockResolvedValue(expectedTag);

			// Act
			const result = await tagService.getBySlug(slug);

			// Assert
			expect(mockTagRepository.getBySlug).toHaveBeenCalledWith(slug);
			expect(result).toEqual(expectedTag);
		});

		it('should return null for non-existent slug', async () => {
			// Arrange
			vi.mocked(mockTagRepository.getBySlug).mockResolvedValue(null);

			// Act
			const result = await tagService.getBySlug('non-existent');

			// Assert
			expect(result).toBeNull();
		});

		it('should throw error for empty slug', async () => {
			// Act & Assert
			await expect(tagService.getBySlug('')).rejects.toThrow('Slug is required');
		});
	});

	describe('getById', () => {
		it('should return tag for valid ID', async () => {
			// Arrange
			const id = 'tag-123';
			const expectedTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'user'
			});
			vi.mocked(mockTagRepository.getById).mockResolvedValue(expectedTag);

			// Act
			const result = await tagService.getById(id);

			// Assert
			expect(mockTagRepository.getById).toHaveBeenCalledWith(id);
			expect(result).toEqual(expectedTag);
		});

		it('should throw error for empty ID', async () => {
			// Act & Assert
			await expect(tagService.getById('')).rejects.toThrow('ID is required');
		});
	});

	describe('getAllTags', () => {
		it('should return all tags', async () => {
			// Arrange
			const expectedTags = [
				Tag.create({
					id: 'tag-1',
					name: 'JavaScript',
					slug: 'javascript',
					createdBy: 'user'
				}),
				Tag.create({
					id: 'tag-2',
					name: 'TypeScript',
					slug: 'typescript',
					createdBy: 'user'
				})
			];
			vi.mocked(mockTagRepository.getAll).mockResolvedValue(expectedTags);

			// Act
			const result = await tagService.getAllTags();

			// Assert
			expect(mockTagRepository.getAll).toHaveBeenCalledOnce();
			expect(result).toEqual(expectedTags);
		});
	});

	describe('createTag', () => {
		it('should create a new tag successfully', async () => {
			// Arrange
			const tagData = {
				name: 'JavaScript',
				slug: 'javascript',
				description: 'Programming language',
				featureImage: '/images/js.png',
				visibility: 'public',
				createdBy: 'user-123'
			};

			vi.mocked(mockTagRepository.slugExists).mockResolvedValue(false);
			vi.mocked(mockTagRepository.create).mockImplementation(async (tag) => tag);

			// Act
			const result = await tagService.createTag(tagData);

			// Assert
			expect(mockTagRepository.slugExists).toHaveBeenCalledWith('javascript');
			expect(mockTagRepository.create).toHaveBeenCalled();
			expect(result.name).toBe('JavaScript');
			expect(result.slug).toBe('javascript');
		});

		it('should throw error if slug already exists', async () => {
			// Arrange
			const tagData = {
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'user-123'
			};

			vi.mocked(mockTagRepository.slugExists).mockResolvedValue(true);

			// Act & Assert
			await expect(tagService.createTag(tagData)).rejects.toThrow(
				"Tag with slug 'javascript' already exists"
			);
		});

		it('should throw error for missing required fields', async () => {
			// Act & Assert
			await expect(tagService.createTag({
				name: '',
				slug: 'test',
				createdBy: 'user'
			})).rejects.toThrow('Name is required');

			await expect(tagService.createTag({
				name: 'Test',
				slug: '',
				createdBy: 'user'
			})).rejects.toThrow('Slug is required');

			await expect(tagService.createTag({
				name: 'Test',
				slug: 'test',
				createdBy: ''
			})).rejects.toThrow('CreatedBy is required');
		});

		it('should trim whitespace from input data and set defaults', async () => {
			// Arrange
			const tagData = {
				name: '  JavaScript  ',
				slug: '  javascript  ',
				description: '  Language  ',
				featureImage: '  /images/js.png  ',
				createdBy: '  user-123  '
			};

			vi.mocked(mockTagRepository.slugExists).mockResolvedValue(false);
			vi.mocked(mockTagRepository.create).mockImplementation(async (tag) => tag);

			// Act
			const result = await tagService.createTag(tagData);

			// Assert
			expect(result.name).toBe('JavaScript');
			expect(result.slug).toBe('javascript');
			expect(result.description).toBe('Language');
			expect(result.featureImage).toBe('/images/js.png');
			expect(result.visibility).toBe('public'); // default value
			expect(result.createdBy).toBe('user-123');
		});
	});

	describe('updateTag', () => {
		it('should update tag successfully', async () => {
			// Arrange
			const id = 'tag-123';
			const updateData = {
				name: 'Updated JavaScript',
				description: 'Updated description',
				updatedBy: 'updater'
			};

			const existingTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			vi.mocked(mockTagRepository.getById).mockResolvedValue(existingTag);
			vi.mocked(mockTagRepository.update).mockImplementation(async (tag) => tag);

			// Act
			const result = await tagService.updateTag(id, updateData);

			// Assert
			expect(mockTagRepository.getById).toHaveBeenCalledWith(id);
			expect(mockTagRepository.update).toHaveBeenCalled();
			expect(result.name).toBe('Updated JavaScript');
			expect(result.updatedBy).toBe('updater');
		});

		it('should check slug uniqueness when updating slug', async () => {
			// Arrange
			const id = 'tag-123';
			const updateData = {
				slug: 'new-slug',
				updatedBy: 'updater'
			};

			const existingTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			vi.mocked(mockTagRepository.getById).mockResolvedValue(existingTag);
			vi.mocked(mockTagRepository.slugExists).mockResolvedValue(false);
			vi.mocked(mockTagRepository.update).mockImplementation(async (tag) => tag);

			// Act
			await tagService.updateTag(id, updateData);

			// Assert
			expect(mockTagRepository.slugExists).toHaveBeenCalledWith('new-slug', id);
		});

		it('should throw error if new slug already exists', async () => {
			// Arrange
			const id = 'tag-123';
			const updateData = {
				slug: 'existing-slug',
				updatedBy: 'updater'
			};

			const existingTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			vi.mocked(mockTagRepository.getById).mockResolvedValue(existingTag);
			vi.mocked(mockTagRepository.slugExists).mockResolvedValue(true);

			// Act & Assert
			await expect(tagService.updateTag(id, updateData)).rejects.toThrow(
				"Tag with slug 'existing-slug' already exists"
			);
		});

		it('should throw error if tag not found', async () => {
			// Arrange
			vi.mocked(mockTagRepository.getById).mockResolvedValue(null);

			// Act & Assert
			await expect(tagService.updateTag('non-existent', { updatedBy: 'user' })).rejects.toThrow(
				"Tag with ID 'non-existent' not found"
			);
		});
	});

	describe('deleteTag', () => {
		it('should delete tag successfully', async () => {
			// Arrange
			const id = 'tag-123';
			const existingTag = Tag.create({
				id: 'tag-123',
				name: 'JavaScript',
				slug: 'javascript',
				createdBy: 'creator'
			});

			vi.mocked(mockTagRepository.getById).mockResolvedValue(existingTag);
			vi.mocked(mockTagRepository.deleteById).mockResolvedValue(undefined);

			// Act
			await tagService.deleteTag(id);

			// Assert
			expect(mockTagRepository.getById).toHaveBeenCalledWith(id);
			expect(mockTagRepository.deleteById).toHaveBeenCalledWith(id);
		});

		it('should throw error if tag not found', async () => {
			// Arrange
			vi.mocked(mockTagRepository.getById).mockResolvedValue(null);

			// Act & Assert
			await expect(tagService.deleteTag('non-existent')).rejects.toThrow(
				"Tag with ID 'non-existent' not found"
			);
		});
	});

	describe('generateSlug', () => {
		it('should generate basic slug from name', async () => {
			// Arrange
			const name = 'JavaScript Programming';
			vi.mocked(mockTagRepository.slugExists).mockResolvedValue(false);

			// Act
			const result = await tagService.generateSlug(name);

			// Assert
			expect(result).toBe('javascript-programming');
		});

		it('should generate unique slug when base slug exists', async () => {
			// Arrange
			const name = 'JavaScript';
			vi.mocked(mockTagRepository.slugExists)
				.mockResolvedValueOnce(true)  // 'javascript' exists
				.mockResolvedValueOnce(false); // 'javascript-1' is unique

			// Act
			const result = await tagService.generateSlug(name);

			// Assert
			expect(result).toBe('javascript-1');
			expect(mockTagRepository.slugExists).toHaveBeenCalledTimes(2);
		});

		it('should handle special characters in name', async () => {
			// Arrange
			const name = 'C++ & C# Programming!';
			vi.mocked(mockTagRepository.slugExists).mockResolvedValue(false);

			// Act
			const result = await tagService.generateSlug(name);

			// Assert
			expect(result).toBe('c-c-programming');
		});

		it('should throw error for empty name', async () => {
			// Act & Assert
			await expect(tagService.generateSlug('')).rejects.toThrow('Name is required');
		});
	});
});