import { DATABASE_TYPE } from '$env/static/private';
import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { typeMapping, valueMapping } from '$lib/core/core/server/helpers/database/dbHelper';
import {
	ENUM_DATABASE_TABLE,
	ENUM_DATABASE_TYPE,
	ENUM_POSTS_STATUS
} from '$lib/core/shared/enum.js';
import type {
	RreferenceStructure as ReferenceStructure,
	TableStructure
} from '$lib/core/shared/types';
import type { RequestHandler } from './$types';
import ObjectID from 'bson-objectid';
import { v4 as uuidv4 } from 'uuid';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url, params }) {
	let returnRows: any;
	await getAllRows(params)
		.then((rows) => {
			// console.log(rows);
			returnRows = rows;
		})
		.catch((error) => {
			console.error(error);
			returnRows = error;
		});
	return new Response(JSON.stringify(returnRows), { status: 200 });
}

function mapForeignKey(json: ForeignKey): Record<string, ForeignKey> {
	const { from, ...rest } = json;
	return { [from]: { ...rest, from } };
}

async function getAllRows(params: any): Promise<any[] | null> {
	try {
		const valueRows: any[] = await knexInstance
			.select('t.*')
			.from('users as t')
			.where(params)
			.first();

		let foreignKeyMap: any[];
		// console.log(await knexInstance.raw('PRAGMA table_info(users);'));
		if (DATABASE_TYPE === ENUM_DATABASE_TYPE.sqlite) {
			await knexInstance.raw('PRAGMA foreign_key_list(users);').then(function (info) {
				// foreignKeyMap = info.map(mapForeignKey);
				// console.log(foreignKeyMap.find(key => key.from === 'created_by'));
				foreignKeyMap = info.reduce((result, obj) => {
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
				WHERE confrelid = 'users'::regclass;`
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
		await knexInstance('users')
			.columnInfo()
			.then(function (info) {
				// console.log(info);
				const userStructure: TableStructure = Object.keys(info).map((key) => ({
					key,
					value: valueMapping(info[key].type, valueRows[key]), //valueRows[key],
					type: typeMapping(info[key].type),
					maxLength: info[key].maxLength,
					nullable: info[key].nullable,
					defaultValue: info[key].defaultValue,
					reference: foreignKeyMap[key]
				}));
				// console.log(userstructure);

				row = userStructure;
			});
		return row;
	} catch (error) {
		console.error(error);
		return null;
	}
}
