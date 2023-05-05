<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { language, siteUrl, origin, templateType } from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import IconFire from './partials/icons/IconFire.svelte';
	import IconAvatar from './partials/icons/IconAvatar.svelte';
	import Post from './Post.svelte';
	import PostCard from './partials/PostCard.svelte';
	import Pagination from '$lib/core/core/frontend/helpers/components/Pagination.svelte';
	import { page } from '$app/stores';

	$templateType = 'tag';

	// export let data: PageData;
	export let site: any;
	export let tag: any;
	export let posts: any;
	export let pagination: any;
	export let theme: any;
	// let tag = data.result.tag;
	// console.log(data);
</script>

<!-- The tag above means - insert everything in this file into the {body} of the default.hbs template -->

<main id="site-main" class="site-main outer">
	<div class="inner posts">
		<div class="post-feed">
			{#if tag}
				<section class="post-card post-card-large">
					{#if tag.feature_image}
						<div class="post-card-image-link">
							<!-- This is a responsive image, it loads different sizes depending on device
                https://medium.freecodecamp.org/a-guide-to-responsive-images-with-ready-to-use-templates-c400bd65c433 -->
							<img
								class="post-card-image"
								srcset="{img_url(tag.feature_image, ENUM_IMAGE_SIZE.S)} 300w,
                                        {img_url(tag.feature_image, ENUM_IMAGE_SIZE.M)} 600w,
                                        {img_url(tag.feature_image, ENUM_IMAGE_SIZE.L)} 1000w,
                                        {img_url(tag.feature_image, ENUM_IMAGE_SIZE.XL)} 2000w"
								sizes="(max-width: 1000px) 400px, 800px"
								src={img_url(tag.feature_image, ENUM_IMAGE_SIZE.XL)}
								alt={tag.title}
							/>
						</div>
					{/if}

					<div class="post-card-content">
						<div class="post-card-content-link">
							<header class="post-card-header">
								<h2 class="post-card-title">{tag.name}</h2>
							</header>
							<div class="post-card-excerpt">
								{#if tag.description}
									{tag.description}
								{:else}
									A collection of {pagination.totalRows > 0
										? pagination.totalRows + ` posts`
										: `zero posts`}.
								{/if}
							</div>
						</div>
					</div>
				</section>
			{/if}

			{#each posts as post, index}
				<!-- The tag below includes the markup for each post - partials/post-card.hbs -->
				<PostCard {post} {index} />
			{/each}
		</div>

		<Pagination
			page={pagination.page}
			pages={pagination.totalPages}
			next={pagination.page < pagination.totalPages}
			page_url_next={`/tag/${tag.slug}/page/${pagination.page + 1}`}
			prev={pagination.page - 1 > 0}
			page_url_prev={`/tag/${tag.slug}/page/${pagination.page - 1}`}
		/>
	</div>
</main>
