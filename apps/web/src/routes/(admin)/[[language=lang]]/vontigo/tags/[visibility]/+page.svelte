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
	import { adminSiteUrl, isEditorOpen } from '$lib/core/shared/stores/site';
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
		width: 'w-full lg:w-[400px]',
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

<div class="max-w-screen-xl mx-auto px-12 h-full">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
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

	<Drawer>
		{#if $drawerStore.id === 'tagEditorDrawer'}
			<div class="p-4">
				<div class="flex">
					<h3 class="w-full">New Tag</h3>
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
									goto($adminSiteUrl + `/tags/${$page.params.visibility}/${resJson.row.slug}`);
								}
							}}>Save</button
						>
					</div>
				</div>
				<div class="py-4 flex flex-col gap-2">
					<div>
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
									console.log(resJson);

									newTagBody.slug = resJson?.slugs[0]?.slug;
								}}
							/>
						</div>
					</div>
					<div>
						<div>Slug</div>
						<div><input type="text" class="input p-2" bind:value={newTagBody.slug} /></div>
					</div>
				</div>
			</div>
		{/if}
	</Drawer>
	{#if data.tags.length > 0}
		<div class="postsList">
			<!-- Responsive Container (recommended) -->
			<div class="table-container rounded-none w-full">
				<!-- Native Table Element -->
				<table class="table table-hover">
					<thead>
						<tr>
							<!-- {#if keysJson}
							{#each keysJson as column}
								<th class="table-cell-fit">{column}</th>
							{/each}
						{/if} -->
							<th class="uppercase">Title</th>
							<th class="w-40 uppercase">Slug</th>
							<th class="w-40 uppercase text-right">No. Of Posts</th>
							<!-- <th>Symbol</th>
						<th>Weight</th> -->
						</tr>
					</thead>
					<tbody>
						{#each data.tags as row, i}
							<!-- <tr>
							{#if keysJson}
								{#each keysJson as column}
									<td>{row[column]}</td>
								{/each}
							{/if}</tr
						> -->
							<tr>
								<!-- svelte-ignore a11y-click-events-have-key-events -->
								<td
									class="cursor-pointer"
									on:click={() => {
										goto($adminSiteUrl + `/tags/${$page.params.visibility}/${row.slug}`);
									}}
								>
									<p class="unstyled text-sm font-medium antialiased tracking-wide">{row.name}</p>
								</td>
								<td>{row.slug}</td>
								<td class="text-end"> {row.total_posts} post{row.total_posts > 1 ? 's' : ''} </td>
							</tr>
						{/each}
					</tbody>
					<!-- <tfoot>
					<tr>
						<th colspan="2">Calculated Total Weight</th>
						<td>{data.posts.length}</td>
					</tr>
				</tfoot> -->
				</table>
			</div>
		</div>
	{:else}
		<div class="w-full justify-center h-[80%] flex">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full h-full m-auto text-center">No tags found</div>
			</div>
		</div>
	{/if}
</div>

<style global>
	.drawer-backdrop .drawer {
		height: calc(100vh - 2rem);
	}
</style>
