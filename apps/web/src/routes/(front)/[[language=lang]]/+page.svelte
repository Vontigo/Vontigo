<script lang="ts">
	import type { PageData } from './$types';
	import { page } from '$app/stores';
	import Index from '$lib/themes/casper/Index.svelte';

	export let data: PageData;
</script>
{#await data}
	Loading...
{:then data} 
	<Index {data} />
{/await}
