<script>
	import RecordCreate from '$lib/core/core/frontend/components/admin/Database/RecordCreate.svelte';
	import { STORE_ADMIN_SITE_URL } from '$lib/core/shared/stores/site';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';

	import { AppBar } from '@skeletonlabs/skeleton';
</script>

<div class="max-w-screen-xl mx-auto px-12">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
		<h2 class="text-xl font-bold">Tags</h2>
		<!-- <span class="text-xs uppercase font-semibold">{$page.params.status || 'all status'}</span> -->
		<svelte:fragment slot="trail">
			<!-- <div class="w-full "> -->
			<div class="hidden md:flex md:flex-row-reverse w-full items-center gap-6">
				<button
					type="button"
					class="btn btn-sm variant-filled rounded"
					on:click={() => {
						goto($STORE_ADMIN_SITE_URL + `/tags/new`);
					}}
				>
					<span><IconPlusSmall /></span>
					<span>New tag</span>
				</button>
				<div class="filter-bar flex gap-4" />
			</div>
			<button
				type="button"
				class="md:hidden btn btn-sm variant-filled rounded"
				on:click={() => {
					selectedPost = {};
					drawerStore.open(settings);
				}}
			>
				<span><IconPlusSmall /></span>
				<span>New tag</span>
			</button>
			<!-- </div> -->
		</svelte:fragment>

		<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
	</AppBar>
	<div class="p-4">
		<h6>Basic Settings</h6>
	</div>
</div>
