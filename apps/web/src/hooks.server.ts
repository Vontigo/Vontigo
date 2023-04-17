import type { Handle } from '@sveltejs/kit';
import { config } from '$lib/themes/casper/config.json';
import { language, site, origin, themeConfig, custom } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';
import { sequence } from '@sveltejs/kit/hooks';
import { PUBLIC_DEFAULT_LANG } from '$env/static/public';

const firstHandle = (async ({ event, resolve }) => {
	// Do something
	return await resolve(event);
}) satisfies Handle;

const secondHandle = (async ({ event, resolve }) => {
	const response = await resolve(event);

	// Get theme default config
	themeConfig.set(config);
	custom.set(config.custom)

	const myResponse = response.clone();
	// Change html, body attributes based on the theme config
	if (response.headers.get('content-type') === 'text/html') {
		// console.log(event.url);
		if (event.url.pathname === '/') {
			// console.log(event.request);
			language.set(PUBLIC_DEFAULT_LANG);
		} else {

			const lang = event.url.pathname.split('/')[1];
			language.set(lang);
		}

		const response = await resolve(event, {
			transformPageChunk: ({ html }) =>
				html.replace('%sveltekit.html.attributes%',
					`lang="${get(language)}"`)
					.replace('%sveltekit.body.attributes%',
						``)
		});
		return response;
	}

	// tenant.set(event.url.origin);

	//if (response.headers['content-type'] == 'text/plain;charset=UTF-8')


	// if (response.headers['content-type'].indexOf('text/html; charset=utf-8') >= 0) {
	// 	console.log(response.body);
	// 	// const skin = await loadSkin(request.host, request.path);
	// 	// const [before, after] = skin.split('{{app}}');
	// 	response.body = response.body
	// 		.replace('%sveltekit.html.attributes%', '')
	// 		.replace('%sveltekit.body.attributes%', '');
	// }

	return response;
}) satisfies Handle;

export const handle = sequence(firstHandle, secondHandle);