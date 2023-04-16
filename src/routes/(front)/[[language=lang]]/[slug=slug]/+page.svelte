<script lang="ts">
	import type { PageData } from './$types';
	import Post from '$lib/themes/casper/Post.svelte';
	import Page from '$lib/themes/casper/Page.svelte';

	export let data: PageData;
	let post = data.post;
</script>

{#if post}
	{#if post.type = 'post'}
		<Post {post} />
	{:else if post.type = 'page'}
		<Page {post} />
	{/if}
{/if}
