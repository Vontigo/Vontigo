import {
	POSTGRES_HOST,
	POSTGRES_DATABASE,
	POSTGRES_PASSWORD,
	POSTGRES_USER
} from '$env/static/private';

export const globalConfig = {
	database: {
		sqlite: {
			client: 'sqlite3',
			connection: {
				filename: './database/vontigo.db'
			},
			useNullAsDefault: true
		},
		postgres: {
			client: 'pg',
			connection: {
				host: POSTGRES_HOST,
				user: POSTGRES_USER,
				password: POSTGRES_PASSWORD,
				database: POSTGRES_DATABASE,
				ssl: true,
				sslmode: 'verify-full'
			}
			// "client": "mysql",
			// "connection": {
			// 	"host": "179.61.199.11",
			// 	"user": "vontigo",
			// 	"password": "VontigoP@ssw0rd",
			// 	"database": "vontigo",
			// 	"charset": "utf8"
			// }
		}
	},
	paths: {
		contentPath: 'content/'
	},
	logging: {
		level: 'info',
		rotation: {
			enabled: true
		},
		transports: ['file', 'stdout']
	}
};
