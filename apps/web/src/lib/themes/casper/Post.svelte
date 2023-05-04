<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import {
		templateType,
		site,
		access,theme
	} from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import IconFire from './partials/icons/IconFire.svelte';
	import IconAvatar from './partials/icons/IconAvatar.svelte';
	import { post_class } from '$lib/core/core/frontend/helpers/postClass';
	import { MetaTags } from 'svelte-meta-tags';

	$templateType = 'post';
	export let data: PageData;
	let post = data.post.content;
	let authors = data.post.authors;
	// console.log(authors);
</script>

{#if post}
	<MetaTags
		title={data.settings.site.title}
		titleTemplate={post.title + ' | %s'}
		description={post.description}
	/>
	<!-- Everything inside the #post block pulls data from the post -->

	<main id="site-main" class="site-main">
		<article
			class="article {post_class(
				post
			)} {`#match @custom.post_image_style "Full"`}image-full{`else match @custom.post_image_style "=" "Small"`}image-small{`/match`}"
		>
			<header class="article-header gh-canvas">
				<div class="article-tag post-card-tags">
					{#if post.primary_tag}
						<span class="post-card-primary-tag">
							<a href={'tag' + '/' + post.primary_tag_slug}>{post.primary_tag_name}</a>
						</span>
					{/if}
					{#if post.featured}
						<span class="post-card-featured"><IconFire /> Featured</span>
					{/if}
				</div>

				<h1 class="article-title">{post.title}</h1>

				{#if $access == false}
					{#if post.visibility == 'public'}
						{#if post.custom_excerpt}
							<p class="article-excerpt">{post.custom_excerpt}</p>
						{/if}
					{/if}
				{/if}

				<div class="article-byline">
					<section class="article-byline-content">
						<ul class="author-list">
							{#each authors as author}
								<li class="author-list-item">
									{#if author.profile_image}
										<a href={`/author/` + author.slug} class="author-avatar">
											<img
												class="author-profile-image"
												src={author.profile_image}
												alt={author.name}
											/>
										</a>
									{:else}
										<a href={`url`} class="author-avatar author-profile-image">
											<IconAvatar />
										</a>
									{/if}
								</li>
							{/each}
						</ul>
						{#if authors.length > 0}
							<div class="article-byline-meta">
								<h4 class="author-name">{authors[0].name}</h4>
								<div class="byline-meta-content">
									<time class="byline-meta-date" datetime={post.published_at}
										>{post.published_at}</time
									>
									{#if post.reading_time}
										<span class="byline-reading-time"
											><span class="bull">&bull;</span> {post.reading_time}</span
										>
									{/if}
								</div>
							</div>
						{/if}
					</section>
				</div>

				{#if $theme.custom.post_image_style != 'Hidden'}
					{#if post.feature_image}
						<figure class="article-image">
							<!-- This is a responsive image, it loads different sizes depending on device
                https://medium.freecodecamp.org/a-guide-to-responsive-images-with-ready-to-use-templates-c400bd65c433 -->

							<img
								srcset="{img_url(post.feature_image, ENUM_IMAGE_SIZE.S)} 300w,
                    {img_url(post.feature_image, ENUM_IMAGE_SIZE.M)} 600w,
                    {img_url(post.feature_image, ENUM_IMAGE_SIZE.L)} 1000w,
                    {img_url(post.feature_image, ENUM_IMAGE_SIZE.XL)} 2000w"
								sizes="(min-width: 1400px) 1400px, 92vw"
								src={img_url(post.feature_image, ENUM_IMAGE_SIZE.XL)}
								loading="lazy"
							/>
							{#if post.feature_image_caption}
								<figcaption>{post.feature_image_caption}</figcaption>
							{/if}
						</figure>
					{/if}
				{/if}
			</header>

			{#if $access == false}
				{#if post.visibility == 'public'}
					<section class="gh-content gh-canvas">
						{@html post.html}
					</section>
				{/if}
			{/if}

			{#if post.comments}
				<section class="article-comments gh-canvas">
					{post.comments}
				</section>
			{/if}
		</article>
	</main>

	<!-- A signup call to action is displayed here, unless viewed as a logged-in member -->
	{#if $site.members_enabled}
		<!-- {`#unless @member`}
{`#unless @site.comments_enabled`}
{#if access}
    <section class="footer-cta outer">
        <div class="inner">
            {#if @custom.email_signup_text}<h2 class="footer-cta-title">{`@custom.email_signup_text`}</h2>{/if}
            <a class="footer-cta-button" href="#/portal" data-portal>
                <div class="footer-cta-input">Enter your email</div>
                <span>Subscribe</span>
            </a>
        </div>
    </section>
{/if}
{`/unless`}
{`/unless`} -->
	{/if}

	<!-- Read more links, just above the footer -->
	<!--{#if @custom.show_recent_posts_footer}
     The {#get} helper below fetches some of the latest posts here
    so that people have something else to read when they finish this one.

    This query gets the latest 3 posts on the site, but adds a filter to
    exclude the post we're currently on from being included. -->
	<!--    {`#get "posts" filter="id:-{`id`}" limit="3" as |more_posts|`}

        {#if more_posts}
            <aside class="read-more-wrap outer">
                <div class="read-more inner">
                    {`#foreach more_posts`}
                        {`> "post-card"`}
                    {`/foreach`}
                </div>
            </aside>
        {/if}

    {`/get`} -->
{/if}
