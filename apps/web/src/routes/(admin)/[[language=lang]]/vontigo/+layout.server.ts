import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { isSignedIn } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';
import { ENUM_USER_ROLE } from '$lib/core/shared/enum';
// import { decode } from '@auth/core/jwt';
import { AUTH_SECRET } from '$env/static/private';

export const load: LayoutServerLoad = async (event) => {
	// console.log('______LayoutServerLoad (admin): ', await event.locals.getSession());
	// console.log(
	// 	'______LayoutServerLoad (admin): ',
	// 	event.cookies.get('__Secure-next-auth.session-token')
	// );

	// const decoded = await decode({
	// 	token: event.cookies.get('__Secure-next-auth.session-token'),
	// 	secret: AUTH_SECRET
	// });
	// console.log('decoded', decoded);

	const session = await event.locals.getSession();
	// if (!session?.user) throw redirect(303, '/auth/signin');

	if (!session?.user) {
		throw redirect(303, '/auth/signin');
	}

	if (
		session?.user &&
		session?.user.role != ENUM_USER_ROLE.Administrator &&
		session?.user.role != ENUM_USER_ROLE.Owner
	) {
		throw redirect(303, '/auth/signin');
		// throw redirect(303, '/account/signin');
	}

	// console.log(event.url.pathname);
	// if (get(isSignedIn) == false && event.url.pathname != '/vontigo/signin') {
	// 	throw redirect(303, '/vontigo/signin');
	// } else if (get(isSignedIn) == true && event.url.pathname == '/vontigo/signin') {
	// 	console.log(event.url.pathname);

	// 	throw redirect(303, '/vontigo/dashboard');
	// }

	return {
		session: await event.locals.getSession()
	};
};
