import { pgTable, varchar, text, boolean, timestamp, pgEnum, integer } from 'drizzle-orm/pg-core';
import { sqliteTable, text as sqliteText, integer as sqliteInteger } from 'drizzle-orm/sqlite-core';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { z } from 'zod';

// Member enums
export const memberStatusEnum = pgEnum('member_status', ['free', 'paid', 'comped']);

// PostgreSQL table
export const members = pgTable('members', {
	id: varchar('id', { length: 24 }).primaryKey(),
	uuid: varchar('uuid', { length: 36 }).unique(),
	email: varchar('email', { length: 191 }).notNull().unique(),
	status: memberStatusEnum('status').notNull().default('free'),
	name: varchar('name', { length: 191 }),
	expertise: varchar('expertise', { length: 191 }),
	note: varchar('note', { length: 2000 }),
	geolocation: varchar('geolocation', { length: 2000 }),
	enableCommentNotifications: boolean('enable_comment_notifications').notNull().default(true),
	emailCount: integer('email_count').notNull().default(0),
	emailOpenedCount: integer('email_opened_count').notNull().default(0),
	emailOpenRate: integer('email_open_rate'),
	lastSeenAt: timestamp('last_seen_at'),
	lastCommentedAt: timestamp('last_commented_at'),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	createdBy: varchar('created_by', { length: 24 }).notNull(),
	updatedAt: timestamp('updated_at'),
	updatedBy: varchar('updated_by', { length: 24 })
});

// SQLite table (for development)
export const membersSqlite = sqliteTable('members', {
	id: sqliteText('id', { length: 24 }).primaryKey(),
	uuid: sqliteText('uuid', { length: 36 }).unique(),
	email: sqliteText('email', { length: 191 }).notNull().unique(),
	status: sqliteText('status').notNull().default('free'),
	name: sqliteText('name', { length: 191 }),
	expertise: sqliteText('expertise', { length: 191 }),
	note: sqliteText('note', { length: 2000 }),
	geolocation: sqliteText('geolocation', { length: 2000 }),
	enableCommentNotifications: sqliteInteger('enable_comment_notifications', { mode: 'boolean' }).notNull().default(true),
	emailCount: sqliteInteger('email_count').notNull().default(0),
	emailOpenedCount: sqliteInteger('email_opened_count').notNull().default(0),
	emailOpenRate: sqliteInteger('email_open_rate'),
	lastSeenAt: sqliteInteger('last_seen_at', { mode: 'timestamp' }),
	lastCommentedAt: sqliteInteger('last_commented_at', { mode: 'timestamp' }),
	createdAt: sqliteInteger('created_at', { mode: 'timestamp' }).notNull(),
	createdBy: sqliteText('created_by', { length: 24 }).notNull(),
	updatedAt: sqliteInteger('updated_at', { mode: 'timestamp' }),
	updatedBy: sqliteText('updated_by', { length: 24 })
});

// Type definitions
export type Member = typeof members.$inferSelect;
export type NewMember = typeof members.$inferInsert;

// Zod schemas for validation
export const insertMemberSchema = createInsertSchema(members);
export const selectMemberSchema = createSelectSchema(members);

// Domain value objects
export const MemberEmailSchema = z.string().email().max(191);
export const MemberNameSchema = z.string().min(1, 'Name cannot be empty').max(191, 'Name too long');

export type MemberEmail = z.infer<typeof MemberEmailSchema>;
export type MemberName = z.infer<typeof MemberNameSchema>;