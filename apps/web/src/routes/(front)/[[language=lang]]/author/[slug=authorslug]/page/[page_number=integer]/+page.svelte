<script lang="ts">
	import type { PageData } from '../$types';
	import Author from '$lib/themes/casper/Author.svelte';

	export let data: PageData;
</script>

<Author
	site={data.settings.site}
	author={data.result.author}
	posts={data.result.posts.items}
	pagination={data.result.posts.pagination}
	theme={data.theme}
/>
