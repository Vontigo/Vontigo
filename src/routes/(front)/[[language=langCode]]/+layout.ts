import type { LayoutLoad } from './$types';
import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
import { language, tenant } from '$lib/stores/site';

export const load = ((url: any, params: any) => {
	// console.log(params);
	// tenant.set(url.origin);
	// if (params) language.set(params.language ? params.language : PUBLIC_DEFAULT_LANG);
}) satisfies LayoutLoad;
