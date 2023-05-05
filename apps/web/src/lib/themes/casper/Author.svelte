<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { templateType } from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import IconFire from './partials/icons/IconFire.svelte';
	import IconAvatar from './partials/icons/IconAvatar.svelte';
	import Post from './Post.svelte';
	import PostCard from './partials/PostCard.svelte';
	import IconTwitter from './partials/icons/IconTwitter.svelte';
	import IconFacebook from './partials/icons/IconFacebook.svelte';
	import Pagination from '$lib/core/core/frontend/helpers/components/Pagination.svelte';

	$templateType = 'author';

	// export let data: PageData;
	export let site: any;
	export let author: any;
	export let posts: any;
	export let pagination: any;
	export let theme: any;
	// let author = data.author.content;
	// console.log(data.author.posts);
</script>

<!-- The tag above means - insert everything in this file into the {body} of the default.hbs template -->
<main id="site-main" class="site-main outer">
	<div class="inner posts">
		<div class="post-feed">
			{#if author}
				<section class="post-card post-card-large">
					{#if author.cover_image}
						<div class="post-card-image-link">
							<!-- This is a responsive image, it loads different sizes depending on device
                https://medium.freecodecamp.org/a-guide-to-responsive-images-with-ready-to-use-templates-c400bd65c433 -->
							<img
								srcset="{img_url(author.cover_image, ENUM_IMAGE_SIZE.S)} 300w,
            {img_url(author.cover_image, ENUM_IMAGE_SIZE.M)} 600w,
            {img_url(author.cover_image, ENUM_IMAGE_SIZE.L)} 1000w,
            {img_url(author.cover_image, ENUM_IMAGE_SIZE.XL)} 2000w"
								sizes="(max-width: 1000px) 400px, 800px"
								src={img_url(author.cover_image, ENUM_IMAGE_SIZE.XL)}
								alt={author.title}
							/>
						</div>
					{/if}

					<div class="post-card-content">
						<div class="post-card-content-link">
							{#if author.profile_image}
								<img class="author-profile-pic" src={author.profile_image} alt={author.name} />
							{/if}

							<header class="post-card-header">
								<h2 class="post-card-title">{author.name}</h2>
							</header>

							{#if author.bio}
								<div class="post-card-excerpt">{author.bio}</div>
							{/if}

							<footer class="author-profile-footer">
								{#if author.location}
									<div class="author-profile-location">{author.location}</div>
								{/if}
								<div class="author-profile-meta">
									{#if author.website}
										<a
											class="author-profile-social-link"
											href={author.website}
											target="_blank"
											rel="noopener">{author.website}</a
										>
									{/if}
									{#if author.twitter}
										<a
											class="author-profile-social-link"
											href={author.twitter_url}
											target="_blank"
											rel="noopener"><IconTwitter /></a
										>
									{/if}
									{#if author.facebook}
										<a
											class="author-profile-social-link"
											href={author.facebook_url}
											target="_blank"
											rel="noopener"><IconFacebook /></a
										>
									{/if}
								</div>
							</footer>
						</div>
					</div>
				</section>
			{/if}

			{#each posts as post, index}
				<PostCard {post} {index} />
			{/each}
		</div>

		<Pagination
			page={pagination.page}
			pages={pagination.totalPages}
			next={pagination.page < pagination.totalPages}
			page_url_next={`/author/${author.slug}/page/${pagination.page + 1}`}
			prev={pagination.page - 1 > 0}
			page_url_prev={`/author/${author.slug}/page/${pagination.page - 1}`}
		/>
	</div>
</main>
