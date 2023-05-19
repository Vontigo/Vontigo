<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { templateType } from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import IconFire from './partials/icons/IconFire.svelte';
	import { page } from '$app/stores';

	$templateType = 'page';
	export let data: PageData;
	let post = data.post.content;
	let authors = data.post.authors;
	//console.log(authors);
</script>

<!-- The tag above means: insert everything in this file
into the {body} tag of the default.hbs template -->

<svelte:head>
	<meta property="og:site_name" content={$page.data.settings.site.title} />
	<meta property="og:type" content="article" />
	<meta property="og:title" content={post.title} />
	<meta property="og:description" content={post.description} />
	<meta property="og:url" content={$page.url} />
	<meta property="og:image" content={$page.url.origin + post.feature_image} />
	<meta property="article:published_time" content={post.published_at} />
	<meta property="article:modified_time" content={post.updated_at} />
	<meta property="article:tag" content={post.primary_tag} />

	<meta property="article:publisher" content={$page.data.settings.site.facebook} />
	<meta property="article:author" content={$page.data.settings.site.facebook} />
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:title" content={post.title} />
	<meta name="twitter:description" content={post.description} />
	<meta name="twitter:url" content={$page.url} />
	<meta name="twitter:image" content={$page.url.origin + post.feature_image} />
	<meta name="twitter:label1" content="Written by" />
	<meta name="twitter:data1" content={authors.length > 0 ? authors[0]?.name : ''} />
	<meta name="twitter:label2" content="Filed under" />
	<meta name="twitter:data2" content={post.primary_tag} />
	<meta name="twitter:site" content={$page.data.settings.site.twitter} />
	<meta name="twitter:creator" content={$page.data.settings.site.twitter} />
	<meta property="og:image:width" content="2000" />
	<meta property="og:image:height" content="1100" />

	{@html ` <script type="application/ld+json">
		{
			"@context": "https://schema.org",
			"@type": "Article",
			"publisher": {
				"@type": "Organization",
				"name": "${$page.data.settings.site.title}",
				"url": "${$page.url.origin}",
				"logo": {
					"@type": "ImageObject",
					"url": "${$page.url.origin + $page.data.settings.site.logo}",
					"width": 60,
					"height": 60
				}
			},
			"author": {
				"@type": "Person",
				"name": "${authors.length > 0 ? authors[0]?.name : ''}",
				"image": {
					"@type": "ImageObject",
					"url": "${authors.length > 0 ? authors[0]?.profile_image : ''}",
					"width": 240,
					"height": 240
				},
				"url": "${$page.url.origin + '/author/' + (authors.length > 0 ? authors[0]?.slug : '')}",
				"sameAs": [
					"${$page.url.origin}",
					"${$page.data.settings.site.facebook}",
					"${$page.data.settings.site.twitter}"
				]
			},
			"headline": "${post.title}",
			"url": "${$page.url}",
			"datePublished": "${post.published_at}",
			"dateModified": "${post.updated_at}",
			"image": {
				"@type": "ImageObject",
				"url": "${$page.url.origin + post.feature_image}",
				"width": 2000,
				"height": 1100
			},
			"keywords": "${post.primary_tag}",
			"description": "${post.description}",
			"mainEntityOfPage": "${$page.url}"
		}
			</script>`}

	{@html $page.data.settings.site.codeinjection_head}
</svelte:head>

{#if post}
	<!-- Everything inside the #post block pulls data from the page -->

	<main id="site-main" class="site-main">
		<article class="article {`post_class`}">
			<header class="article-header gh-canvas">
				<h1 class="article-title">{post.title}</h1>

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
							src={img_url(post.feature_image, ENUM_IMAGE_SIZE.S)}
							loading="lazy"
						/>
						{#if post.feature_image_caption}
							<figcaption>{post.feature_image_caption}</figcaption>
						{/if}
					</figure>
				{/if}
			</header>

			<section class="gh-content gh-canvas">
				{@html post.html}
			</section>
		</article>
	</main>
{/if}
