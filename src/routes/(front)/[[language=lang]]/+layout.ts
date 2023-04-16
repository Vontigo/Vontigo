import type { LayoutLoad } from './$types';
import { PUBLIC_DEFAULT_LANG, PUBLIC_SITE_URL } from '$env/static/public';
import { language, site, origin, themeConfig, custom } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store'
import { config } from '$lib/themes/casper/config.json'

const output: SiteGroup = {};

export const load = (async (url: string, params: string) => {
	// console.log(params);
	// tenant.set(url.origin);
	// if (params) language.set(params.language ? params.language : PUBLIC_DEFAULT_LANG);

	const response = await fetch(`${PUBLIC_SITE_URL}/api/shared/settings/site`);
	const settings = response.json();

	for (const item of await settings) {
		if (!output[item.group]) {
			output[item.group] = {};
		}

		output[item.group][item.key] = item.value;
	}

	site.set(output.site);
	themeConfig.set(config);
	custom.set(config.custom)

	console.log('________________', get(site));
	// origin.set('/content/' + url.host.replace(':', '_') + '/' + params.language);


	return {
		settings: output
	};

}) satisfies LayoutLoad;
