import { error } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

export const GET = (async ({ url, params }) => {
	const { table, field, value } = params;

	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable(table);
	if (!tableExists) {
		return { status: 404, body: `Table ${table} not found` };
	}

	const rows = await knexInstance(table)
		.select()
		.where({ [field]: value });
	if (rows) {
		return new Response(JSON.stringify({ rows }), { status: 200 });
	} else {
		return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	}
}) satisfies RequestHandler;
