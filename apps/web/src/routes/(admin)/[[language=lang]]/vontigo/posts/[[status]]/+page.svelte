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

<div class="max-w-screen-xl mx-auto px-10 py-2 h-full">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
		<h2 class="text-xl font-bold">Posts</h2>
		<span class="text-xs uppercase font-semibold">{$page.params.status || 'all status'}</span>
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

	<Drawer>
		{#if $drawerStore.id === 'postEditorDrawer'}
			<CompEditor postData={selectedPost} />
		{/if}
	</Drawer>
	{#if data.posts.length > 0}
		<div class="postsList">
			<!-- Responsive Container (recommended) -->
			<div class="table-container rounded-none w-full">
				<!-- Native Table Element -->
				<table class="table table-hover table-compact">
					<thead>
						<tr>
							<!-- {#if keysJson}
							{#each keysJson as column}
								<th class="table-cell-fit">{column}</th>
							{/each}
						{/if} -->
							<th class="uppercase">Title</th>
							<th class="w-1 uppercase text-right">Status</th>
							<!-- <th>Symbol</th>
						<th>Weight</th> -->
						</tr>
					</thead>
					<tbody>
						{#each data.posts as row, i}
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
										selectedPost = row;
										drawerStore.open(settings);
									}}
								>
									<p class="unstyled text-sm font-medium antialiased tracking-wide">{row.title}</p>
									<p class="unstyled text-xs mt-1 text-slate-400">
										By <span class="font-semibold">{row.author_name}</span> in <span class="font-semibold">{row.primary_tag_name}</span> • <span>{format(row.updated_at)}</span>
									</p>
								</td>
								<td>
									<span
										class="badge uppercase text-xs font-light pb-[1px] pt-[2px] px-3 {row.status ==
										'published'
											? 'variant-filled-success'
											: 'variant-filled-surface'}">{row.status}</span
									>
								</td>
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
		<div class="w-full h-[80%] flex">
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
