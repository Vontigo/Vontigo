import { defineConfig } from 'drizzle-kit';
import { DATABASE_TYPE, POSTGRES_HOST, POSTGRES_DATABASE, POSTGRES_PASSWORD, POSTGRES_USER } from '$env/static/private';

const isDev = DATABASE_TYPE === 'development' || DATABASE_TYPE === 'sqlite';

export default defineConfig({
	schema: './src/infrastructure/db/schema/*.ts',
	out: './src/infrastructure/db/migrations',
	dialect: isDev ? 'sqlite' : 'postgresql',
	dbCredentials: isDev
		? {
				url: './database/vontigo.db'
		  }
		: {
				host: POSTGRES_HOST || 'localhost',
				user: POSTGRES_USER || 'postgres',
				password: POSTGRES_PASSWORD || '',
				database: POSTGRES_DATABASE || 'vontigo',
				ssl: false
		  },
	verbose: true,
	strict: true
});