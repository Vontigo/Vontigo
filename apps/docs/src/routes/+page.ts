import { redirect } from '@sveltejs/kit';

export const prerender = 'auto';

export function load() {
	throw redirect(307, '/getting-started/introduction');
}
