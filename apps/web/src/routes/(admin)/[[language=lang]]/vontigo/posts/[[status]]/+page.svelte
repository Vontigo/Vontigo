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
	import { AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';
	import { adminSiteUrl, isEditorOpen } from '$lib/core/shared/stores/site';
	import { format } from 'timeago.js';

	export let data: PageData;
	let selectedPost: any;
	let keysJson: string[];

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	const settings: DrawerSettings = {
		id: 'postEditorDrawer',
		position: 'bottom',
		width: 'w-full lg:w-[740px]',
		// height: 'h-full',
		padding: 'p-4 justify-center',
		rounded: 'rounded-2xl',
		shadow: 'shadow-md',
		regionDrawer: 'overflow-y-hidden',
		bgDrawer: 'bg-white'
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
		<li class="crumb"><h2 class="text-xl font-bold py-1">Posts</h2></li>
		<li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">{$page.params.status || 'all status'}</li>
	</ol>

	<svelte:fragment slot="trail">
		<!-- <div class="w-full "> -->
		<div class="hidden md:flex md:flex-row-reverse w-full items-center gap-6">
			<button
				type="button"
				class="btn btn-sm variant-filled rounded"
				on:click={() => {
					selectedPost = null;
					drawerStore.open(settings);
				}}
			>
				<span><IconPlusSmall /></span>
				<span>New post</span>
			</button>
			<div class="filter-bar flex gap-4">
				<span><CompMenuPosts /></span>
				<!-- <span><CompMenuMembersAccess /></span> -->
				<span><CompMenuAuthors /></span>
				<span><CompMenuTags /></span>
				<span><CompMenuSortBy /></span>
			</div>
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
			<span>New post</span>
		</button>
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
	{#if data.posts.length > 0}
		<section class="view-container content-list">
			<ol class="posts-list v-list flex flex-col">
				<li class="v-list-row header flex gap-4 uppercase text-xs border-b">
					<div class="v-list-header v-posts-title-header w-full">Title</div>
					<div class="v-list-header v-posts-status-header">Status</div>
				</li>
				{#each data.posts as row, i}
					<li
						class="v-list-row v-posts-list-item flex gap-4 border-b py-4 hover:bg-slate-100 {i ==
						data.posts.length - 1
							? ' border-b'
							: ''}"
					>
						<a
							href="#"
							id="ember637"
							class="ember-view permalink v-list-data v-post-list-title w-full"
							on:click={() => {
								selectedPost = row;
								drawerStore.open(settings);
							}}
						>
							<h3
								class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide"
							>
								{row.title}
							</h3>
							<p>
								<span
									class="v-content-entry-meta unstyled text-xs font-light mt-1 text-slate-500 tracking-wide"
								>
									By <span class="font-medium">{row.author_name}</span> in
									<span class="font-medium">{row.primary_tag_name}</span>
									• <span data-tooltip={format(row.updated_at)}>{format(row.updated_at)}</span>
								</span>
							</p>
						</a>

						<a
							href="#/editor/post/644a1d60b49ab60001087355/"
							id="ember640"
							class="ember-view permalink v-list-data v-post-list-status p-2"
							on:click={() => {
								selectedPost = row;
								drawerStore.open(settings);
							}}
						>
							<div class="flex items-center">
								<span class="v-content-status-draft v-badge v-badge-pink nowrap">
									<span
										class="badge my-auto uppercase text-xs font-light pb-[1px] pt-[2px] px-3 {row.status ==
										'published'
											? 'variant-filled-success'
											: 'variant-filled-surface'}">{row.status}</span
									>
								</span>
							</div>
						</a>
					</li>
				{/each}
			</ol>
			<div class="infinity-loader reached-infinity py-40" />
		</section>
	{:else}
		<div class="w-full flex my-60">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full h-full m-auto text-center">No posts match the current filter</div>
				<a href={$adminSiteUrl + '/posts'} class="button text-center">Show all posts</a>
			</div>
		</div>
	{/if}
</div>

<style global>
	.drawer-backdrop .drawer {
		height: calc(100vh - 2rem);
	}
</style>
