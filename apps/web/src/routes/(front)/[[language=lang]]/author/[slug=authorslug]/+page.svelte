<script lang="ts">
	import type { PageData } from '../$types';
	import Author from '$lib/themes/casper/Author.svelte';

	export let data: PageData;
</script>

<Author {data} />
