// import Database from 'better-sqlite3';

// const options = { verbose: console.log };
// export const db = new Database('./src/lib/database/vontigo.db', options);
// db.pragma('journal_mode = WAL');

// import { config } from '../../../../shared/config/env/config.json';
import knex, { Knex } from 'knex';

export const knexInstance: Knex = knex({
	client: 'sqlite3',
	connection: {
		filename: './database/vontigo.db'
	},
	useNullAsDefault: true
});

// let knex_conn: Knex;
// export async function connect(connection: Record<string, string>) {
// 	let conn = {
// 		client: 'sqlite3',
// 		connection: {
// 			filename: './src/lib/database/vontigo.db'
// 		}
// 	};
// 	knex_conn = knex(conn);
// 	return knex_conn;
// }

// interface KnexConfig {
// 	[key: string]: object;
// }

// export const knexConfig: KnexConfig = {
// 	local: {
// 		client: 'sqlite3',
// 		connection: {
// 			filename: './src/lib/database/vontigo.db'
// 		}
// 	},

// 	development: {
// 		client: 'mysql',
// 		connection: {
// 			host: 'sg1-wss4.my-hosting-panel.com:3306',
// 			user: 'vontigo',
// 			password: 'vontigoP@ssw0rd',
// 			database: 'vontigo'
// 		}
// 	},

// 	production: {
// 		client: 'mysql',
// 		connection: {
// 			host: 'sg1-wss4.my-hosting-panel.com:3306',
// 			user: 'vontigo',
// 			password: 'vontigoP@ssw0rd',
// 			database: 'vontigo'
// 		}
// 	}
// };
