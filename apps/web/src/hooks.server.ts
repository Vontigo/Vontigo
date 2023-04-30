import type { Handle } from '@sveltejs/kit';
import { config } from '$lib/themes/casper/config.json';
import { language, site, origin, themeConfig, custom } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';
import { sequence } from '@sveltejs/kit/hooks';
import { CONST_DEFAULT_LANGUAGE } from '$lib/core/shared/const';
import { SvelteKitAuth } from '@auth/sveltekit';
import Google from '@auth/core/providers/google';
import Credentials from '@auth/core/providers/credentials';
import { AUTH_SECRET, GOOGLE_ID, GOOGLE_SECRET } from '$env/static/private';
import fs from 'fs';
import { redirect } from '@sveltejs/kit';

const setup = (async ({ event, resolve }) => {
	// Do something
	console.log(event.url);
	const dbFilePath = './database/vontigo.db';

	let isDbExist = false;
	try {
		// Check if the file exists
		await fs.promises.access(dbFilePath);

		// File exists
		console.log('Database file exists!');
		isDbExist = true;
	} catch (error) {
		// File doesn't exist
		console.error('Database file does not exist!', error);
		isDbExist = false;
	}

	if (isDbExist) {
		if (event.url.pathname.indexOf('/setup') > -1) throw redirect(303, '/');
	} else {
		if (event.url.pathname.indexOf('/setup') < 0) throw redirect(303, '/setup');
	}

	return await resolve(event);
}) satisfies Handle;
// TODO: https://github.com/nextauthjs/next-auth/discussions/3038
const auth = SvelteKitAuth({
	trustHost: true,
	secret: AUTH_SECRET,
	providers: [
		Google({
			clientId: GOOGLE_ID,
			clientSecret: GOOGLE_SECRET
		}),
		Credentials({
			credentials: {
				username: { label: 'Username' },
				password: { label: 'Password', type: 'password' }
			},
			async authorize({ request }) {
				//const response = await fetch(request);
				//if (!response.ok) return null;
				//return (await response.json()) ?? null;
				//https://webkul.com/blog/how-to-implement-authentication-in-nextjs-with-magento2-using-credentials-provider/
				return {
					id: 1,
					name: 'Huy Nguyen',
					email: 'i.love.to.smile.around@gmail.com',
					role: 'Administrator',
					image:
						'https://lh3.googleusercontent.com/a/AGNmyxbKXTS_H0ATpH89eMRUsFJZwMCtVVJAkPoMjanW8pY=s96-c'
				};
			}
		})
	],
	callbacks: {
		jwt: async ({ token, user }) => {
			user && (token.user = user);
			return token;
		},
		session: async ({ session, token }) => {
			session.user = token.user; // Setting token in session
			return session;
		}
	}
	// pages: {
	// 	signIn: '/login' //Need to define custom login page (if using)
	// },
});

export const handle = sequence(setup, auth);

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
