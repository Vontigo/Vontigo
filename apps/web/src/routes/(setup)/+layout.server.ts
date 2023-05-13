import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { isSignedIn } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';

export const load: LayoutServerLoad = async (event) => {
	// console.log('______LayoutServerLoad (admin): ', await event.locals.getSession());

	const session = await event.locals.getSession();
	// if (!session?.user) throw redirect(303, '/auth/signin');
	// if (session?.user.role != 'Administrator') {
	// 	throw redirect(303, '/auth/signin');
	// }

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
