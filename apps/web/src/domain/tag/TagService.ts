import type { TagRepository } from './TagRepository';
import { Tag } from './Tag';
import ObjectID from 'bson-objectid';

export class TagService {
	constructor(private tagRepository: TagRepository) {}

	/**
	 * Get tags by visibility with post count
	 */
	async getTagsByVisibility(visibility: string): Promise<Array<Tag & { totalPosts: number }>> {
		if (!visibility || visibility.trim() === '') {
			throw new Error('Visibility is required');
		}

		const validVisibilities = ['public', 'internal'];
		if (!validVisibilities.includes(visibility.trim())) {
			throw new Error(`Invalid visibility. Must be one of: ${validVisibilities.join(', ')}`);
		}

		return await this.tagRepository.getByVisibilityWithPostCount(visibility.trim());
	}

	/**
	 * Get tag by slug
	 */
	async getBySlug(slug: string): Promise<Tag | null> {
		if (!slug || slug.trim() === '') {
			throw new Error('Slug is required');
		}
		return await this.tagRepository.getBySlug(slug.trim());
	}

	/**
	 * Get tag by ID
	 */
	async getById(id: string): Promise<Tag | null> {
		if (!id || id.trim() === '') {
			throw new Error('ID is required');
		}
		return await this.tagRepository.getById(id.trim());
	}

	/**
	 * Get all tags
	 */
	async getAllTags(): Promise<Tag[]> {
		return await this.tagRepository.getAll();
	}

	/**
	 * Create new tag
	 */
	async createTag(data: {
		name: string;
		slug: string;
		description?: string | null;
		featureImage?: string | null;
		visibility?: string;
		createdBy: string;
	}): Promise<Tag> {
		// Validate input
		if (!data.name || data.name.trim() === '') {
			throw new Error('Name is required');
		}
		if (!data.slug || data.slug.trim() === '') {
			throw new Error('Slug is required');
		}
		if (!data.createdBy || data.createdBy.trim() === '') {
			throw new Error('CreatedBy is required');
		}

		// Check if slug already exists
		const slugExists = await this.tagRepository.slugExists(data.slug.trim());
		if (slugExists) {
			throw new Error(`Tag with slug '${data.slug}' already exists`);
		}

		// Create new tag
		const tag = Tag.create({
			id: new ObjectID().toHexString(),
			name: data.name.trim(),
			slug: data.slug.trim(),
			description: data.description?.trim() || null,
			featureImage: data.featureImage?.trim() || null,
			visibility: data.visibility?.trim() || 'public',
			createdBy: data.createdBy.trim()
		});

		return await this.tagRepository.create(tag);
	}

	/**
	 * Update tag
	 */
	async updateTag(id: string, data: {
		name?: string;
		slug?: string;
		description?: string | null;
		featureImage?: string | null;
		visibility?: string;
		updatedBy: string;
	}): Promise<Tag> {
		if (!id || id.trim() === '') {
			throw new Error('ID is required');
		}
		if (!data.updatedBy || data.updatedBy.trim() === '') {
			throw new Error('UpdatedBy is required');
		}

		const existing = await this.tagRepository.getById(id.trim());
		if (!existing) {
			throw new Error(`Tag with ID '${id}' not found`);
		}

		// Check if new slug conflicts with existing tags
		if (data.slug && data.slug.trim() !== existing.slug) {
			const slugExists = await this.tagRepository.slugExists(data.slug.trim(), id.trim());
			if (slugExists) {
				throw new Error(`Tag with slug '${data.slug}' already exists`);
			}
		}

		const updated = existing.update({
			name: data.name?.trim(),
			slug: data.slug?.trim(),
			description: data.description?.trim() || null,
			featureImage: data.featureImage?.trim() || null,
			visibility: data.visibility?.trim(),
			updatedBy: data.updatedBy.trim()
		});

		return await this.tagRepository.update(updated);
	}

	/**
	 * Delete tag by ID
	 */
	async deleteTag(id: string): Promise<void> {
		if (!id || id.trim() === '') {
			throw new Error('ID is required');
		}

		const existing = await this.tagRepository.getById(id.trim());
		if (!existing) {
			throw new Error(`Tag with ID '${id}' not found`);
		}

		await this.tagRepository.deleteById(id.trim());
	}

	/**
	 * Generate unique slug from name
	 */
	async generateSlug(name: string): Promise<string> {
		if (!name || name.trim() === '') {
			throw new Error('Name is required');
		}

		// Basic slug generation (could be enhanced)
		let baseSlug = name.trim()
			.toLowerCase()
			.replace(/[^a-z0-9\s-]/g, '')
			.replace(/\s+/g, '-')
			.replace(/-+/g, '-')
			.replace(/^-|-$/g, '');

		let slug = baseSlug;
		let counter = 1;

		// Ensure uniqueness
		while (await this.tagRepository.slugExists(slug)) {
			slug = `${baseSlug}-${counter}`;
			counter++;
		}

		return slug;
	}
}