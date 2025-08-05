import { pgTable, varchar, text, timestamp, pgEnum } from 'drizzle-orm/pg-core';
import { sqliteTable, text as sqliteText, integer as sqliteInteger } from 'drizzle-orm/sqlite-core';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { z } from 'zod';

// Tag visibility enum
export const tagVisibilityEnum = pgEnum('tag_visibility', ['public', 'internal']);

// PostgreSQL table
export const tags = pgTable('tags', {
	id: varchar('id', { length: 24 }).primaryKey(),
	name: varchar('name', { length: 191 }).notNull(),
	slug: varchar('slug', { length: 191 }).notNull().unique(),
	description: text('description'),
	featureImage: varchar('feature_image', { length: 2000 }),
	visibility: tagVisibilityEnum('visibility').notNull().default('public'),
	ogImage: varchar('og_image', { length: 2000 }),
	ogTitle: varchar('og_title', { length: 300 }),
	ogDescription: varchar('og_description', { length: 500 }),
	twitterImage: varchar('twitter_image', { length: 2000 }),
	twitterTitle: varchar('twitter_title', { length: 300 }),
	twitterDescription: varchar('twitter_description', { length: 500 }),
	metaTitle: varchar('meta_title', { length: 2000 }),
	metaDescription: varchar('meta_description', { length: 2000 }),
	codeinjectionHead: text('codeinjection_head'),
	codeinjectionFoot: text('codeinjection_foot'),
	canonicalUrl: varchar('canonical_url', { length: 2000 }),
	accentColor: varchar('accent_color', { length: 50 }),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	createdBy: varchar('created_by', { length: 24 }).notNull(),
	updatedAt: timestamp('updated_at'),
	updatedBy: varchar('updated_by', { length: 24 })
});

// SQLite table (for development)
export const tagsSqlite = sqliteTable('tags', {
	id: sqliteText('id', { length: 24 }).primaryKey(),
	name: sqliteText('name', { length: 191 }).notNull(),
	slug: sqliteText('slug', { length: 191 }).notNull().unique(),
	description: sqliteText('description'),
	featureImage: sqliteText('feature_image', { length: 2000 }),
	visibility: sqliteText('visibility').notNull().default('public'),
	ogImage: sqliteText('og_image', { length: 2000 }),
	ogTitle: sqliteText('og_title', { length: 300 }),
	ogDescription: sqliteText('og_description', { length: 500 }),
	twitterImage: sqliteText('twitter_image', { length: 2000 }),
	twitterTitle: sqliteText('twitter_title', { length: 300 }),
	twitterDescription: sqliteText('twitter_description', { length: 500 }),
	metaTitle: sqliteText('meta_title', { length: 2000 }),
	metaDescription: sqliteText('meta_description', { length: 2000 }),
	codeinjectionHead: sqliteText('codeinjection_head'),
	codeinjectionFoot: sqliteText('codeinjection_foot'),
	canonicalUrl: sqliteText('canonical_url', { length: 2000 }),
	accentColor: sqliteText('accent_color', { length: 50 }),
	createdAt: sqliteInteger('created_at', { mode: 'timestamp' }).notNull(),
	createdBy: sqliteText('created_by', { length: 24 }).notNull(),
	updatedAt: sqliteInteger('updated_at', { mode: 'timestamp' }),
	updatedBy: sqliteText('updated_by', { length: 24 })
});

// Posts-Tags junction table for many-to-many relationship
export const postsTags = pgTable('posts_tags', {
	id: varchar('id', { length: 24 }).primaryKey(),
	postId: varchar('post_id', { length: 24 }).notNull(),
	tagId: varchar('tag_id', { length: 24 }).notNull(),
	sortOrder: varchar('sort_order', { length: 50 }).notNull().default('0')
});

export const postsTagsSqlite = sqliteTable('posts_tags', {
	id: sqliteText('id', { length: 24 }).primaryKey(),
	postId: sqliteText('post_id', { length: 24 }).notNull(),
	tagId: sqliteText('tag_id', { length: 24 }).notNull(),
	sortOrder: sqliteText('sort_order', { length: 50 }).notNull().default('0')
});

// Type definitions
export type Tag = typeof tags.$inferSelect;
export type NewTag = typeof tags.$inferInsert;
export type PostTag = typeof postsTags.$inferSelect;
export type NewPostTag = typeof postsTags.$inferInsert;

// Zod schemas for validation
export const insertTagSchema = createInsertSchema(tags);
export const selectTagSchema = createSelectSchema(tags);
export const insertPostTagSchema = createInsertSchema(postsTags);
export const selectPostTagSchema = createSelectSchema(postsTags);

// Domain value objects
export const TagSlugSchema = z.string().min(1, 'Slug cannot be empty').max(191, 'Slug too long');
export const TagNameSchema = z.string().min(1, 'Name cannot be empty').max(191, 'Name too long');

export type TagSlug = z.infer<typeof TagSlugSchema>;
export type TagName = z.infer<typeof TagNameSchema>;