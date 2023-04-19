<script lang="ts">
	import type { PageData } from './$types';
	import Post from '$lib/themes/casper/Post.svelte';
	import Page from '$lib/themes/casper/Page.svelte';
	import { page } from '$app/stores';

	export let data: PageData;
	let post = data.post;
</script>

{#if post}
	{#if post.content.type == 'post'}
		<Post {post} />
	{:else if post.content.type == 'page'}
		<Page {post} />
	{/if}
{/if}
