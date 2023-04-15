import { db } from '$lib/core/core/data/db/connection';
import Database from 'better-sqlite3';

/** @type {import('./$types').RequestHandler} */
export function GET({ url }) {
	const sql = `
    select * from posts;
    `;
	const stmnt = db.prepare(sql);
	const rows = stmnt.all({ limit: 50 });

	return new Response(JSON.stringify(rows));
}
