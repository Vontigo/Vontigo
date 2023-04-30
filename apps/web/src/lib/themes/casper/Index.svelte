<script lang="ts">
	import Pagination from '$lib/core/core/frontend/helpers/components/Pagination.svelte';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import {
		language,
		site,
		siteUrl,
		origin,
		custom,
		templateType
	} from '$lib/core/shared/stores/site';
	import type { PageData } from './$types';
	import PostCard from './partials/PostCard.svelte';
	import { MetaTags } from 'svelte-meta-tags';

	$templateType = 'home';

	export let data: any;
</script>

<svelte:head>
	<!---->
</svelte:head>

{#await data}
	Loading...	
{:then data} 

	<MetaTags
		title={data.settings.site.title}
		titleTemplate={data.settings.site.description + ' | %s'}
		description={data.settings.site.description}
	/>
	<!-- The tag above means: insert everything in this file
	into the {body} of the default.hbs template -->

	<div
		class="site-header-content outer{$custom.header_style.default == 'Left aligned'
			? ' left-aligned'
			: ''}{$custom.show_publication_cover.default == false
			? $custom.header_style.default == 'Hidden'
				? ' no-content'
				: ''
			: ''}"
	>
		{#if $custom.show_publication_cover.default}
			{#if $site.cover_image}
				<div class="site-header-cover_wrapper">
					<!-- This is a responsive image, it loads different sizes depending on device
						https://medium.freecodecamp.org/a-guide-to-responsive-images-with-ready-to-use-templates-c400bd65c433 -->
					<img
						class="site-header-cover"
						srcset="{img_url($site.cover_image, ENUM_IMAGE_SIZE.S)} 300w,
								{img_url($site.cover_image, ENUM_IMAGE_SIZE.M)} 600w,
								{img_url($site.cover_image, ENUM_IMAGE_SIZE.L)} 1000w,
								{img_url($site.cover_image, ENUM_IMAGE_SIZE.XL)} 2000w"
						sizes="100vw"
						src={img_url($site.cover_image, ENUM_IMAGE_SIZE.XL)}
						alt={$site.title}
					/>
				</div>
			{/if}
		{/if}

		{#if $custom.header_style.default != 'Hidden'}
			<div class="site-header-inner inner">
				{#if $custom.navigation_layout.default == 'Logo on cover'}
					{#if $site.logo}
						<img class="site-logo" src={$site.logo} alt={$site.title} />
					{:else}
						<h1 class="site-title">{$site.title}</h1>
					{/if}
				{/if}
				{#if $site.description}
					<p class="site-description">{$site.description}</p>
				{/if}
			</div>
		{/if}
	</div>

	<!-- The main content area -->
	<main id="site-main" class="site-main outer">
		<div class="inner posts">
			<div class="post-feed">
				{#if data?.posts}
					{#each data?.posts as post, index}
						<!-- The tag below includes the markup for each post - partials/post-card.hbs -->
						<PostCard {post} {index} />
					{/each}
				{:else}
					No posts found...
				{/if}
			</div>

			<Pagination />
		</div>
	</main>
{/await}