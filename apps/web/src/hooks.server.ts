import type { Handle } from '@sveltejs/kit';
import { config } from '$lib/themes/casper/config.json';
import { language, site, origin, theme, custom } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';
import { sequence } from '@sveltejs/kit/hooks';
import { CONST_DEFAULT_LANGUAGE } from '$lib/core/shared/const';
import { SvelteKitAuth } from '@auth/sveltekit';
import Google from '@auth/core/providers/google';
import Credentials from '@auth/core/providers/credentials';
import { AUTH_SECRET, DATABASE_TYPE, GOOGLE_ID, GOOGLE_SECRET } from '$env/static/private';
import fs from 'fs';
import { redirect } from '@sveltejs/kit';
import { dynamicDefault } from '$lib/core/core/server/helpers/settings/settings';
import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { ENUM_DATABASE_TABLE, ENUM_DATABASE_TYPE, ENUM_USER_ROLE } from '$lib/core/shared/enum';
import { decode } from '@auth/core/jwt';
// import { KnexAdapter } from '$lib/core/core/server/services/auth/authjs';
import { globalConfig } from '$lib/core/shared/config/env/config';
import knex, { Knex } from 'knex';

const setup = (async ({ event, resolve }) => {
	console.log(globalConfig.database[DATABASE_TYPE]);

	if (DATABASE_TYPE === ENUM_DATABASE_TYPE.sqlite) {
		// Do something
		const dbFilePath = 'database/vontigo.db';

		let isDbExist = false;
		if (fs.existsSync(dbFilePath)) {
			// console.log('File exists!');
			isDbExist = true;
		} else {
			// console.log('File does not exist.');
			isDbExist = false;
		}

		if (isDbExist) {
			if (event.url.pathname.indexOf('/setup') > -1) throw redirect(303, '/');
		} else {
			if (event.url.pathname.indexOf('/setup') < 0) throw redirect(303, '/setup');
		}
	} else {
		const _knexInstance: Knex = await knex(globalConfig.database[DATABASE_TYPE]);
		const tableExists = await _knexInstance.schema.hasTable(ENUM_DATABASE_TABLE.settings);

		if (tableExists) {
			console.log(`Table exists: ${tableExists}`);
			// knexInstance.destroy();
			if (event.url.pathname.indexOf('/setup') > -1) throw redirect(303, '/');
		} else {
			console.error(`Table not exists: ${tableExists}`);
			// knexInstance.destroy();
			if (event.url.pathname.indexOf('/setup') < 0) throw redirect(303, '/setup');
		}
	}

	return await resolve(event);
}) satisfies Handle;

// TODO: https://github.com/nextauthjs/next-auth/discussions/3038
const auth = SvelteKitAuth({
	// trustHost: true,
	// adapter: KnexAdapter(knexInstance),
	providers: [
		// Google({
		// 	clientId: GOOGLE_ID,
		// 	clientSecret: GOOGLE_SECRET
		// }),
		Credentials({
			credentials: {
				username: { label: 'Email' },
				password: { label: 'Password', type: 'password' }
			},
			async authorize({ username, password }) {
				// console.log('SvelteKitAuth', username);
				const user = await knexInstance(ENUM_DATABASE_TABLE.users + ' as u')
					.select('u.*', 'r.name as role')
					.leftJoin(ENUM_DATABASE_TABLE.roles_users + ' as ru', 'ru.user_id', 'u.id')
					.leftJoin(ENUM_DATABASE_TABLE.roles + ' as r', 'ru.role_id', 'r.id')
					.where({
						email: username,
						password: password
					})
					.first();
				// const user = userReq.json();

				return user;
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
	},
	pages: {
		signIn: '/account/signin'
	},
	theme: {
		colorScheme: 'light', //"auto" | "dark" | "light"
		logo: 'https://authjs.dev/img/logo/logo-xs.webp'
		// brandColor?: string
		// buttonText: 'Signin'
	},
	useSecureCookies: true,
	secret: AUTH_SECRET
	// pages: {
	// 	signIn: '/login' //Need to define custom login page (if using)
	// },
});

const api = (async ({ event, resolve }) => {
	// console.log('______LayoutServerLoad (admin): ', await event.locals.getSession());
	// console.log(
	// 	'______LayoutServerLoad (admin): ',
	// 	event.cookies.get('__Secure-next-auth.session-token')
	// );

	if (event.url.pathname.indexOf('/api') > -1) {
		if (
			event.url.pathname.indexOf('/api/admin') > -1 ||
			event.url.pathname.indexOf('/api/database') > -1
		) {
			const decoded = await decode({
				token: event.cookies.get('__Secure-next-auth.session-token'),
				secret: AUTH_SECRET
			});
			// console.log('HOOK decoded', decoded);
			const session = await event.locals.getSession();
			// console.log('_________ user', session?.user);
			if (
				!session?.user &&
				session?.user.role != ENUM_USER_ROLE.Administrator &&
				session?.user.role != ENUM_USER_ROLE.Owner
			) {
				// console.log(event.url.pathname);
				//throw redirect(303, '/auth/signin');
				throw redirect(303, '/account/signin');
				//return null;
			} else {
			}
		}

		if (event.url.pathname.indexOf('/api/shared/settings') > -1) {
			if (event.url.pathname.indexOf('/api/shared/settings/site') < 0) {
				throw redirect(303, '/account/signin');
			}
		}
	}

	return await resolve(event);
	// const session = await event.locals.getSession();
	// // if (!session?.user) throw redirect(303, '/auth/signin');

	// if (!session?.user) {
	// 	throw redirect(303, '/auth/signin');
	// }

	// if (
	// 	session?.user &&
	// 	session?.user.role != ENUM_USER_ROLE.Administrator &&
	// 	session?.user.role != ENUM_USER_ROLE.Owner
	// ) {
	// 	throw redirect(303, '/auth/signin');
	// 	// throw redirect(303, '/account/signin');
	// }
}) satisfies Handle;

export const handle = sequence(setup, auth, api);

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
