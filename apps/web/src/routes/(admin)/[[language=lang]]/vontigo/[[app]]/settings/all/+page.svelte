<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
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
	import type { PageData } from '../$types';
	import { STORE_ADMIN_SITE_URL, isEditorOpen } from '$lib/core/shared/stores/site';
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

<div class="max-w-screen-xl mx-auto px-12">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
		<h2 class="text-xl font-bold">Settings</h2>
		<span>{$page.params.status || ''}</span>
		<svelte:fragment slot="trail">
			<!-- <div class="w-full "> -->
			<div class="hidden md:flex md:flex-row-reverse w-full items-center gap-6">
				<!--<button
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
					<span><CompMenuMembersAccess /></span>
					<span><CompMenuAuthors /></span>
					<span><CompMenuTags /></span>
					<span><CompMenuSortBy /></span>
				</div> -->
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
						<th class="uppercase">Group</th>
						<th class="w-1 uppercase text-right">Status</th>
						<!-- <th>Symbol</th>
						<th>Weight</th> -->
					</tr>
				</thead>
				<tbody>
					{#each data.settings as row, i}
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
									goto($STORE_ADMIN_SITE_URL + `/settings/${row.group}`);
								}}
							>
								<p class="unstyled text-sm font-medium antialiased tracking-wide uppercase">
									{row.group}
								</p>
								<!-- <p class="unstyled text-xs mt-1 text-slate-500">
									<span>By {row.created_by}</span> • <span>{row.updated_at}</span>
								</p> -->
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
</div>
