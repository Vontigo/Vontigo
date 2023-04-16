import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { knex, Knex } from 'knex';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
	let returnRows: any;
	await getAllRows('posts')
		.then((rows) => {
			console.log(rows);
			returnRows = rows;
		})
		.catch((error) => {
			console.error(error);
			returnRows = error;
		});
	return new Response(JSON.stringify(returnRows), { status: 200 });
}

async function getAllRows(tableName: string): Promise<any[] | null> {
	try {
		const rows: any[] = await knexInstance(tableName).select('*').where('type', 'post');
		return rows;
	} catch (error) {
		console.error(error);
		return null;
	}
}

// import { db } from '$lib/core/core/server/data/db/connection';
// import Database from 'better-sqlite3';

// /** @type {import('./$types').RequestHandler} */
// export function GET({ url }) {
// 	const sql = `
//     select * from posts;
//     `;
// 	const stmnt = db.prepare(sql);
// 	const rows = stmnt.all({ limit: 50 });

// 	return new Response(JSON.stringify(rows));
// }
