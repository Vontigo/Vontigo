import type { Handle } from '@sveltejs/kit';
import { config } from '$lib/themes/casper/config.json';
import { language, site, origin, themeConfig, custom } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';

export const handle = (async ({ event, resolve }) => {
	console.log(event);

	themeConfig.set(config);
	custom.set(config.custom)

	console.log(get(custom));


	// tenant.set(event.url.origin);

	const response = await resolve(event);
	return response;
}) satisfies Handle;

