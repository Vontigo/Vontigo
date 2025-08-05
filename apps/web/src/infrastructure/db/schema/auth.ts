import { pgTable, varchar, text, timestamp, integer } from 'drizzle-orm/pg-core';
import { sqliteTable, text as sqliteText, integer as sqliteInteger } from 'drizzle-orm/sqlite-core';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { relations } from 'drizzle-orm';
import { users } from './user';

// Roles table
export const roles = pgTable('roles', {
	id: varchar('id', { length: 24 }).primaryKey(),
	name: varchar('name', { length: 50 }).notNull().unique(),
	description: varchar('description', { length: 2000 }),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	createdBy: varchar('created_by', { length: 24 }).notNull(),
	updatedAt: timestamp('updated_at'),
	updatedBy: varchar('updated_by', { length: 24 })
});

// Permissions table
export const permissions = pgTable('permissions', {
	id: varchar('id', { length: 24 }).primaryKey(),
	name: varchar('name', { length: 50 }).notNull().unique(),
	objectType: varchar('object_type', { length: 50 }).notNull(),
	actionType: varchar('action_type', { length: 50 }).notNull(),
	objectId: varchar('object_id', { length: 24 }),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	createdBy: varchar('created_by', { length: 24 }).notNull(),
	updatedAt: timestamp('updated_at'),
	updatedBy: varchar('updated_by', { length: 24 })
});

// Junction tables
export const rolesUsers = pgTable('roles_users', {
	id: varchar('id', { length: 24 }).primaryKey(),
	roleId: varchar('role_id', { length: 24 }).notNull(),
	userId: varchar('user_id', { length: 24 }).notNull()
});

export const permissionsUsers = pgTable('permissions_users', {
	id: varchar('id', { length: 24 }).primaryKey(),
	userId: varchar('user_id', { length: 24 }).notNull(),
	permissionId: varchar('permission_id', { length: 24 }).notNull()
});

export const permissionsRoles = pgTable('permissions_roles', {
	id: varchar('id', { length: 24 }).primaryKey(),
	roleId: varchar('role_id', { length: 24 }).notNull(),
	permissionId: varchar('permission_id', { length: 24 }).notNull()
});

// Relations
export const rolesRelations = relations(roles, ({ many }) => ({
	users: many(rolesUsers),
	permissions: many(permissionsRoles)
}));

export const usersRolesRelations = relations(rolesUsers, ({ one }) => ({
	role: one(roles, {
		fields: [rolesUsers.roleId],
		references: [roles.id]
	}),
	user: one(users, {
		fields: [rolesUsers.userId],
		references: [users.id]
	})
}));

// Type definitions
export type Role = typeof roles.$inferSelect;
export type NewRole = typeof roles.$inferInsert;
export type Permission = typeof permissions.$inferSelect;
export type NewPermission = typeof permissions.$inferInsert;

// Zod schemas for validation
export const insertRoleSchema = createInsertSchema(roles);
export const selectRoleSchema = createSelectSchema(roles);
export const insertPermissionSchema = createInsertSchema(permissions);
export const selectPermissionSchema = createSelectSchema(permissions);