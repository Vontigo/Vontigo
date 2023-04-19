<script lang="ts">
	import type { PageData } from '../$types';
	import Tag from '$lib/themes/casper/Tag.svelte';

	export let data: PageData;
</script>

<Tag {data} />
