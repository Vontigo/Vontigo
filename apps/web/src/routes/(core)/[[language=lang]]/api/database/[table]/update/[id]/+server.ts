import { error } from '@sveltejs/kit';
import type { RequestHandler } from '../$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

export const PUT = (async ({ request, url, params }) => {
	// const { method, body } = request;
	const { table, id } = params;
	const body = await request.json();
	// console.log(body);

	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable(table);
	if (!tableExists) {
		return { status: 404, body: `Table ${table} not found` };
	}

	const count = await knexInstance(table).where({ id }).update(body);

	if (count > 0) {
		const row = await knexInstance(table).where({ id }).first();
		return new Response(JSON.stringify({ row }), { status: 200 });
	} else {
		return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	}

	// return new Response(JSON.stringify(rows), { status: 200 });
}) satisfies RequestHandler;
