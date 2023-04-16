<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { language, siteUrl, tenant } from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/conts';
	import Fire from '$lib/themes/casper/partials/icons/fire.svelte';
	import Post from '$lib/themes/casper/Post.svelte';
	import Page from '$lib/themes/casper/Page.svelte';

	export let data: PageData;
	let post = data.post;
	let postUrl = $siteUrl + '/' + post.slug;
	let origin = '/content/' + $tenant.replace(':', '_') + '/' + $language;
</script>

{#if post}
	{#if post.type = 'post'}
		<Post {post} />
	{:else if post.type = 'page'}
		<Page {post} />
	{/if}
{/if}
