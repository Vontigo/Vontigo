import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { ENUM_DATABASE_TABLE, ENUM_POSTS_STATUS } from '$lib/core/shared/enum.js';
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
			.select('m.*')
			.from('members as m')
			.where(params)
			.first();

		let foreignKeyMap: any[];
		// console.log(await knexInstance.raw('PRAGMA table_info(users);'));
		await knexInstance.raw('PRAGMA foreign_key_list(members);').then(function (info) {
			// foreignKeyMap = info.map(mapForeignKey);
			// console.log(foreignKeyMap.find(key => key.from === 'created_by'));
			foreignKeyMap = info.reduce((result, obj) => {
				result[obj.from] = obj;
				return result;
			}, {});
			// console.log(foreignKeyMap['created_by']);
		});

		let row: any;
		await knexInstance('members')
			.columnInfo()
			.then(function (info) {
				// console.log(info);
				const memberstructure: TableStructure = Object.keys(info).map((key) => ({
					key,
					value: valueRows[key],
					type: info[key].type,
					maxLength: info[key].maxLength,
					nullable: info[key].nullable,
					defaultValue: info[key].defaultValue,
					reference: foreignKeyMap[key]
				}));
				// console.log(memberstructure);

				row = memberstructure;
			});
		return row;
	} catch (error) {
		console.error(error);
		return null;
	}
}
