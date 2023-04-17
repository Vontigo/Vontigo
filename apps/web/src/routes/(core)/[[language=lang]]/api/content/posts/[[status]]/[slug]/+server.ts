import { knexInstance } from '$lib/core/core/server/data/db/connection';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url, params }) {
	let returnRows: any;
	console.log(params);
	try {
		const rows: any[] = await knexInstance('posts').select('*').where('slug', params.slug).first();
		returnRows = rows;
	} catch (error) {
		returnRows = error;
	}
	return new Response(JSON.stringify(returnRows), { status: 200 });
}

async function getAllRows(tableName: string): Promise<any[] | null> {
	try {
		const rows: any[] = await knexInstance(tableName).select();
		return rows;
	} catch (error) {
		console.error(error);
		return null;
	}
}

// export function GET({ url, params }) {
// 	let returnRows: any;
// 	console.log(params);

// 	const sql = `
//     select * from posts p where p.slug = $slug and p.status = $status;
//     `;
// 	const stmnt = db.prepare(sql);
// 	const rows = stmnt.get(params);
// 	// console.log(rows);
// 	return new Response(JSON.stringify(rows), { status: 200 });
// }
