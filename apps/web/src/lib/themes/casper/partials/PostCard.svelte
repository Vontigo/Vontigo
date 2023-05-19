<script lang="ts">
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import {
		language,
		siteUrl,
		origin,
		site,
		theme,
		templateType,
		access
	} from '$lib/core/shared/stores/site';
	import IconFire from './icons/IconFire.svelte';
	import { page } from '$app/stores';
	import IconLock from './icons/IconLock.svelte';
	import { readingTime } from '$lib/core/core/frontend/helpers/readingTime';

	export let post: any;
	export let index: number;

	let postUrl = $siteUrl + '/' + post.slug;
	let post_class = '';
	// if (post.visibility != 'public') {
	// 	$access = true;
	// }

	if ($theme.custom.feed_layout.default == 'Classic') {
		if ($templateType == 'home') {
			if (index == 0) {
				post_class += ' post-card-large';
			} else if (index == 1 || index == 2) {
				post_class += ' dynamic';
			}
		}
	} else if ($theme.custom.feed_layout.default == 'Grid') {
		post_class += ' keep-ratio';
	} else if ($theme.custom.feed_layout.default == 'List') {
		if ($templateType == 'home' || $templateType == 'paged') {
			post_class += ' post-card-large';
		}
	}
	// if ($access == false) {
	// 	post_class += ` post-access-${post.visibility}`;
	// }

	// let postFeatureImage =
	// 	'/content/' + $tenant.replace(':', '_') + '/' + $language + '/images' + post.feature_image;
</script>

<!-- This is a partial file used to generate a post "card"
which templates loop over to generate a list of posts. -->

<article class="post-card {post_class}">
	{#if post.feature_image}
		<a class="post-card-image-link" href={postUrl}>
			<!-- This is a responsive image, it loads different sizes depending on device
        https://medium.freecodecamp.org/a-guide-to-responsive-images-with-ready-to-use-templates-c400bd65c433 -->
			<img
				class="post-card-image"
				srcset="{img_url(post.feature_image, ENUM_IMAGE_SIZE.S)} 300w,
                    {img_url(post.feature_image, ENUM_IMAGE_SIZE.M)} 600w,
                    {img_url(post.feature_image, ENUM_IMAGE_SIZE.L)} 1000w,
                    {img_url(post.feature_image, ENUM_IMAGE_SIZE.XL)} 2000w"
				sizes="(max-width: 1000px) 400px, 800px"
				src={img_url(post.feature_image, ENUM_IMAGE_SIZE.S)}
				alt={post.title}
				loading="lazy"
			/>
			{#if $access == false}
				{#if post.visibility != 'public'}
					<div class="post-card-access">
						<IconLock />
						{#if post.visibility == 'members'}
							Members only
						{:else}
							Paid-members only
						{/if}
					</div>
				{/if}
			{/if}
		</a>
	{/if}

	<div class="post-card-content">
		<a class="post-card-content-link" href={postUrl}>
			<header class="post-card-header">
				<div class="post-card-tags">
					{#if post.primary_tag}
						<span class="post-card-primary-tag">{post.primary_tag_name}</span>
					{/if}
					{#if post.featured}
						<span class="post-card-featured"><IconFire /> Featured</span>
					{/if}
				</div>
				<h2 class="post-card-title">
					{#if $access == true}
						{#if post.visibility != 'public'}
							{#if post.feature_image}
								<IconLock />
							{/if}
						{/if}
					{/if}
					{post.title}
				</h2>
			</header>
			{#if $access == false}
				{#if post.visibility == 'public'}
					{#if post.custom_excerpt}
						<div class="post-card-excerpt">{post.custom_excerpt}</div>
					{/if}
				{/if}
			{/if}
		</a>

		<footer class="post-card-meta">
			<time class="post-card-meta-date" datetime={post.published_at}>
				{new Date(post.published_at).toLocaleDateString($language, {
					weekday: 'long',
					year: 'numeric',
					month: 'short',
					day: 'numeric'
				})}
			</time>
			<!-- {#if post.reading_time} -->
			<span class="post-card-meta-length">{readingTime(post?.html)}</span>
			<!-- {/if} -->
			{#if $site.comments_enabled}
				{post.comment_count}
			{/if}
		</footer>
	</div>
</article>
