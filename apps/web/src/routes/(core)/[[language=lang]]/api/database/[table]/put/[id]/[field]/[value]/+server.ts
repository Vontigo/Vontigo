import { error } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

export const GET = (async ({ url, params }) => {
	//console.log(params.field);

	const id = params.id;
	const field = params.field;
	const value = params.value;
	const { table } = params;

	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable(table);
	if (!tableExists) {
		return { status: 404, body: `Table ${table} not found` };
	}

	const count = await knexInstance(table)
		.where({ id })
		.update({ [field]: value });

	if (count > 0) {
		const row = await knexInstance(table).where({ id }).first();
		return new Response(JSON.stringify({ row }), { status: 200 });
	} else {
		return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	}
}) satisfies RequestHandler;
