<script lang="ts">
	import Default from '$lib/themes/casper/Default.svelte';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { page, navigating } from '$app/stores';
	import { Jumper } from 'svelte-loading-spinners';
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
	{#if $navigating}
		<div class="barloader">
			<Jumper />
		</div>
	{/if}
	<Default>
		<slot />
	</Default>
{/key}

<!-- <CompAimChat /> -->

<style lang="scss" global>
	.barloader {
		/* position: absolute;
		top: 0;
		width: 100%;
		height: 10px;
		display: flex; */
		position: absolute;

		// width: 100%;
		height: 88px;
		z-index: 9999;
		margin-top: 1rem;
		margin-left: 1rem;
		.wrapper {
			width: 100% !important;
		}
	}
</style>
