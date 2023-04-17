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

		// Set html lang
		if (event.url.pathname === '/') {
			// console.log(event.request);
			language.set(PUBLIC_DEFAULT_LANG);
		} else {
			const lang = event.url.pathname.split('/')[1];
			language.set(lang);
		}

		// Set html custom theme
		let htmlClass = '';
		if (get(custom).color_scheme.default == "Dark") {
			htmlClass = ' class="dark-mode"';
		} else if (get(custom).color_scheme.default == "Auto") {
			htmlClass = ' class="auto-color"';
		}

		// Set body custom theme
		let bodyClass = ' class="';

		if (event.url.pathname === '/') {
			bodyClass += `home-template`;
		} else if (event.url.pathname.split('/').length == 2) {
			bodyClass += `home-template`;
		}

		if (get(custom).navigation_layout.default == "Logo on cover") {
			bodyClass += ` is-head-left-logo`;
		} else if (get(custom).navigation_layout.default == "Logo in the middle") {
			bodyClass += ' is-head-middle-logo';
		} else {
			bodyClass += ' stacked';
		}

		if (get(custom).title_font.default == "Elegant serif") {
			bodyClass += ` has-serif-title`;
		}

		if (get(custom).body_font.default == "Modern sans-serif") {
			bodyClass += `  has-sans-body`;
		}

		if (get(custom).show_publication_cover.default) {
			bodyClass += ` has-cover`;
		}
		bodyClass += '"';


		const response = await resolve(event, {
			transformPageChunk: ({ html }) =>
				html.replace('%sveltekit.html.attributes%',
					`lang="${get(language)}"${htmlClass}`)
					.replace('%sveltekit.body.attributes%',
						`${bodyClass}`)
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