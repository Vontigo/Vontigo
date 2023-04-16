// export function createTable(table: any, transaction = db.knex, tableSpec = schema[table]) {
// 	return transaction.schema.createTable(table, function (t) {
// 		Object.keys(tableSpec)
// 			.filter((column) => !column.startsWith('@@'))
// 			.forEach((column) => addTableColumn(table, t, column, tableSpec[column]));

// 		if (tableSpec['@@INDEXES@@']) {
// 			tableSpec['@@INDEXES@@'].forEach((index) => t.index(index));
// 		}
// 		if (tableSpec['@@UNIQUE_CONSTRAINTS@@']) {
// 			tableSpec['@@UNIQUE_CONSTRAINTS@@'].forEach((unique) => t.unique(unique));
// 		}
// 	});
// }
