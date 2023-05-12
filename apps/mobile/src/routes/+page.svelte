<script lang="ts">
	import { onMount } from 'svelte';
	let posts: any;
	onMount(async () => {
		const res = await fetch('https://localhost:5173/api/content/posts/page/10/1');
		posts = await res.json();
		console.log(posts);
	});
</script>

<div class="font-bold">Posts:</div>
<ul class="p-4">
	{#if posts}
		{#each posts.items as item}
			<li class="py-4">
				<a class="" href={`/${item.slug}`}>{item.title}</a>
			</li>
		{/each}
	{/if}
</ul>
