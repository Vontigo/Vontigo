// export function up(options: string) {
// 	const connection = options.connection;

// 	const existingTables = await commands.getTables(connection);
// 	const missingTables = schemaTables.filter((t) => !existingTables.includes(t));

// 	await Promise.mapSeries(missingTables, async (table) => {
// 		logging.info('Creating table: ' + table);
// 		await commands.createTable(table, connection);
// 	});
// }
