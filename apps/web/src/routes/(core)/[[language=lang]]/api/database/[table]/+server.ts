import { DATABASE_TYPE } from '$env/static/private';
import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { typeMapping } from '$lib/core/core/server/helpers/database/dbHelper.js';
import { ENUM_DATABASE_TYPE } from '$lib/core/shared/enum.js';
import type { TableStructure } from '$lib/core/shared/types.js';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url, params }) {
	let foreignKeyMap: any[];
	console.log(await knexInstance.raw(`PRAGMA foreign_key_list(${params.table});`));

	if (DATABASE_TYPE === ENUM_DATABASE_TYPE.sqlite) {
		await knexInstance.raw(`PRAGMA foreign_key_list(${params.table});`).then(function (info) {
			// foreignKeyMap = info.map(mapForeignKey);
			// console.log(foreignKeyMap.find(key => key.from === 'created_by'));
			foreignKeyMap = info.reduce((result: any, obj: any) => {
				result[obj.from] = obj;
				return result;
			}, {});
			// console.log(foreignKeyMap['created_by']);
		});
	} else {
		await knexInstance
			.raw(
				`SELECT conname AS "constraint_name",
                       conrelid::regclass AS "table_name",
                       conkey AS "column_indexes",
                       confrelid::regclass AS "referenced_table_name",
                       confkey AS "referenced_column_indexes",
                       confdeltype AS "on_delete",
                       confupdtype AS "on_update"
                FROM pg_constraint
                WHERE confrelid = '${params.table}'::regclass;`
			)
			.then(function (info) {
				console.log(info);

				foreignKeyMap = info.rows.reduce((result, obj) => {
					result[obj.column_indexes[0]] = obj;
					return result;
				}, {});
				// console.log(foreignKeyMap);
			});
	}

	let row: any;
	await knexInstance(params.table)
		.columnInfo()
		.then(function (info) {
			// console.log(info);
			const tblStructure: TableStructure = Object.keys(info).map((key: any) => ({
				key,
				value: '', //valueRows[key],
				type: typeMapping(info[key].type),
				maxLength: info[key].maxLength,
				nullable: info[key].nullable,
				defaultValue: info[key].defaultValue,
				reference: foreignKeyMap[key]
			}));
			// console.log(tagStructure);

			row = tblStructure;
		});
	return new Response(JSON.stringify(row), { status: 200 });
}
