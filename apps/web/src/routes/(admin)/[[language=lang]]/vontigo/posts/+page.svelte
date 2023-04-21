<script lang="ts">
	import CompMenuAuthors from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuAuthors.svelte';
	import CompMenuMembersAccess from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuMembersAccess.svelte';
	import CompMenuPosts from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuPosts.svelte';
	import CompMenuSortBy from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuSortBy.svelte';
	import CompMenuTags from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuTags.svelte';
	import CompEditor from '$lib/core/core/frontend/components/admin/Editor/CompEditor.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';

	const settings: DrawerSettings = {
		id: 'postEditorDrawer',
		position: 'right',
		width: 'w-full lg:w-[80%]',
		padding: 'p-4',
		rounded: 'rounded-xl',
		shadow: 'shadow-md'
	};
</script>

<div class="max-w-screen-xl mx-auto">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
		<h3 class="font-bold">Posts</h3>
		<svelte:fragment slot="trail">
			<!-- <div class="w-full "> -->
			<div class="flex flex-row-reverse w-full items-center">
				<button
					type="button"
					class="btn btn-sm variant-filled rounded"
					on:click={() => {
						drawerStore.open(settings);
					}}
				>
					<span><IconPlusSmall /></span>
					<span>New post</span>
				</button>
				<span><CompMenuPosts /></span>
				<span><CompMenuMembersAccess /></span>
				<span><CompMenuAuthors /></span>
				<span><CompMenuTags /></span>
				<span><CompMenuSortBy /></span>
			</div>
			<!-- </div> -->
		</svelte:fragment>

		<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
	</AppBar>
	<Drawer>
		<div class="">
			{#if $drawerStore.id === 'postEditorDrawer'}
				<CompEditor />
			{/if}
		</div>
	</Drawer>

	All
</div>
