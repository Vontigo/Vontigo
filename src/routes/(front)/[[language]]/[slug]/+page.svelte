<script lang="ts">
	import type { PageData } from './$types';

	export let data: PageData;
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>
{@debug data}
{#if data.post}
	<h1>{data.post.title}</h1>
{/if}
