import { error } from '@sveltejs/kit';
import type { RequestHandler } from '../../../$types';
import { App } from 'octokit';
import { privateKey } from '../../../config';

export const GET = (async ({ url, params }) => {
	const app = new App({
		appId: '331734',
		privateKey: privateKey
	});
	const octokit = await app.getInstallationOctokit(37335916);

	const resDiscussion = await octokit.graphql(`query($owner: String!, $repo: String!) {
		repository(owner: $owner, name: $repo) {
			discussions(first: 10) {
				nodes {
					title
					url
					author {
						login
						avatarUrl(size: 50)
					}
				}
			}
		}
	}`, {

		owner: params.owner,
		repo: params.repo
	});

	return new Response(JSON.stringify({ data: resDiscussion }), { status: 200 });


	// const resRepo = await octokit.request(
	// 	`GET /repos/${params.owner}/${params.repo}${params.command ? '/' + params.command : ''}`,
	// 	{
	// 		owner: 'OWNER',
	// 		repo: 'REPO',
	// 		per_page: url.searchParams.get('per_page') || 5
	// 	}
	// );

	// // console.log(resRepo.data);
	// if (resRepo.data) {
	// 	return new Response(JSON.stringify({ data: resRepo.data }), { status: 200 });
	// }

	// if (rows) {
	// 	return new Response(JSON.stringify({ rows }), { status: 200 });
	// } else {
	// 	return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	// }
}) satisfies RequestHandler;
