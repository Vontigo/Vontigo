import type { LayoutLoad } from './$types';
import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
import { language, site, origin, themeConfig, custom, siteUrl } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';
import { config } from '$lib/themes/casper/config.json';

const output: SiteGroup = {};

export const load = (async ({ fetch, url, params }) => {
	// console.log(params);

	const response = await fetch(`/api/shared/settings/site`);
	const settings = response.json();
	// console.log('_______________', await settings);

	for (const item of await settings) {
		if (!output[item.group]) {
			output[item.group] = {};
		}

		output[item.group][item.key] = item.value;
	}

	site.set(output.site);
	themeConfig.set(config);
	custom.set(config.custom)

	// console.log('________________', get(site));
	// origin.set('/content/' + url.host.replace(':', '_') + '/' + params.language);


	return {
		settings: output
	};

}) satisfies LayoutLoad;
