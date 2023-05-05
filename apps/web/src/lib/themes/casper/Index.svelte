<script lang="ts">
	import Pagination from '$lib/core/core/frontend/helpers/components/Pagination.svelte';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import { templateType } from '$lib/core/shared/stores/site';
	import { afterUpdate, onMount } from 'svelte';
	import type { PageData } from './$types';
	import PostCard from './partials/PostCard.svelte';
	import { MetaTags } from 'svelte-meta-tags';
	import { page } from '$app/stores';

	export let site: any;
	export let posts: any;
	export let pagination: any;
	export let theme: any;

	$templateType = 'home';

	// export let data: PageData;
	// const {session, settings, theme} = data;
	// const {posts}
</script>

<svelte:head>
	<!---->
</svelte:head>

<MetaTags
	title={site.title}
	titleTemplate={site.description + ' | %s'}
	description={site.description}
/>
<!-- The tag above means: insert everything in this file
	into the {body} of the default.hbs template -->

<div
	class="site-header-content outer{theme.custom.header_style.default == 'Left aligned'
		? ' left-aligned'
		: ''}{theme.custom.show_publication_cover.default == false
		? theme.custom.header_style.default == 'Hidden'
			? ' no-content'
			: ''
		: ''}"
>
	{#if theme.custom.show_publication_cover.default}
		{#if site.cover_image}
			<div class="site-header-cover_wrapper">
				<!-- This is a responsive image, it loads different sizes depending on device
						https://medium.freecodecamp.org/a-guide-to-responsive-images-with-ready-to-use-templates-c400bd65c433 -->
				<img
					class="site-header-cover"
					srcset="{img_url(site.cover_image, ENUM_IMAGE_SIZE.S)} 300w,
								{img_url(site.cover_image, ENUM_IMAGE_SIZE.M)} 600w,
								{img_url(site.cover_image, ENUM_IMAGE_SIZE.L)} 1000w,
								{img_url(site.cover_image, ENUM_IMAGE_SIZE.XL)} 2000w"
					sizes="100vw"
					src={img_url(site.cover_image, ENUM_IMAGE_SIZE.XL)}
					alt={site.title}
				/>
			</div>
		{/if}
	{/if}

	{#if theme.custom.header_style.default != 'Hidden'}
		<div class="site-header-inner inner">
			{#if theme.custom.navigation_layout.default == 'Logo on cover'}
				{#if site.logo}
					<img class="site-logo" src={site.logo} alt={site.title} />
				{:else}
					<h1 class="site-title">{site.title}</h1>
				{/if}
			{/if}
			{#if site.description}
				<p class="site-description">{site.description}</p>
			{/if}
		</div>
	{/if}
</div>

<!-- The main content area -->
<main id="site-main" class="site-main outer">
	<div class="inner posts">
		<div class="post-feed">
			{#if posts}
				{#each posts as post, index}
					<!-- The tag below includes the markup for each post - partials/post-card.hbs -->
					<PostCard {post} {index} />
				{/each}
			{:else}
				No posts found...
			{/if}
		</div>
		<Pagination
			page={pagination.page}
			pages={pagination.totalPages}
			next={pagination.page < pagination.totalPages}
			page_url_next={`/page/${pagination.page + 1}`}
			prev={pagination.page - 1 > 0}
			page_url_prev={`/page/${pagination.page - 1}`}
		/>
	</div>
</main>
