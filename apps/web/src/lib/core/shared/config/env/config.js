module.exports = {
	development: {
		client: 'sqlite3',
		connection: {
			filename: './database/vontigo.db'
		},
		useNullAsDefault: true
	},
	production: {
		client: 'mysql',
		connection: {
			host: '179.61.199.11',
			user: 'vontigo',
			password: 'VontigoP@ssw0rd',
			database: 'vontigo',
			charset: 'utf8'
		}
	}
};
