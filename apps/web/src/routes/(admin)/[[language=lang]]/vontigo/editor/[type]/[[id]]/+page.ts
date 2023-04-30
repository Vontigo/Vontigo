// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error } from '@sveltejs/kit';
import type { PageLoad } from '../../$types';

export const load = (async ({ fetch, url, params }) => {
	// if (params.slug === 'hello-world') {
	// 	return {
	// 		title: 'Hello world!',
	// 		content: 'Welcome to our blog. Lorem ipsum dolor sit amet...'
	// 	};
	// }

	const response = await fetch(`/api/admin/posts/${params.type}/${params.slug}`);
	const data = await response.json();
	// console.log(data);
	// if (data) console.log(data[0]);

	return {
		post: data[0]
	};
}) satisfies PageLoad;
