import { error } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

export const GET = (async ({ url, params }) => {
	const themeComp = `
		<p>Hello World!</p>
	`;

	return new Response(themeComp, { status: 200 });
}) satisfies RequestHandler;
