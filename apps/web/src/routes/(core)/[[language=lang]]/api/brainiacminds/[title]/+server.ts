import { error } from '@sveltejs/kit';
import type { RequestHandler } from '../$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';

export const GET = (async ({ fetch, request, url, params }) => {
	// const body = await request.json();
	let brainiacmindsJson: any;

	const aimResponse = await fetch(`/api/shared/settings/brainiacminds`);
	const aimResponseJson = await aimResponse.json();

	// console.log(aimResponseJson);

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

	const requestOptions = {
		method: 'POST',
		headers: { 'Content-Type': 'application/json' },
		body: JSON.stringify({
			key: aimSettings.brainiacminds.aim_key,
			temperature: Number.parseFloat(aimSettings.brainiacminds.aim_temperature),
			maxtokens: Number.parseInt(aimSettings.brainiacminds.aim_max_tokens),
			title: params.title,
			mainpoints: aimSettings.brainiacminds.aim_mainpoints,
			topics: aimSettings.brainiacminds.aim_topics,
			maxwords: Number.parseInt(aimSettings.brainiacminds.aim_article_max_words),
			prompt: aimSettings.brainiacminds.aim_custom_prompt
		})
	};

	console.log(requestOptions);

	const chatBrainiacMindsRes = await fetch(
		`${aimSettings.brainiacminds.aim_url}/beta`,
		requestOptions
	);

	console.log(await chatBrainiacMindsRes);

	brainiacmindsJson = await chatBrainiacMindsRes.json();
	return new Response(JSON.stringify({ brainiacmindsJson }));
	// if (brainiacmindsJson?.Choices[0]?.Message?.Content) {
	// 	return new Response(JSON.stringify({ brainiacmindsJson }), { status: 200 });
	// } else {
	// 	return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	// }
}) satisfies RequestHandler;
