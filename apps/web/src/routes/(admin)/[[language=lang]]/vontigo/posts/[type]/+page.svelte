<script>
	// import { page } from '$app/stores';
	import { AppBar, AppShell } from '@skeletonlabs/skeleton';
	export let data;
</script>

<div class="max-w-screen-xl mx-auto">
	<AppBar class="sticky top-0 z-10 p-4">
		<h3 class="font-bold">Posts | {data.type}</h3>
	</AppBar>
</div>
