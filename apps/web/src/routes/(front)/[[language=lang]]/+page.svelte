<script lang="ts">
	import type { PageData } from './$types';
	import { page } from '$app/stores';
	import Index from '$lib/themes/casper/Index.svelte';

	export let data: PageData;
</script>

<Index {data} />
