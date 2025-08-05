import { pgTable, varchar, text, timestamp, pgEnum } from 'drizzle-orm/pg-core';
import { sqliteTable, text as sqliteText, integer as sqliteInteger } from 'drizzle-orm/sqlite-core';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { z } from 'zod';

// Settings type enum
export const settingsTypeEnum = pgEnum('settings_type', [
	'blog',
	'theme',
	'private',
	'members',
	'portal',
	'email',
	'amp',
	'labs',
	'slack',
	'unsplash',
	'views',
	'firstpromoter',
	'editor',
	'bulk_email',
	'analytics'
]);

// PostgreSQL table
export const settings = pgTable('settings', {
	id: varchar('id', { length: 24 }).primaryKey(),
	group: varchar('group', { length: 50 }).notNull(),
	key: varchar('key', { length: 50 }).notNull().unique(),
	value: text('value'),
	type: settingsTypeEnum('type').notNull().default('blog'),
	flags: varchar('flags', { length: 50 }),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	createdBy: varchar('created_by', { length: 24 }).notNull(),
	updatedAt: timestamp('updated_at'),
	updatedBy: varchar('updated_by', { length: 24 })
});

// SQLite table (for development)
export const settingsSqlite = sqliteTable('settings', {
	id: sqliteText('id', { length: 24 }).primaryKey(),
	group: sqliteText('group', { length: 50 }).notNull(),
	key: sqliteText('key', { length: 50 }).notNull().unique(),
	value: sqliteText('value'),
	type: sqliteText('type').notNull().default('blog'),
	flags: sqliteText('flags', { length: 50 }),
	createdAt: sqliteInteger('created_at', { mode: 'timestamp' }).notNull(),
	createdBy: sqliteText('created_by', { length: 24 }).notNull(),
	updatedAt: sqliteInteger('updated_at', { mode: 'timestamp' }),
	updatedBy: sqliteText('updated_by', { length: 24 })
});

// Type definitions
export type Settings = typeof settings.$inferSelect;
export type NewSettings = typeof settings.$inferInsert;

// Zod schemas for validation
export const insertSettingsSchema = createInsertSchema(settings);
export const selectSettingsSchema = createSelectSchema(settings);

// Domain value objects
export const SettingsKeySchema = z.string().min(1, 'Key cannot be empty').max(50, 'Key too long');
export const SettingsGroupSchema = z.string().min(1, 'Group cannot be empty').max(50, 'Group too long');

export type SettingsKey = z.infer<typeof SettingsKeySchema>;
export type SettingsGroup = z.infer<typeof SettingsGroupSchema>;