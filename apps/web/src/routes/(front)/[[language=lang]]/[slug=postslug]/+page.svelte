<script lang="ts">
	import type { PageData } from './$types';
	import Post from '$lib/themes/casper/Post.svelte';
	import Page from '$lib/themes/casper/Page.svelte';
	import { page } from '$app/stores';

	export let data: PageData;
	//console.log(data);
</script>

{#if data}
	{#if data.post.content.type == 'post'}
		<Post {data} />
	{:else if data.post.content.type == 'page'}
		<Page {data} />
	{/if}
{/if}
