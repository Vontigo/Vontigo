import type { Handle } from '@sveltejs/kit';
import { config } from '$lib/themes/casper/config.json';
import { language, site, origin, themeConfig, custom } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';
import { sequence } from '@sveltejs/kit/hooks';
import { CONST_DEFAULT_LANGUAGE } from '$lib/core/shared/const';
import { SvelteKitAuth } from '@auth/sveltekit';
import Google from '@auth/core/providers/google';
import { AUTH_SECRET, GOOGLE_ID, GOOGLE_SECRET } from '$env/static/private';

const auth = SvelteKitAuth({
	providers: [Google({ clientId: GOOGLE_ID, clientSecret: GOOGLE_SECRET })],
	secret: AUTH_SECRET
});

export const handle = sequence(auth);

// const firstHandle = (async ({ event, resolve }) => {
// 	// Do something
// 	// console.log(event.url);

// 	return await resolve(event);
// }) satisfies Handle;

// const secondHandle = (async ({ event, resolve }) => {
// 	const response = await resolve(event);

// 	// Get theme default config
// 	themeConfig.set(config);
// 	custom.set(config.custom);

// 	const myResponse = response.clone();
// 	// Change html, body attributes based on the theme config
// 	if (response.headers.get('content-type') === 'text/html') {
// 		// Set html lang
// 		if (event.url.pathname === '/') {
// 			// console.log(event.request);
// 			language.set(CONST_DEFAULT_LANGUAGE);
// 		} else {
// 			const lang = event.url.pathname.split('/')[1];
// 			language.set(lang);
// 		}

// 		// Set html custom theme
// 		let htmlClass = '';
// 		if (get(custom).color_scheme.default == 'Dark') {
// 			htmlClass = ' class="dark-mode"';
// 		} else if (get(custom).color_scheme.default == 'Auto') {
// 			htmlClass = ' class="auto-color"';
// 		}

// 		// Set body custom theme
// 		let bodyClass = ' class="';
// 		bodyClass += '"';

// 		const response = await resolve(event, {
// 			transformPageChunk: ({ html }) =>
// 				html
// 					.replace('%sveltekit.html.attributes%', `lang="${get(language)}"${htmlClass}`)
// 					.replace('%sveltekit.body.attributes%', `${bodyClass}`)
// 		});
// 		return response;
// 	}

// 	// tenant.set(event.url.origin);

// 	//if (response.headers['content-type'] == 'text/plain;charset=UTF-8')

// 	// if (response.headers['content-type'].indexOf('text/html; charset=utf-8') >= 0) {
// 	// 	console.log(response.body);
// 	// 	// const skin = await loadSkin(request.host, request.path);
// 	// 	// const [before, after] = skin.split('{{app}}');
// 	// 	response.body = response.body
// 	// 		.replace('%sveltekit.html.attributes%', '')
// 	// 		.replace('%sveltekit.body.attributes%', '');
// 	// }

// 	return response;
// }) satisfies Handle;

// export const handle = sequence(firstHandle, secondHandle);
