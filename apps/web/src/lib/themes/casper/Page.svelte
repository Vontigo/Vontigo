<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { language, siteUrl, origin, templateType } from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import IconFire from './partials/icons/IconFire.svelte';

	$templateType = 'page';
	export let data: PageData;
	let post = data.post.content;
	let authors = data.post.authors;
	//console.log(authors);
</script>

<!-- The tag above means: insert everything in this file
into the {body} tag of the default.hbs template -->

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
							srcset="{img_url($origin, post.feature_image, ENUM_IMAGE_SIZE.S)} 300w,
                    {img_url($origin, post.feature_image, ENUM_IMAGE_SIZE.M)} 600w,
                    {img_url($origin, post.feature_image, ENUM_IMAGE_SIZE.L)} 1000w,
                    {img_url($origin, post.feature_image, ENUM_IMAGE_SIZE.XL)} 2000w"
							sizes="(min-width: 1400px) 1400px, 92vw"
							src={img_url($origin, post.feature_image, ENUM_IMAGE_SIZE.XL)}
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
