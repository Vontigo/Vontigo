<script lang="ts">
	import type { PageData } from './$types';
	import { page } from '$app/stores';
	import Default from '$lib/themes/casper/Default.svelte';

	export let data: PageData;
</script>

<Default {data} />
