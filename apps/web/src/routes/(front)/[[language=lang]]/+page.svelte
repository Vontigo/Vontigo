<script lang="ts">
	import type { PageServerData } from './$types';
	import { page } from '$app/stores';
	import Index from '$lib/themes/casper/Index.svelte';
	import { onMount } from 'svelte';

	export let data: PageServerData;
</script>

{#if data.posts.items}
	<Index
		site={data.settings.site}
		posts={data.posts.items}
		pagination={data.posts.pagination}
		theme={data.theme}
	/>
{/if}
