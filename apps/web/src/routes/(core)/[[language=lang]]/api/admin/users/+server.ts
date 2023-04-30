import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { ENUM_DATABASE_TABLE, ENUM_POSTS_STATUS } from '$lib/core/shared/enum.js';
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

async function getAllRows(params: any): Promise<any[] | null> {
	try {
		const rows: any[] = await knexInstance
			.select('u.*', 'r.name as role_name')
			.from('roles_users as ru')
			.leftJoin('roles as r', 'r.id', 'ru.role_id')
			.leftJoin('users as u', 'u.id', 'ru.user_id')
			.where({ status: 'active' });
		return rows;
	} catch (error) {
		console.error(error);
		return null;
	}
}
