import { error } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

export const GET = (async ({ url, params }) => {
	const { table, id } = params;

	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable(table);
	if (!tableExists) {
		return { status: 404, body: `Table ${table} not found` };
	}
	const row = await knexInstance(table).select().where({ id }).first();
	if (row) {
		return new Response(JSON.stringify({ row }), { status: 200 });
	} else {
		return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	}
}) satisfies RequestHandler;
