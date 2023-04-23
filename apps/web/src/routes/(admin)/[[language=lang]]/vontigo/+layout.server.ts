import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async (event) => {
	console.log('______LayoutServerLoad (admin): ', await event.locals.getSession());
	const session = await event.locals.getSession();
	if (!session?.user) throw redirect(303, '/auth/signin');

	return {
		session: await event.locals.getSession()
	};
};
