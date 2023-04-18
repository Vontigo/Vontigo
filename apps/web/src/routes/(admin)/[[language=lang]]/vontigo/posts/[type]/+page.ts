import { error } from '@sveltejs/kit';

export function load({ params }) {
	return { type: params.type };
}
