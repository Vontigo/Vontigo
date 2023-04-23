<script>
	import { AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
</script>

<div class="max-w-screen-xl mx-auto">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<h3 class="font-bold">Dashboard</h3>
	</AppBar>
	{JSON.stringify($page.data.session)}
</div>
