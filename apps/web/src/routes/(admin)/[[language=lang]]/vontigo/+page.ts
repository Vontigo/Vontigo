// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error, redirect } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load = (async ({ fetch, parent, url, params }) => {
	// const { session } = await parent();
	// if (!session?.user) {
	// 	throw redirect(302, '/');
	// }
	throw redirect(302, '/vontigo/dashboard');
	// if (params.slug === 'hello-world') {
	// 	return {
	// 		title: 'Hello world!',
	// 		content: 'Welcome to our blog. Lorem ipsum dolor sit amet...'
	// 	};
	// }

	// const response = await fetch(`http://localhost:5173/api/content/posts`);
	// const posts = response.json();
	// return {
	//     posts: posts
	// };
}) satisfies PageLoad;
