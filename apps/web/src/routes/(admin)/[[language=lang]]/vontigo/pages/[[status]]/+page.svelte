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
	import { goto } from '$app/navigation';
	import { format } from 'timeago.js';

	export let data: PageData;

	let selectedPost: any;
	let keysJson: string[];

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	const settings: DrawerSettings = {
		id: 'pageEditorDrawer',
		position: 'right',
		width: 'w-full lg:w-[100%]',
		height: 'h-full',
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
		<li class="crumb"><h2 class="text-xl font-bold py-1">Pages</h2></li>
		<!-- <li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">{$page.params.status || 'all status'}</li> -->
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
				<span>New page</span>
			</button>
			<div class="filter-bar flex gap-4">
				<span><CompMenuPosts /></span>
				<span><CompMenuMembersAccess /></span>
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
			<span>New page</span>
		</button>
		<!-- </div> -->
	</svelte:fragment>

	<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
</AppBar>
<div class="max-w-screen-xl mx-auto px-12">
	<Drawer>
		{#if $drawerStore.id === 'pageEditorDrawer'}
			<AppShell>
				<svelte:fragment slot="sidebarLeft">
					<div class="border-s min-w-full">as dfasdfasdfasdfasd fasd fsadf sdf</div>
				</svelte:fragment>
				<svelte:fragment slot="sidebarRight">
					<div class="border-s">
						<div class="w-[30%]" />
					</div>
				</svelte:fragment>
				<!-- Router Slot -->
				<div class="max-w-screen-md m-auto">
					<CompEditor postData={selectedPost} />
				</div>
				<!-- ---- / ---- -->
			</AppShell>
		{/if}
	</Drawer>

	{#if data.posts.length > 0}
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
							<th class="w-1 uppercase text-right">Status</th>
							<th class="w-24" />
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
										goto($adminSiteUrl + `/editor/${row.type}/${row.slug}`);
									}}
								>
									<p class="unstyled text-sm font-medium antialiased tracking-wide">{row.title}</p>
									<p class="unstyled text-xs mt-1 text-slate-500">
										By <span class="font-semibold">{row.author_name}</span> •
										<span>{format(row.updated_at)}</span>
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
								<td
									class="cursor-pointer text-end"
									on:click={() => {
										selectedPost = row;
										drawerStore.open(settings);
									}}
								>
									Edit
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
		<div class="w-full my-60 flex">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full m-auto text-center">No pages match the current filter</div>
				<a href={$adminSiteUrl + '/pages'} class="button text-center">Show all pages</a>
			</div>
		</div>
	{/if}
</div>

<style global>
	/* .drawer-backdrop .drawer {
		height: calc(100vh - 2rem);
	} */
</style>
