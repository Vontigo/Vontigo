// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load = (async ({ fetch, url, params }) => {
	//console.log(params);

	// if (params.slug === 'hello-world') {
	// 	return {
	// 		title: 'Hello world!',
	// 		content: 'Welcome to our blog. Lorem ipsum dolor sit amet...'
	// 	};
	// }

	const response = await fetch(`/api/content/posts`);
	const posts = response.json();
	return {
		posts: posts
	};
}) satisfies PageLoad;
