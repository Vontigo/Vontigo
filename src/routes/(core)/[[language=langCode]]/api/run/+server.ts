import { up, down } from '$lib/core/core/server/data/migrations/init/create-tables.js';
import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { knex, Knex } from 'knex';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
	await down(knexInstance);
	await up(knexInstance);
	return new Response(JSON.stringify({ message: 'done' }), { status: 200 });
}
