import type { Tag } from './Tag';

export interface TagRepository {
	/**
	 * Get all tags by visibility with post count
	 */
	getByVisibilityWithPostCount(visibility: string): Promise<Array<Tag & { totalPosts: number }>>;

	/**
	 * Get tag by slug
	 */
	getBySlug(slug: string): Promise<Tag | null>;

	/**
	 * Get tag by ID
	 */
	getById(id: string): Promise<Tag | null>;

	/**
	 * Get all tags
	 */
	getAll(): Promise<Tag[]>;

	/**
	 * Create new tag
	 */
	create(tag: Tag): Promise<Tag>;

	/**
	 * Update tag
	 */
	update(tag: Tag): Promise<Tag>;

	/**
	 * Delete tag by ID
	 */
	deleteById(id: string): Promise<void>;

	/**
	 * Check if slug exists
	 */
	slugExists(slug: string, excludeId?: string): Promise<boolean>;
}