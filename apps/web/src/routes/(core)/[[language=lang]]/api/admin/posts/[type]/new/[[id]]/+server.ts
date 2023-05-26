import { page } from '$app/stores';
import { DATABASE_TYPE } from '$env/static/private';
import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { typeMapping, valueMapping } from '$lib/core/core/server/helpers/database/dbHelper';
import {
	ENUM_DATABASE_TABLE,
	ENUM_DATABASE_TYPE,
	ENUM_POSTS_STATUS,
	ENUM_POST_TYPE
} from '$lib/core/shared/enum.js';
import { language } from '$lib/core/shared/stores/site';
import type {
	RreferenceStructure as ReferenceStructure,
	TableStructure
} from '$lib/core/shared/types';
import type { RequestHandler } from './$types';
import ObjectID from 'bson-objectid';
import { get } from 'svelte/store';
import { v4 as uuidv4 } from 'uuid';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url, params, locals }) {
	// console.log(locals.getSession());
	const session = await locals.getSession();
	// console.log(session);

	let returnRows: any;
	await getAllRows(params, session)
		.then((rows) => {
			// console.log(rows);
			returnRows = rows;
		})
		.catch((error) => {
			console.error(error);
			returnRows = error;
		});
	// console.log(returnRows);

	return new Response(JSON.stringify(returnRows), { status: 200 });
}

async function getAllRows(params: any, session: any): Promise<any[] | null> {
	const table = ENUM_DATABASE_TABLE.posts;
	let records: any;
	try {
		//const valueRows: any[] = await knexInstance.select('t.*').from('tags as t').where(params).first();

		// console.log(params);
		if (params.id) {
			records = await knexInstance.select('t.*').from(`${table} as t`).where(params);
		} else {
			let id = new ObjectID().toHexString();

			records = await knexInstance(table)
				.insert({
					id: id,
					uuid: uuidv4(),
					title: 'Your new post is here...',
					slug: 'draft-slug-' + id,
					type: params.type,
					email_recipient_filter: 'all',
					locale: get(language),
					created_at: new Date().toISOString().slice(0, 16),
					created_by: session.user.id,
					updated_at: new Date().toISOString().slice(0, 16),
					updated_by: session.user.id,
					comment_id: new ObjectID().toHexString()
				})
				.returning('*');
		}
		// console.log(records);

		let foreignKeyMap: any[];

		if (DATABASE_TYPE === ENUM_DATABASE_TYPE.sqlite) {
			// console.log('development');

			await knexInstance.raw(`PRAGMA foreign_key_list(${table});`).then(function (info) {
				// console.log(info);
				foreignKeyMap = info.reduce((result, obj) => {
					result[obj.from] = obj;
					return result;
				}, {});
			});
		} else {
			// console.log('production');

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
                        WHERE confrelid = '${table}'::regclass;`
				)
				.then(function (info) {
					// console.log(info);

					foreignKeyMap = info.rows.reduce((result, obj) => {
						result[obj.column_indexes[0]] = obj;
						return result;
					}, {});
					// console.log(foreignKeyMap);
				});
		}

		let row: any;
		await knexInstance(table)
			.columnInfo()
			.then(function (info) {
				// console.log(info);
				const tableStructure: TableStructure = Object.keys(info).map((key) => ({
					key,
					value: valueMapping(info[key].type, records[0][key]), //valueRows[key],
					type: typeMapping(info[key].type),
					maxLength: info[key].maxLength,
					nullable: info[key].nullable,
					defaultValue: info[key].defaultValue
						?.toString()
						.replace('::character varying', '')
						.replace("'", ''),
					reference: foreignKeyMap[key]
				}));
				// console.log(tableStructure);

				row = tableStructure;
			});
		return row;
	} catch (error) {
		console.error(error);
		return null;
	}
}
