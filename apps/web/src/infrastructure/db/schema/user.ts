import { pgTable, varchar, text, boolean, timestamp, pgEnum } from 'drizzle-orm/pg-core';
import { sqliteTable, text as sqliteText, integer as sqliteInteger } from 'drizzle-orm/sqlite-core';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { z } from 'zod';

// User status enum
export const userStatusEnum = pgEnum('user_status', [
	'active',
	'inactive',
	'locked',
	'warn-1',
	'warn-2',
	'warn-3',
	'warn-4'
]);

export const userVisibilityEnum = pgEnum('user_visibility', ['public']);

// PostgreSQL table
export const users = pgTable('users', {
	id: varchar('id', { length: 24 }).primaryKey(),
	name: varchar('name', { length: 191 }).notNull(),
	slug: varchar('slug', { length: 191 }).notNull().unique(),
	password: varchar('password', { length: 60 }).notNull(),
	email: varchar('email', { length: 191 }).notNull().unique(),
	profileImage: varchar('profile_image', { length: 2000 }),
	coverImage: varchar('cover_image', { length: 2000 }),
	bio: text('bio'),
	website: varchar('website', { length: 2000 }),
	location: text('location'),
	facebook: varchar('facebook', { length: 2000 }),
	twitter: varchar('twitter', { length: 2000 }),
	accessibility: text('accessibility'),
	status: userStatusEnum('status').notNull().default('active'),
	locale: varchar('locale', { length: 6 }),
	visibility: userVisibilityEnum('visibility').notNull().default('public'),
	metaTitle: varchar('meta_title', { length: 2000 }),
	metaDescription: varchar('meta_description', { length: 2000 }),
	tour: text('tour'),
	lastSeen: timestamp('last_seen'),
	commentNotifications: boolean('comment_notifications').notNull().default(true),
	freeMemberSignupNotification: boolean('free_member_signup_notification').notNull().default(true),
	paidSubscriptionStartedNotification: boolean('paid_subscription_started_notification')
		.notNull()
		.default(true),
	paidSubscriptionCanceledNotification: boolean('paid_subscription_canceled_notification')
		.notNull()
		.default(false),
	mentionNotifications: boolean('mention_notifications').notNull().default(true),
	milestoneNotifications: boolean('milestone_notifications').notNull().default(true),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	createdBy: varchar('created_by', { length: 24 }).notNull(),
	updatedAt: timestamp('updated_at'),
	updatedBy: varchar('updated_by', { length: 24 })
});

// SQLite table (for development)
export const usersSqlite = sqliteTable('users', {
	id: sqliteText('id', { length: 24 }).primaryKey(),
	name: sqliteText('name', { length: 191 }).notNull(),
	slug: sqliteText('slug', { length: 191 }).notNull().unique(),
	password: sqliteText('password', { length: 60 }).notNull(),
	email: sqliteText('email', { length: 191 }).notNull().unique(),
	profileImage: sqliteText('profile_image', { length: 2000 }),
	coverImage: sqliteText('cover_image', { length: 2000 }),
	bio: sqliteText('bio'),
	website: sqliteText('website', { length: 2000 }),
	location: sqliteText('location'),
	facebook: sqliteText('facebook', { length: 2000 }),
	twitter: sqliteText('twitter', { length: 2000 }),
	accessibility: sqliteText('accessibility'),
	status: sqliteText('status').notNull().default('active'),
	locale: sqliteText('locale', { length: 6 }),
	visibility: sqliteText('visibility').notNull().default('public'),
	metaTitle: sqliteText('meta_title', { length: 2000 }),
	metaDescription: sqliteText('meta_description', { length: 2000 }),
	tour: sqliteText('tour'),
	lastSeen: sqliteInteger('last_seen', { mode: 'timestamp' }),
	commentNotifications: sqliteInteger('comment_notifications', { mode: 'boolean' })
		.notNull()
		.default(true),
	freeMemberSignupNotification: sqliteInteger('free_member_signup_notification', {
		mode: 'boolean'
	})
		.notNull()
		.default(true),
	paidSubscriptionStartedNotification: sqliteInteger('paid_subscription_started_notification', {
		mode: 'boolean'
	})
		.notNull()
		.default(true),
	paidSubscriptionCanceledNotification: sqliteInteger('paid_subscription_canceled_notification', {
		mode: 'boolean'
	})
		.notNull()
		.default(false),
	mentionNotifications: sqliteInteger('mention_notifications', { mode: 'boolean' })
		.notNull()
		.default(true),
	milestoneNotifications: sqliteInteger('milestone_notifications', { mode: 'boolean' })
		.notNull()
		.default(true),
	createdAt: sqliteInteger('created_at', { mode: 'timestamp' }).notNull(),
	createdBy: sqliteText('created_by', { length: 24 }).notNull(),
	updatedAt: sqliteInteger('updated_at', { mode: 'timestamp' }),
	updatedBy: sqliteText('updated_by', { length: 24 })
});

// Type definitions
export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;

// Zod schemas for validation
export const insertUserSchema = createInsertSchema(users);
export const selectUserSchema = createSelectSchema(users);

// Domain value objects
export const EmailSchema = z.string().email().max(191);
export const UserSlugSchema = z.string().min(1).max(191);
export const UserNameSchema = z.string().min(1).max(191);

export type Email = z.infer<typeof EmailSchema>;
export type UserSlug = z.infer<typeof UserSlugSchema>;
export type UserName = z.infer<typeof UserNameSchema>;