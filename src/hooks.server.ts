import { tenant } from '$lib/stores/site';
import type { Handle } from '@sveltejs/kit';

export const handle = (async ({ event, resolve }) => {
	// console.log(event);

	// tenant.set(event.url.origin);

	const response = await resolve(event);
	return response;
}) satisfies Handle;
