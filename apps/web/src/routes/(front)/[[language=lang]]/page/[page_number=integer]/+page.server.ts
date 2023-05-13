// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error, redirect } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load = (async ({ fetch, parent, url, params }) => {
	//console.log(params);
	const _parent = await parent();
	// console.log(_parent);

	// if (!session?.user) {
	// 	throw redirect(302, '/');
	// }

	// if (params.slug === 'hello-world') {
	// 	return {
	// 		title: 'Hello world!',
	// 		content: 'Welcome to our blog. Lorem ipsum dolor sit amet...'
	// 	};
	// }

	const response = await fetch(
		`/api/content/posts/public/page/${_parent.theme.posts_per_page}/${params.page_number}`
	);
	const posts = await response.json();
	return {
		posts: await posts
	};
}) satisfies PageLoad;
