import { eq, and, ne, count } from 'drizzle-orm';
import type { DrizzleDB } from '../db/drizzleClient';
import type { TagRepository } from '../../domain/tag/TagRepository';
import { Tag } from '../../domain/tag/Tag';
import { tags, tagsSqlite, postsTags, postsTagsSqlite } from '../db/schema/tag';
import { DATABASE_TYPE } from '$env/static/private';

export class DrizzleTagRepository implements TagRepository {
	constructor(private db: DrizzleDB) {}

	private get table() {
		return DATABASE_TYPE === 'development' || DATABASE_TYPE === 'sqlite' 
			? tagsSqlite 
			: tags;
	}

	private get postsTagsTable() {
		return DATABASE_TYPE === 'development' || DATABASE_TYPE === 'sqlite' 
			? postsTagsSqlite 
			: postsTags;
	}

	async getByVisibilityWithPostCount(visibility: string): Promise<Array<Tag & { totalPosts: number }>> {
		const results = await this.db
			.select({
				...this.table,
				totalPosts: count(this.postsTagsTable.postId)
			})
			.from(this.table)
			.leftJoin(this.postsTagsTable, eq(this.postsTagsTable.tagId, this.table.id))
			.where(eq(this.table.visibility, visibility))
			.groupBy(this.table.id)
			.orderBy(this.table.name);

		return results.map(row => ({
			...this.mapToEntity(row),
			totalPosts: row.totalPosts || 0
		}));
	}

	async getBySlug(slug: string): Promise<Tag | null> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.slug, slug))
			.limit(1);

		if (results.length === 0) {
			return null;
		}

		return this.mapToEntity(results[0]);
	}

	async getById(id: string): Promise<Tag | null> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.id, id))
			.limit(1);

		if (results.length === 0) {
			return null;
		}

		return this.mapToEntity(results[0]);
	}

	async getAll(): Promise<Tag[]> {
		const results = await this.db
			.select()
			.from(this.table)
			.orderBy(this.table.name);

		return results.map(this.mapToEntity);
	}

	async create(tag: Tag): Promise<Tag> {
		const data = this.mapToTable(tag);
		
		await this.db.insert(this.table).values(data);
		
		// Return the created tag
		const created = await this.getById(tag.id);
		if (!created) {
			throw new Error('Failed to create tag');
		}
		return created;
	}

	async update(tag: Tag): Promise<Tag> {
		const data = this.mapToTable(tag);
		
		await this.db
			.update(this.table)
			.set(data)
			.where(eq(this.table.id, tag.id));
		
		// Return the updated tag
		const updated = await this.getById(tag.id);
		if (!updated) {
			throw new Error('Failed to update tag');
		}
		return updated;
	}

	async deleteById(id: string): Promise<void> {
		await this.db
			.delete(this.table)
			.where(eq(this.table.id, id));
	}

	async slugExists(slug: string, excludeId?: string): Promise<boolean> {
		const query = this.db
			.select({ id: this.table.id })
			.from(this.table)
			.where(eq(this.table.slug, slug));

		if (excludeId) {
			query.where(and(eq(this.table.slug, slug), ne(this.table.id, excludeId)));
		}

		const results = await query.limit(1);
		return results.length > 0;
	}

	private mapToEntity(row: any): Tag {
		return new Tag(
			row.id,
			row.name,
			row.slug,
			row.description,
			row.featureImage,
			row.visibility,
			row.ogImage,
			row.ogTitle,
			row.ogDescription,
			row.twitterImage,
			row.twitterTitle,
			row.twitterDescription,
			row.metaTitle,
			row.metaDescription,
			row.codeinjectionHead,
			row.codeinjectionFoot,
			row.canonicalUrl,
			row.accentColor,
			new Date(row.createdAt),
			row.createdBy,
			row.updatedAt ? new Date(row.updatedAt) : null,
			row.updatedBy
		);
	}

	private mapToTable(tag: Tag) {
		return {
			id: tag.id,
			name: tag.name,
			slug: tag.slug,
			description: tag.description,
			featureImage: tag.featureImage,
			visibility: tag.visibility,
			ogImage: tag.ogImage,
			ogTitle: tag.ogTitle,
			ogDescription: tag.ogDescription,
			twitterImage: tag.twitterImage,
			twitterTitle: tag.twitterTitle,
			twitterDescription: tag.twitterDescription,
			metaTitle: tag.metaTitle,
			metaDescription: tag.metaDescription,
			codeinjectionHead: tag.codeinjectionHead,
			codeinjectionFoot: tag.codeinjectionFoot,
			canonicalUrl: tag.canonicalUrl,
			accentColor: tag.accentColor,
			createdAt: tag.createdAt,
			createdBy: tag.createdBy,
			updatedAt: tag.updatedAt,
			updatedBy: tag.updatedBy
		};
	}
}