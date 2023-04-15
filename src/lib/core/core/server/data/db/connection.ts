// import Database from 'better-sqlite3';

// const options = { verbose: console.log };
// export const db = new Database('./src/lib/database/vontigo.db', options);
// db.pragma('journal_mode = WAL');

import { config } from '../../../../shared/config/env/config.json';
import { Knex } from 'knex';

interface KnexConfig {
	[key: string]: object;
}

const knexConfig: KnexConfig = {
	local: {
		client: 'sqlite3',
		connection: {
			filename: './src/lib/database/vontigo.db'
		}
	},

	development: {
		client: 'mysql',
		connection: {
			host: 'sg1-wss4.my-hosting-panel.com:3306',
			user: 'vontigo',
			password: 'vontigoP@ssw0rd',
			database: 'vontigo'
		}
	},

	production: {
		client: 'mysql',
		connection: {
			host: 'sg1-wss4.my-hosting-panel.com:3306',
			user: 'vontigo',
			password: 'vontigoP@ssw0rd',
			database: 'vontigo'
		}
	}
};
