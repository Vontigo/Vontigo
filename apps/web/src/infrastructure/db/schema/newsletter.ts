import { pgTable, varchar, text, boolean, timestamp, pgEnum } from 'drizzle-orm/pg-core';
import { sqliteTable, text as sqliteText, integer as sqliteInteger } from 'drizzle-orm/sqlite-core';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';

// Newsletter enums
export const newsletterStatusEnum = pgEnum('newsletter_status', ['active', 'archived']);
export const newsletterVisibilityEnum = pgEnum('newsletter_visibility', ['members']);
export const newsletterFontCategoryEnum = pgEnum('newsletter_font_category', ['serif', 'sans_serif']);
export const newsletterAlignmentEnum = pgEnum('newsletter_alignment', ['center', 'left']);
export const newsletterBackgroundColorEnum = pgEnum('newsletter_background_color', ['light']);

// PostgreSQL table
export const newsletters = pgTable('newsletters', {
	id: varchar('id', { length: 24 }).primaryKey(),
	uuid: varchar('uuid', { length: 36 }).notNull().unique(),
	name: varchar('name', { length: 191 }).notNull().unique(),
	description: varchar('description', { length: 2000 }),
	feedbackEnabled: boolean('feedback_enabled').notNull().default(false),
	slug: varchar('slug', { length: 191 }).notNull().unique(),
	senderName: varchar('sender_name', { length: 191 }),
	senderEmail: varchar('sender_email', { length: 191 }),
	senderReplyTo: varchar('sender_reply_to', { length: 191 }).notNull().default('newsletter'),
	status: newsletterStatusEnum('status').notNull().default('active'),
	visibility: newsletterVisibilityEnum('visibility').notNull().default('members'),
	subscribeOnSignup: boolean('subscribe_on_signup').notNull().default(true),
	sortOrder: sqliteInteger('sort_order').notNull().default(0),
	headerImage: varchar('header_image', { length: 2000 }),
	showHeaderIcon: boolean('show_header_icon').notNull().default(true),
	showHeaderTitle: boolean('show_header_title').notNull().default(true),
	titleFontCategory: newsletterFontCategoryEnum('title_font_category').notNull().default('sans_serif'),
	titleAlignment: newsletterAlignmentEnum('title_alignment').notNull().default('center'),
	showFeatureImage: boolean('show_feature_image').notNull().default(true),
	bodyFontCategory: newsletterFontCategoryEnum('body_font_category').notNull().default('sans_serif'),
	footerContent: text('footer_content'),
	showBadge: boolean('show_badge').notNull().default(true),
	showHeaderName: boolean('show_header_name').notNull().default(true),
	showPostTitleSection: boolean('show_post_title_section').notNull().default(true),
	showCommentCta: boolean('show_comment_cta').notNull().default(true),
	showSubscriptionDetails: boolean('show_subscription_details').notNull().default(false),
	showLatestPosts: boolean('show_latest_posts').notNull().default(false),
	backgroundColor: newsletterBackgroundColorEnum('background_color').notNull().default('light'),
	borderColor: varchar('border_color', { length: 50 }),
	titleColor: varchar('title_color', { length: 50 }),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	updatedAt: timestamp('updated_at')
});

// Type definitions
export type Newsletter = typeof newsletters.$inferSelect;
export type NewNewsletter = typeof newsletters.$inferInsert;

// Zod schemas for validation
export const insertNewsletterSchema = createInsertSchema(newsletters);
export const selectNewsletterSchema = createSelectSchema(newsletters);