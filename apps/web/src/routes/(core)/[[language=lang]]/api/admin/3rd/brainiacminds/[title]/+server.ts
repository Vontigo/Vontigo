import { error } from '@sveltejs/kit';
import type { RequestHandler } from '../$types';
import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { bool } from 'sharp';

export const GET = (async ({ fetch, request, url, params }) => {
	// const body = await request.json();

	// console.log('_____2');
	const aimResponse = await fetch(`/api/admin/settings/brainiacminds`);
	const aimResponseJson = await aimResponse.json();

	// console.log('_____3', aimResponseJson);

	let settings: any = {};

	for (const item of await aimResponseJson) {
		// if (!parent.settings[item.group]) {
		// 	parent.settings[item.group] = {};
		// }
		// const newGroup = item.group;
		// const newKey = item.key;

		if (!settings[item.group]) {
			settings[item.group] = {};
		}

		settings[item.group][item.key] = item.value;
	}

	// console.log(aimSettings);

	if (settings.brainiacminds.aim_key != 'YOUR_OPENAI_KEY') {
		const requestOptions = {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				key: settings.brainiacminds.aim_key,
				temperature: Number.parseFloat(settings.brainiacminds.aim_temperature),
				maxtokens: Number.parseInt(settings.brainiacminds.aim_max_tokens),
				title: params.title,
				mainpoints: settings.brainiacminds.aim_mainpoints,
				topics: settings.brainiacminds.aim_topics,
				maxwords: Number.parseInt(settings.brainiacminds.aim_article_max_words),
				prompt: settings.brainiacminds.aim_custom_prompt.replace('{{title}}', params.title),
				isCustomPromp: settings.brainiacminds.aim_using_custom_prompt
			})
		};

		const chatBrainiacMindsRes = await fetch(settings.brainiacminds.aim_url, requestOptions);
		const brainiacmindsJson = await chatBrainiacMindsRes.json();

		return new Response(JSON.stringify({ brainiacminds: brainiacmindsJson }));
	} else {
		console.log('__GEN DEMO CHATGPT CONTENT');

		// return demo chatgpt contetns
		return new Response(
			JSON.stringify({
				brainiacminds: {
					Id: 'chatcmpl-7EKubLA0uB5sxQwPuDR8W2EZic9GR',
					Choices: [
						{
							Index: 0,
							Message: {
								Content: JSON.stringify({
									type: 'doc',
									content: [
										{
											type: 'paragraph',
											attrs: { textAlign: 'left' },
											content: [
												{
													type: 'text',
													text: 'The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.'
												}
											]
										},
										{
											type: 'paragraph',
											attrs: { textAlign: 'left' },
											content: [
												{
													type: 'text',
													text: 'One of the key benefits of AI-powered CMS is the ability to automate repetitive tasks, such as content creation, curation, and optimization. This frees up time for content creators to focus on more strategic tasks, such as developing new ideas and engaging with their audience.'
												}
											]
										},
										{
											type: 'paragraph',
											attrs: { textAlign: 'left' },
											content: [
												{
													type: 'text',
													text: "Another advantage of AI-powered CMS is the ability to personalize content for individual users. By analyzing user data, AI algorithms can deliver personalized content recommendations, tailored to each user's interests and preferences. This not only improves the user experience but also increases engagement and conversions."
												}
											]
										},
										{
											type: 'paragraph',
											attrs: { textAlign: 'left' },
											content: [
												{
													type: 'text',
													text: 'AI-powered CMS also offers advanced analytics and reporting capabilities, allowing content creators to track and analyze the performance of their content in real-time. This data can be used to optimize content for better engagement and conversions, as well as to identify new opportunities for growth and expansion.'
												}
											]
										},
										{
											type: 'paragraph',
											attrs: { textAlign: 'left' },
											content: [
												{
													type: 'text',
													text: 'Overall, the new generation of CMS powered by AI is transforming the way we create, manage, and optimize content. By automating repetitive tasks, personalizing content, and providing advanced analytics, AI-powered CMS platforms are helping content creators to work smarter, not harder. As AI technology continues to evolve, we can expect to see even more innovative features and capabilities in the future. '
												}
											]
										},
										{
											type: 'paragraph',
											attrs: { textAlign: 'center' },
											content: [
												{
													type: 'text',
													marks: [{ type: 'italic' }],
													text: '"The stuff shown above is solely for demonstration purposes. To receive the authentic ChatGPT content, please enter your OpenAI key in Settings > BrainiacMinds > Aim Key area!" '
												}
											]
										}
									]
								})
							},
							FinishReason: 'stop',
							Delta: null
						}
					],
					Usage: { CompletionTokens: 352, PromptTokens: 227, TotalTokens: 579 },
					Created: '2023-05-09T16:55:33',
					CreatedUnixTime: 1683651333,
					Model: {
						ModelID: 'gpt-3.5-turbo-0301',
						OwnedBy: null,
						Object: null,
						Created: null,
						CreatedUnixTime: null,
						Permission: [],
						Root: null,
						Parent: null
					},
					Object: 'chat.completion',
					Organization: 'user-5wbx4u4bsu6wi5u2s3ye8aao',
					ProcessingTime: '00:00:08.5290000',
					RequestId: '343c148e6ffb50d129c28f450d533867',
					OpenaiVersion: '2020-10-01'
				}
			})
		);
	}
}) satisfies RequestHandler;
