// since there's no dynamic data here, we can prerender
// it so that it gets served as a static asset in production
// export const prerender = true;
import { error } from '@sveltejs/kit';
import type { PageLoad } from '../$types';
import { App } from 'octokit';
// import type { PageLoad } from '../../../$types';

export const load = (async ({ fetch, url, params, parent }) => {
	return {
		// githubRepo: resRepo
		// githubReleases: resRepo
	};
}) satisfies PageLoad;
