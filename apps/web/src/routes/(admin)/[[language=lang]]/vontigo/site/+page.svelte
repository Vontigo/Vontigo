<script lang="ts">
	import { page } from '$app/stores';
	import { siteUrl } from '$lib/core/shared/stores/site';

	let frame;
	function onLoad() {
		const head = frame.contentDocument.querySelector('head');
		console.log(head);
	}
</script>

<iframe bind:this={frame} src={$page.url.origin} title="preview" class="w-full h-full" />
