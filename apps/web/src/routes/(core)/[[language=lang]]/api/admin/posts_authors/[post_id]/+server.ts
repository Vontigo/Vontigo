import { error } from '@sveltejs/kit';
import type { RequestHandler } from '../$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

const table = 'posts_authors';
export const GET = (async ({ url, params }) => {
	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable(table);
	if (!tableExists) {
		return { status: 404, body: `Table ${table} not found` };
	}
	const rows = await knexInstance(table)
		.select('u.name')
		.leftJoin('users as u', 'u.id', table + '.author_id')
		.where(params);
	// console.log(rows);

	if (rows) {
		return new Response(JSON.stringify({ rows }), { status: 200 });
	} else {
		return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	}
}) satisfies RequestHandler;

export const POST = (async ({ request, url, params }) => {
	const body = await request.json();

	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable(table);
	if (!tableExists) {
		return { status: 404, body: `Table ${table} not found` };
	}

	await knexInstance(table)
		.where(params)
		.del()
		.then((numDeletedRows) => {
			console.log(`Deleted ${numDeletedRows} rows`);
		})
		.catch((err) => {
			console.error(err);
		});

	const rows = await knexInstance(table).insert(body);
	// console.log(rows);

	// const rows = await knexInstance(table).where({ id: body.id });

	if (rows.length > -1) {
		return new Response(JSON.stringify({ rows }), { status: 200 });
	} else {
		return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	}
}) satisfies RequestHandler;
