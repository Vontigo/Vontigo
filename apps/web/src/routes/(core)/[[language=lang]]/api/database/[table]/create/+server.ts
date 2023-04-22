import { error } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

export const POST = (async ({ request, url, params }) => {
	const { method, body } = request;
	const { table } = params;

	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable(table);
	if (!tableExists) {
		return { status: 404, body: `Table ${table} not found` };
	}

	const [id] = await knexInstance(table).insert(body);
	const row = await knexInstance(table).where({ id }).first();
	return {
		status: 201,
		body: row
	};
}) satisfies RequestHandler;
