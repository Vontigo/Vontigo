<script lang="ts">
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	let post: any;
	onMount(async () => {
		const res = await fetch(`https://localhost:5173/api/content/posts/${$page.params.slug}`);
		post = await res.json();
		console.log(post);
	});
</script>

<a class="btn" href="/">Back</a>
<div class="p-4">
	{#if post}
		<!-- {JSON.stringify(post)} -->
		<h1 class="font-bold text-xl pb-8">{post.content.title}</h1>
		<div>
			{@html post.content.html}
		</div>
	{/if}
</div>
