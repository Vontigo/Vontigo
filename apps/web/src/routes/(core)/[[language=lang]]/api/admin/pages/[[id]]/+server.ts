import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { ENUM_DATABASE_TABLE, ENUM_POSTS_STATUS, ENUM_POST_TYPE } from '$lib/core/shared/enum.js';
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
	// console.log(returnRows);

	return new Response(JSON.stringify(returnRows), { status: 200 });
}

function mapForeignKey(json: ForeignKey): Record<string, ForeignKey> {
	const { from, ...rest } = json;
	return { [from]: { ...rest, from } };
}

async function getAllRows(params: any): Promise<any[] | null> {
	const table = ENUM_DATABASE_TABLE.posts;
	let record: any;
	try {
		//const valueRows: any[] = await knexInstance.select('t.*').from('tags as t').where(params).first();

		console.log(params);
		if (params.id) {
			record = await knexInstance.select('t.*').from(`${table} as t`).where(params).first();
		} else {
			let id = new ObjectID().toHexString();

			record = await knexInstance(table)
				.insert({
					id: id,
					uuid: uuidv4(),
					title: 'Draft title',
					slug: 'draft-slug-' + id,
					type: ENUM_POST_TYPE.page,
					email_recipient_filter: 'all',
					locale: get(language),
					created_at: new Date().toISOString().slice(0, 16),
					created_by: 1,
					updated_at: new Date().toISOString().slice(0, 16),
					updated_by: 1,
					comment_id: new ObjectID().toHexString()
				})
				.returning('*')
				.first();
		}
		console.log(record);

		let foreignKeyMap: any[];
		// console.log(await knexInstance.raw('PRAGMA table_info(users);'));
		await knexInstance.raw(`PRAGMA foreign_key_list(${table});`).then(function (info) {
			// foreignKeyMap = info.map(mapForeignKey);
			// console.log(foreignKeyMap.find(key => key.from === 'created_by'));
			foreignKeyMap = info.reduce((result, obj) => {
				result[obj.from] = obj;
				return result;
			}, {});
			// console.log(foreignKeyMap['created_by']);
		});

		let row: any;
		await knexInstance(table)
			.columnInfo()
			.then(function (info) {
				// console.log(info);
				const tableStructure: TableStructure = Object.keys(info).map((key) => ({
					key,
					value: record[key], //valueRows[key],
					type: info[key].type,
					maxLength: info[key].maxLength,
					nullable: info[key].nullable,
					defaultValue: info[key].defaultValue,
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
