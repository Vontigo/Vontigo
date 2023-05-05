<script lang="ts">
	import type { PageData } from '../$types';
	import Tag from '$lib/themes/casper/Tag.svelte';

	export let data: PageData;
</script>

<Tag
	site={data.settings.site}
	tag={data.result.tag}
	posts={data.result.posts.items}
	pagination={data.result.posts.pagination}
	theme={data.theme}
/>
