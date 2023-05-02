// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error, redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load = (async ({ fetch, parent, url, params, cookies }) => {
	const cookieCsrfToken = cookies.get('__Host-next-auth.csrf-token');
	let csrfToken = cookieCsrfToken?.split('|')[0];

	const error = url.searchParams.get('error');

	return {
		csrfToken: csrfToken,
		error: error
	};
}) satisfies PageServerLoad;
