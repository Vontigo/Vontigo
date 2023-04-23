<script lang="ts">
	import Layout from '$lib/themes/casper/Layout.svelte';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { page } from '$app/stores';
	import {
		custom,
		language,
		origin,
		site,
		siteUrl,
		themeConfig
	} from '$lib/core/shared/stores/site';

	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		siteUrl.set($page.params.language ? '/' + $page.params.language : '');
	}
	$site = $page.data.settings.site;
	$themeConfig = $page.data.themeConfig;
	$custom = $page.data.themeConfig.custom;
</script>

{#key $page.url}
	<Layout>
		<slot />
	</Layout>
{/key}
