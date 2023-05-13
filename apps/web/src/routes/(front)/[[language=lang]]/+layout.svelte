<script lang="ts">
	import Default from '$lib/themes/casper/Default.svelte';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { page } from '$app/stores';
	import { language, origin, site, siteUrl, theme } from '$lib/core/shared/stores/site';
	import CompAimChat from '$lib/core/core/frontend/components/shared/CompAIMChat/CompAIMChat.svelte';

	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		siteUrl.set($page.params.language ? '/' + $page.params.language : '');
	}
	$site = $page.data.settings.site;
	$theme = $page.data.theme;
</script>

{#key $page.url}
	<Default>
		<slot />
	</Default>
{/key}

<!-- <CompAimChat /> -->
