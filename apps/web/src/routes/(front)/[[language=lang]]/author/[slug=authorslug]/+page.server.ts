// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load = (async ({ fetch, url, params, parent }) => {
	const _parent = await parent();
	// if (params.slug === 'hello-world') {
	// 	return {
	// 		title: 'Hello world!',
	// 		content: 'Welcome to our blog. Lorem ipsum dolor sit amet...'
	// 	};
	// }

	const response = await fetch(
		`/api/content/author/${params.slug}/page/${_parent.theme.posts_per_page}/1`
	);
	const result = response.json();
	// console.log(await tag);

	return {
		result
	};
}) satisfies PageLoad;
