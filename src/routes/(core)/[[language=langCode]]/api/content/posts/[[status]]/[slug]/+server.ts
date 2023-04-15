import { db } from '$lib/core/core/data/db/connection';
import Database from 'better-sqlite3';

/** @type {import('./$types').RequestHandler} */
export function GET({ url, params }) {
	console.log(params);

	const sql = `
    select * from posts p where p.slug = $slug and p.status = $status;
    `;
	const stmnt = db.prepare(sql);
	const rows = stmnt.get(params);
	// console.log(rows);
	return new Response(JSON.stringify(rows), { status: 200 });
}
