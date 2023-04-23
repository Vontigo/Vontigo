import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async (event) => {
	console.log('______LayoutServerLoad (front): ', await event.locals.getSession());

	return {
		session: await event.locals.getSession()
	};
};
