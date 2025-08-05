import { drizzle } from 'drizzle-orm/postgres-js';
import { drizzle as drizzleSqlite } from 'drizzle-orm/better-sqlite3';
import postgres from 'postgres';
import Database from 'better-sqlite3';
import { DATABASE_TYPE } from '$env/static/private';
import { globalConfig } from '$lib/core/shared/config/env/config';

// Import all schemas
import * as userSchema from './schema/user';
import * as settingsSchema from './schema/settings';
import * as tagSchema from './schema/tag';
import * as postSchema from './schema/post';
import * as newsletterSchema from './schema/newsletter';
import * as membershipSchema from './schema/membership';
import * as authSchema from './schema/auth';

// Combine all schemas
const schema = {
	...userSchema,
	...settingsSchema,
	...tagSchema,
	...postSchema,
	...newsletterSchema,
	...membershipSchema,
	...authSchema
};

// Database connection
let db: ReturnType<typeof drizzle> | ReturnType<typeof drizzleSqlite>;

if (DATABASE_TYPE === 'development' || DATABASE_TYPE === 'sqlite') {
	// SQLite connection
	const sqlite = new Database(globalConfig.database.sqlite.connection.filename);
	db = drizzleSqlite(sqlite, { schema });
} else {
	// PostgreSQL connection
	const connection = postgres(globalConfig.database.postgres.connection);
	db = drizzle(connection, { schema });
}

export { db };
export type DrizzleDB = typeof db;