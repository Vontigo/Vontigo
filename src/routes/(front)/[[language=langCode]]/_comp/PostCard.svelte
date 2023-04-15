<script lang="ts">
	import { ENUM_IMAGE_SIZE } from '$lib/core/conts';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { language, siteUrl, tenant } from '$lib/stores/site';

	export let post: any;
	let postUrl = $siteUrl + '/' + post.slug;
	let imgOrigin = '/content/' + $tenant.replace(':', '_') + '/' + $language;
	// let postFeatureImage =
	// 	'/content/' + $tenant.replace(':', '_') + '/' + $language + '/images' + post.image;
</script>

<!-- This is a partial file used to generate a post "card"
which templates loop over to generate a list of posts. -->

<article
	class="post-card {`post_class`}{`#match @custom.feed_layout "Classic"`}{`#is "home"`}{`#has index="0"`} post-card-large{`/has`}{`#has index="1,2"`} dynamic{`/has`}{`/is`}{`/match`}{`#match @custom.feed_layout "Grid"`} keep-ratio{`/match`}{`#match @custom.feed_layout "List"`}{`#is "home, paged"`} post-card-large{`/is`}{`/match`}{`#unless access`} post-access-{`visibility`}{`/unless`}"
>
	{#if post.image}
		<a class="post-card-image-link" href={postUrl}>
			<!-- This is a responsive image, it loads different sizes depending on device
        https://medium.freecodecamp.org/a-guide-to-responsive-images-with-ready-to-use-templates-c400bd65c433 -->
			<img
				class="post-card-image"
				srcset="{img_url(imgOrigin, post.image, ENUM_IMAGE_SIZE.S)} 300w,
                    {img_url(imgOrigin, post.image, ENUM_IMAGE_SIZE.M)} 600w,
                    {img_url(imgOrigin, post.image, ENUM_IMAGE_SIZE.L)} 1000w,
                    {img_url(imgOrigin, post.image, ENUM_IMAGE_SIZE.XL)} 2000w"
				sizes="(max-width: 1000px) 400px, 800px"
				src={img_url(imgOrigin, post.image, ENUM_IMAGE_SIZE.M)}
				loading="lazy"
			/>

			<!-- {`#unless access`}
			{`^has visibility="public"`}
			<div class="post-card-access">
				{`> "icons/lock"`}
				{`#has visibility="members"`}
				Members only
				{`else`}
				Paid-members only
				{`/has`}
			</div>
			{`/has`}
			{`/unless`} -->
		</a>
	{/if}

	<div class="post-card-content">
		<a class="post-card-content-link" href={postUrl}>
			<header class="post-card-header">
				<div class="post-card-tags">
					{`#primary_tag`}
					<span class="post-card-primary-tag">{`name`}</span>
					{`/primary_tag`}
					{#if post.featured}
						<span class="post-card-featured">{`> "icons/fire"`} Featured</span>
					{/if}
				</div>
				<h2 class="post-card-title">
					<!-- {`#unless access`}
					{`^has visibility="public"`}
					{`#unless feature_image`}
					{`> "icons/lock"`}
					{`/unless`}
					{`/has`}
					{`/unless`}
					{`title`} -->
					{post.title}
				</h2>
			</header>
			{#if post.excerpt}
				<div class="post-card-excerpt">{`excerpt`}</div>
			{/if}
		</a>

		<footer class="post-card-meta">
			<time class="post-card-meta-date" datetime={`date format="YYYY-MM-DD"`}>{`date`}</time>
			{#if post.reading_time}
				<span class="post-card-meta-length">{`reading_time`}</span>
			{/if}
			<!-- {#if @site.comments_enabled}
			{`comment_count`}
			{/if} -->
		</footer>
	</div>
</article>
