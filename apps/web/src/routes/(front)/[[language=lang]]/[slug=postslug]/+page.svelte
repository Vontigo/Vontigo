<script lang="ts">
	import type { PageData } from './$types';
	import Post from '$lib/themes/casper/Post.svelte';
	import Page from '$lib/themes/casper/Page.svelte';
	import { page } from '$app/stores';
	import { ENUM_POST_TYPE } from '$lib/core/shared/enum';
	import Product from '$lib/themes/casper/Product.svelte';

	export let data: PageData;
	console.log(data);
</script>

{#if data}
	{#if data.post.content.type == ENUM_POST_TYPE.post}
		<Post {data} />
	{:else if data.post.content.type == ENUM_POST_TYPE.page}
		<Page {data} />
	{:else if data.post.content.type == ENUM_POST_TYPE.product}
		<Product {data} />
	{/if}
{/if}
