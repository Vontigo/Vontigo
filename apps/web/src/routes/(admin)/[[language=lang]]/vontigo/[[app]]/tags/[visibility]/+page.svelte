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
	import type { PageData } from '../[type]/[slug]/$types';
	import { STORE_ADMIN_SITE_URL, isEditorOpen } from '$lib/core/shared/stores/site';
	import { goto } from '$app/navigation';
	import ObjectID from 'bson-objectid';

	export let data: PageData;
	let selectedPost: any;
	let keysJson: string[];
	let newTagBody = {
		id: new ObjectID(),
		name: '',
		slug: '',
		created_at: '',
		created_by: 1
	};

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	const settings: DrawerSettings = {
		id: 'tagEditorDrawer',
		position: 'right',
		width: 'w-full lg:w-[300px]',
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
	<!-- <h2 class="text-xl font-bold">Tags</h2> -->
	<!-- <span class="text-xs uppercase font-semibold">{$page.params.status || 'all status'}</span> -->

	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold mb-1">Tags</h2></li>
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
<div class="max-w-screen-xl mx-auto px-12">
	<Drawer>
		{#if $drawerStore.id === 'tagEditorDrawer'}
			<div class="p-4">
				<div class="flex">
					<h6 class="w-full font-bold">New Tag</h6>
					<div class="text-right">
						<button
							type="button"
							class="btn btn-sm variant-filled rounded"
							on:click={async () => {
								newTagBody.created_at = new Date().toISOString().slice(0, 16);
								const requestOptions = {
									method: 'POST',
									headers: { 'Content-Type': 'application/json' },
									body: JSON.stringify(newTagBody)
								};
								const response = await fetch(`/api/database/tags/create`, requestOptions);
								const resJson = await response.json();
								if (resJson.row) {
									drawerStore.close();
									goto(
										$STORE_ADMIN_SITE_URL + `/tags/${$page.params.visibility}/${resJson.row.slug}`
									);
								}
							}}
						>
							Save
						</button>
					</div>
				</div>
				<div class="py-4 flex flex-col gap-4">
					<div class="flex flex-col gap-2">
						<div>Name</div>
						<div>
							<input
								type="text"
								class="input p-2"
								bind:value={newTagBody.name}
								on:input={async () => {
									//newTagBody.slug = await convertToAsciiSlug(newTagBody.name);
								}}
								on:change={async () => {
									//newTagBody.slug = await createUniqueSlug(newTagBody.name);
									const response = await fetch(`/api/admin/slugs/tags/${newTagBody.name}`);
									const resJson = await response.json();
									// console.log(resJson);

									newTagBody.slug = resJson?.slugs[0]?.slug;
								}}
							/>
						</div>
					</div>
					<div class="flex flex-col gap-2">
						<div>Slug</div>
						<div><input type="text" class="input p-2" bind:value={newTagBody.slug} /></div>
					</div>
				</div>
			</div>
		{/if}
	</Drawer>
	{#if data.records.length > 0}
		<section class="view-container content-list">
			<ol class="posts-list v-list flex flex-col">
				<li class="v-list-row header grid grid-cols-5 uppercase text-xs border-b">
					<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-3">Name</div>
					<div class="v-list-header v-posts-status-header py-2">Slug</div>
					<div class="v-list-header v-posts-status-header p-2 text-end">No. of post</div>
				</li>
				{#each data.records as row, i}
					<li
						class="v-list-row v-posts-list-item grid grid-cols-5 border-b hover:bg-secondary-500/20 {i ==
						data.records.length - 1
							? ' border-b'
							: ''}"
					>
						<a
							href={$STORE_ADMIN_SITE_URL + `/tags/${$page.params.visibility}/${row.slug}`}
							class="ember-view permalink v-list-data v-post-list-title w-full py-4 col-span-3 w-full"
						>
							<h3
								class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide"
							>
								{row.name}
							</h3>
						</a>
						<a
							href={$STORE_ADMIN_SITE_URL + `/tags/${$page.params.visibility}/${row.slug}`}
							class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full text-sm tracking-wide font-light"
						>
							{row.slug}
						</a>

						<a
							href={$STORE_ADMIN_SITE_URL + `/tags/${$page.params.visibility}/${row.slug}`}
							class="ember-view permalink v-list-data v-post-list-status px-2 py-4"
							on:click={() => {
								selectedPost = row;
								drawerStore.open(settings);
							}}
						>
							<div class="grid justify-items-end w-full text-sm font-light">
								{row.total_posts} post{row.total_posts > 1 ? 's' : ''}
							</div>
						</a>
					</li>
				{/each}
			</ol>
			<div class="infinity-loader reached-infinity py-10" />
		</section>
	{:else}
		<div class="w-full flex my-60">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full h-full m-auto text-center">No tags found</div>
			</div>
		</div>
	{/if}
</div>
