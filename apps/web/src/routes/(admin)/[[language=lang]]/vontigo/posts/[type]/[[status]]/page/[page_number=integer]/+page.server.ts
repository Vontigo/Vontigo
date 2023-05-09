// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error } from '@sveltejs/kit';
import type { PageLoad } from '../../../../$types';
// import type { PageLoad } from '../../../$types';

export const load = (async ({ fetch, url, params, parent }) => {
	// if (params.slug === 'hello-world') {
	// 	return {
	// 		title: 'Hello world!',
	// 		content: 'Welcome to our blog. Lorem ipsum dolor sit amet...'
	// 	};
	// }

	const response = await fetch(
		`/api/admin/posts/${params.type}/${params.status != 'drafts' ? params.status : 'draft'}/page/${
			params.page_number
		}`
	);
	const data = await response.json();

	const tagsResponse = await fetch(`/api/admin/tags/public`);
	const tagsData = await tagsResponse.json();

	const aimResponse = await fetch(`/api/shared/settings/brainiacminds`);
	const aimResponseJson = aimResponse.json();

	let aimSettings: any = {};
	for (const item of await aimResponseJson) {
		// if (!parent.settings[item.group]) {
		// 	parent.settings[item.group] = {};
		// }
		// const newGroup = item.group;
		// const newKey = item.key;

		if (!aimSettings[item.group]) {
			aimSettings[item.group] = {};
		}

		aimSettings[item.group][item.key] = item.value;
	}

	// console.log(aimSettings);

	// console.log(tagsData);
	// if (data) console.log(data[0]);

	return {
		brainiacminds: aimSettings,
		posts: data,
		tags: tagsData
	};
}) satisfies PageLoad;
