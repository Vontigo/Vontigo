<script lang="ts">
	import Default from '$lib/themes/casper/Default.svelte';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { page, navigating } from '$app/stores';
	import { Jumper } from 'svelte-loading-spinners';
	import { language, origin, site, siteUrl, theme } from '$lib/core/shared/stores/site';
	// import CompAimChat from '$lib/core/core/frontend/components/shared/CompAIMChat/CompAIMChat.svelte';
	import { fade } from 'svelte/transition';

	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		siteUrl.set($page.params.language ? '/' + $page.params.language : '');
	}
	$site = $page.data.settings.site;
	$theme = $page.data.theme;
</script>

{#key $page.url}
	{#if $navigating}
		<!-- <div class="barloader" transition:fade>
			<Jumper />
		</div> -->

		<div class="loading" transition:fade>
			<div class="loading-bg" style="background-color:{$page.data.settings.site.accent_color};" />
			<div class="m-auto">
				<!-- <ProgressRadial ... stroke={180} meter="stroke-primary-500" track="stroke-primary-500/30" /> -->
				<Jumper />
			</div>
		</div>
	{/if}
	<Default>
		<slot />
	</Default>
{/key}

{@html $page.data.settings.site.codeinjection_foot}

<!-- <CompAimChat /> -->

<style lang="scss" global>
	.loading {
		position: fixed;
		// height: 100%;
		height: 100vh;
		width: 100%;
		z-index: 9999;
		display: flex;
		backdrop-filter: blur(4px);
		.loading-bg {
			position: absolute;
			height: 100%;
			width: 100%;
			// background-color: #fff;

			opacity: 90%;
		}
	}
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
