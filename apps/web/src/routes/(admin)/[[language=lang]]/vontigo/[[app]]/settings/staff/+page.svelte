<script lang="ts">
	import { page } from '$app/stores';
	import CompMenuAuthors from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuAuthors.svelte';
	import CompMenuMembersAccess from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuMembersAccess.svelte';
	import CompMenuPosts from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuPosts.svelte';
	import CompMenuSortBy from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuSortBy.svelte';
	import CompMenuTags from '$lib/core/core/frontend/components/admin/CompMenu/CompMenuTags.svelte';
	import CompEditor from '$lib/core/core/frontend/components/admin/Editor/CompEditor.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { AppBar, AppShell, Avatar, filter } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';
	import { STORE_ADMIN_SITE_URL, isEditorOpen } from '$lib/core/shared/stores/site';
	import { goto } from '$app/navigation';
	import CompGravatar from '$lib/core/core/frontend/components/shared/CompGravatar/CompGravatar.svelte';
	export let data: PageData;
	let selectedPost: any;
	let keysJson: string[];

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	const settings: DrawerSettings = {
		id: 'postEditorDrawer',
		position: 'right',
		width: 'w-full lg:w-[80%]',
		// height: 'h-full',
		padding: 'p-4',
		rounded: 'rounded-xl',
		shadow: 'shadow-md',
		regionDrawer: 'overflow-y-hidden'
	};

	$: if (selectedPost) {
		selectedPost = selectedPost;
	}
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold mb-1">Staff</h2></li>
	</ol>
	<!-- <span class="text-xs uppercase font-semibold">{$page.params.status || 'all status'}</span> -->
	<svelte:fragment slot="trail">
		<!-- <div class="w-full "> -->
		<!-- <div class="hidden md:flex md:flex-row-reverse w-full items-center gap-6">
				<button
					type="button"
					class="btn btn-sm variant-filled rounded"
					on:click={() => {
						selectedPost = null;
						drawerStore.open(settings);
					}}
				>
					<span><IconPlusSmall /></span>
					<span>Invite people</span>
				</button>
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
				<span>Invite people</span>
			</button> -->
		<!-- </div> -->
	</svelte:fragment>

	<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
</AppBar>
<div class="max-w-screen-xl mx-auto px-12">
	<Drawer>
		{#if $drawerStore.id === 'postEditorDrawer'}
			<CompEditor postData={selectedPost} />
		{/if}
	</Drawer>
	{#if data.records.length > 0}
		<section class="view-container content-list">
			<ol class="posts-list v-list flex flex-col">
				<li class="v-list-row header grid grid-cols-5 uppercase text-xs border-b">
					<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-3">
						ACTIVE USERS
					</div>
					<!-- <div class="v-list-header v-posts-status-header py-2">Slug</div>
					<div class="v-list-header v-posts-status-header p-2 text-end">No. of post</div> -->
				</li>
				{#each data.records as row, i}
					<li
						class="v-list-row v-posts-list-item grid grid-cols-5 border-b hover:bg-secondary-500/20 {i ==
						data.records.length - 1
							? ' border-b'
							: ''}"
					>
						<a
							href={$STORE_ADMIN_SITE_URL + `/settings/staff/${row.slug}`}
							class="ember-view permalink v-list-data v-post-list-title w-full py-4 col-span-4 flex gap-4"
						>
							{#if row.profile_image}
								<Avatar
									src={row.profile_image}
									action={filter}
									actionParams="#Apollo"
									width="w-10 h-10"
								/>
							{:else}
								<CompGravatar email={row.email} size={32} default="robohash" class="rounded-full" />
							{/if}
							<div>
								<p class="unstyled text-sm font-medium antialiased tracking-wide">
									{row.name}
								</p>
								<p class="unstyled text-xs mt-1">
									<span>{row.email}</span>
								</p>
							</div>
						</a>
						<div class=" m-auto">
							<span
								class="badge uppercase text-xs font-light pb-[1px] pt-[2px] px-3 {row.status ==
								'published'
									? 'variant-filled-success'
									: 'variant-filled-surface'}"
							>
								{row.role_name}
							</span>
						</div>
					</li>
				{/each}
			</ol>
			<div class="infinity-loader reached-infinity py-10" />
		</section>
	{:else}
		<div class="w-full justify-center">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full h-full m-auto text-center">No posts match the current filter</div>
				<a href={$STORE_ADMIN_SITE_URL + '/posts/page/1'} class="btn">Show all posts</a>
			</div>
		</div>
	{/if}
</div>

<style lang="postcss">
	.table thead th,
	.table tbody tr td {
		@apply px-2;
	}
</style>
