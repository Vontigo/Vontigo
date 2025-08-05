import { pgTable, varchar, text, boolean, timestamp, pgEnum, unique } from 'drizzle-orm/pg-core';
import { sqliteTable, text as sqliteText, integer as sqliteInteger } from 'drizzle-orm/sqlite-core';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { relations } from 'drizzle-orm';
import { users } from './user';
import { z } from 'zod';

// Post enums
export const postTypeEnum = pgEnum('post_type', ['post', 'page']);
export const postStatusEnum = pgEnum('post_status', ['published', 'draft', 'scheduled', 'sent']);
export const postVisibilityEnum = pgEnum('post_visibility', ['public', 'members', 'paid', 'tiers']);

// PostgreSQL table
export const posts = pgTable(
	'posts',
	{
		id: varchar('id', { length: 24 }).primaryKey(),
		uuid: varchar('uuid', { length: 36 }).notNull().unique(),
		title: varchar('title', { length: 255 }).notNull(),
		slug: varchar('slug', { length: 191 }).notNull(),
		mobiledoc: text('mobiledoc'),
		lexical: text('lexical'),
		markdown: text('markdown'),
		html: text('html'),
		commentId: varchar('comment_id', { length: 50 }),
		plaintext: text('plaintext'),
		featureImage: varchar('feature_image', { length: 2000 }),
		featured: boolean('featured').notNull().default(false),
		type: postTypeEnum('type').notNull().default('post'),
		status: postStatusEnum('status').notNull().default('draft'),
		locale: varchar('locale', { length: 6 }),
		visibility: postVisibilityEnum('visibility').notNull().default('public'),
		emailRecipientFilter: text('email_recipient_filter').notNull().default(''),
		createdAt: timestamp('created_at').notNull().defaultNow(),
		createdBy: varchar('created_by', { length: 24 }).notNull(),
		updatedAt: timestamp('updated_at'),
		updatedBy: varchar('updated_by', { length: 24 }),
		publishedAt: timestamp('published_at'),
		publishedBy: varchar('published_by', { length: 24 }),
		customExcerpt: varchar('custom_excerpt', { length: 300 }),
		codeinjectionHead: text('codeinjection_head'),
		codeinjectionFoot: text('codeinjection_foot'),
		customTemplate: varchar('custom_template', { length: 100 }),
		canonicalUrl: text('canonical_url'),
		newsletterId: varchar('newsletter_id', { length: 24 })
	},
	(table) => {
		return {
			slugTypeUnique: unique().on(table.slug, table.type)
		};
	}
);

// SQLite table (for development)
export const postsSqlite = sqliteTable('posts', {
	id: sqliteText('id', { length: 24 }).primaryKey(),
	uuid: sqliteText('uuid', { length: 36 }).notNull().unique(),
	title: sqliteText('title', { length: 255 }).notNull(),
	slug: sqliteText('slug', { length: 191 }).notNull(),
	mobiledoc: sqliteText('mobiledoc'),
	lexical: sqliteText('lexical'),
	markdown: sqliteText('markdown'),
	html: sqliteText('html'),
	commentId: sqliteText('comment_id', { length: 50 }),
	plaintext: sqliteText('plaintext'),
	featureImage: sqliteText('feature_image', { length: 2000 }),
	featured: sqliteInteger('featured', { mode: 'boolean' }).notNull().default(false),
	type: sqliteText('type').notNull().default('post'),
	status: sqliteText('status').notNull().default('draft'),
	locale: sqliteText('locale', { length: 6 }),
	visibility: sqliteText('visibility').notNull().default('public'),
	emailRecipientFilter: sqliteText('email_recipient_filter').notNull().default(''),
	createdAt: sqliteInteger('created_at', { mode: 'timestamp' }).notNull(),
	createdBy: sqliteText('created_by', { length: 24 }).notNull(),
	updatedAt: sqliteInteger('updated_at', { mode: 'timestamp' }),
	updatedBy: sqliteText('updated_by', { length: 24 }),
	publishedAt: sqliteInteger('published_at', { mode: 'timestamp' }),
	publishedBy: sqliteText('published_by', { length: 24 }),
	customExcerpt: sqliteText('custom_excerpt', { length: 300 }),
	codeinjectionHead: sqliteText('codeinjection_head'),
	codeinjectionFoot: sqliteText('codeinjection_foot'),
	customTemplate: sqliteText('custom_template', { length: 100 }),
	canonicalUrl: sqliteText('canonical_url'),
	newsletterId: sqliteText('newsletter_id', { length: 24 })
});

// Post meta table
export const postsMeta = pgTable('posts_meta', {
	id: varchar('id', { length: 24 }).primaryKey(),
	postId: varchar('post_id', { length: 24 }).notNull().unique(),
	ogImage: varchar('og_image', { length: 2000 }),
	ogTitle: varchar('og_title', { length: 300 }),
	ogDescription: varchar('og_description', { length: 500 }),
	twitterImage: varchar('twitter_image', { length: 2000 }),
	twitterTitle: varchar('twitter_title', { length: 300 }),
	twitterDescription: varchar('twitter_description', { length: 500 }),
	metaTitle: varchar('meta_title', { length: 300 }),
	metaDescription: varchar('meta_description', { length: 500 }),
	emailSubject: varchar('email_subject', { length: 300 }),
	frontmatter: text('frontmatter'),
	featureImageAlt: varchar('feature_image_alt', { length: 125 }),
	featureImageCaption: text('feature_image_caption'),
	emailOnly: boolean('email_only').notNull().default(false)
});

// Posts Authors junction table
export const postsAuthors = pgTable('posts_authors', {
	id: varchar('id', { length: 24 }).primaryKey(),
	postId: varchar('post_id', { length: 24 }).notNull(),
	authorId: varchar('author_id', { length: 24 }).notNull(),
	sortOrder: sqliteInteger('sort_order').notNull().default(0)
});

// Relations
export const postsRelations = relations(posts, ({ one, many }) => ({
	meta: one(postsMeta, {
		fields: [posts.id],
		references: [postsMeta.postId]
	}),
	authors: many(postsAuthors),
	createdByUser: one(users, {
		fields: [posts.createdBy],
		references: [users.id]
	}),
	updatedByUser: one(users, {
		fields: [posts.updatedBy],
		references: [users.id]
	}),
	publishedByUser: one(users, {
		fields: [posts.publishedBy],
		references: [users.id]
	})
}));

export const postsAuthorsRelations = relations(postsAuthors, ({ one }) => ({
	post: one(posts, {
		fields: [postsAuthors.postId],
		references: [posts.id]
	}),
	author: one(users, {
		fields: [postsAuthors.authorId],
		references: [users.id]
	})
}));

// Type definitions
export type Post = typeof posts.$inferSelect;
export type NewPost = typeof posts.$inferInsert;
export type PostMeta = typeof postsMeta.$inferSelect;
export type NewPostMeta = typeof postsMeta.$inferInsert;
export type PostAuthor = typeof postsAuthors.$inferSelect;

// Zod schemas for validation
export const insertPostSchema = createInsertSchema(posts);
export const selectPostSchema = createSelectSchema(posts);
export const insertPostMetaSchema = createInsertSchema(postsMeta);
export const selectPostMetaSchema = createSelectSchema(postsMeta);

// Domain value objects
export const PostSlugSchema = z.string().min(1).max(191);
export const PostTitleSchema = z.string().min(1).max(255);
export const PostContentSchema = z.string().optional();

export type PostSlug = z.infer<typeof PostSlugSchema>;
export type PostTitle = z.infer<typeof PostTitleSchema>;
export type PostContent = z.infer<typeof PostContentSchema>;