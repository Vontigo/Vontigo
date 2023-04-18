<script lang="ts">
	import CompMenuAuthors from '$lib/components/CompMenuAuthors.svelte';
	import CompMenuMembersAccess from '$lib/components/CompMenuMembersAccess.svelte';
	import CompMenuPosts from '$lib/components/CompMenuPosts.svelte';
	import CompMenuSortBy from '$lib/components/CompMenuSortBy.svelte';
	import CompMenuTags from '$lib/components/CompMenuTags.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';

	const settings: DrawerSettings = {
		id: 'postEditorDrawer',
		position: 'right',
		width: 'w-[80%]',
		padding: 'p-4',
		rounded: 'rounded-xl'
	};
</script>

<div class="max-w-screen-lg mx-auto">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
		<h3 class="font-bold">Posts</h3>
		<svelte:fragment slot="trail">
			<div class="w-full text-end">
				<CompMenuPosts />
				<CompMenuMembersAccess />
				<CompMenuAuthors />
				<CompMenuTags />
				<CompMenuSortBy />
				<button
					type="button"
					class="btn btn-sm variant-filled rounded"
					on:click={() => {
						drawerStore.open(settings);
					}}
				>
					<!-- <span><IconPlusSmall /></span> -->
					<span>New post</span>
				</button>
			</div>
		</svelte:fragment>

		<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
	</AppBar>
	<Drawer>
		<div class="p-4">
			{#if $drawerStore.id === 'postEditorDrawer'}
				Editor
			{/if}
		</div>
	</Drawer>

	All
</div>
