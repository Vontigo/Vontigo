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

<svelte:head>
	<meta property="og:site_name" content={$page.data.settings.site.title} />
	<meta property="og:type" content="website" />
	<meta property="og:title" content={$page.data.settings.site.og_title} />
	<meta property="og:description" content={$page.data.settings.site.og_description} />
	<meta property="og:url" content={$page.url.origin} />
	<meta property="og:image" content={$page.data.settings.site.og_image} />
	<meta property="article:publisher" content={$page.data.settings.site.facebook} />
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:title" content={$page.data.settings.site.twitter_title} />
	<meta name="twitter:description" content={$page.data.settings.site.twitter_description} />
	<meta name="twitter:url" content={$page.url.origin} />
	<meta name="twitter:image" content={$page.data.settings.site.twitter_image} />
	<meta name="twitter:site" content={$page.data.settings.site.twitter} />
	<meta property="og:image:width" content="2000" />
	<meta property="og:image:height" content="1400" />
	{@html `<script type="application/ld+json">
		{
			"@context": "https://schema.org",
			"@type": "WebSite",
			"publisher": {
				"@type": "Organization",
				"name": "${$page.data.settings.site.meta_title}"",
				"url": "${$page.url.origin}",
				"logo": {
					"@type": "ImageObject",
					"url": ${$page.data.settings.site.logo},
					"width": 60,
					"height": 60
				}
			},
			"url": "${$page.url.origin}",
			"image": {
				"@type": "ImageObject",
				"url": "${$page.data.settings.site.cover_image}",
				"width": 2000,
				"height": 1400
			},
			"mainEntityOfPage": "${$page.url.origin}",
			"description": "${$page.data.settings.site.meta_description}"
		}
	</script>`}

	{@html $page.data.settings.site.codeinjection_head}
</svelte:head>

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

{@html $page.data.settings.site.codeinjection_foot}

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
