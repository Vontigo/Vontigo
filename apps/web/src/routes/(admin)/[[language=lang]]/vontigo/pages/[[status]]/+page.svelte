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
	import { AppBar, AppShell, FileDropzone } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';
	import { adminSiteUrl, isEditorOpen, recordDataModal } from '$lib/core/shared/stores/site';
	import { goto } from '$app/navigation';
	import { format } from 'timeago.js';
	import CompPageEditor from '$lib/core/core/frontend/components/admin/Editor/CompPageEditor.svelte';
	import AutoResizableTextarea from '$lib/core/core/frontend/components/admin/Editor/components/AutoResizableTextarea.svelte';
	import RecordCreate from '$lib/core/core/frontend/components/admin/Database/RecordCreate.svelte';
	import { ENUM_DATABASE_TABLE } from '$lib/core/shared/enum';

	export let data: PageData;

	let selectedPost: any;
	let keysJson: string[];
	let isDrawerSidebar = true;
	// let dataSchema: any = {};

	let demoBinding = '';

	data.schema.forEach((value, key) => {
		$recordDataModal[value.key] = value;
	});

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	const createPageDrawer: DrawerSettings = {
		id: 'pageEditorDrawer',
		position: 'right',
		width: 'w-full lg:w-[100%]',
		height: 'h-full',
		// padding: 'p-4',
		// rounded: 'rounded',
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
					drawerStore.open(createPageDrawer);
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
				drawerStore.open(createPageDrawer);
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
	{#if data.posts.length > 0}
		<section class="view-container content-list">
			<ol class="posts-list v-list flex flex-col">
				<li class="v-list-row header grid grid-cols-4 uppercase text-xs border-b">
					<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-3">Title</div>
					<div class="v-list-header v-posts-status-header p-2 text-end">Status</div>
				</li>
				{#each data.posts as row, i}
					<li
						class="v-list-row v-posts-list-item grid grid-cols-4 border-b hover:bg-slate-100 {i ==
						data.posts.length - 1
							? ' border-b'
							: ''}"
					>
						<a
							href="#"
							class="ember-view permalink v-list-data v-post-list-title w-full py-4 col-span-3 w-full"
							on:click={() => {
								goto($adminSiteUrl + `/editor/${row.type}/${row.slug}`);
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
									By <span class="font-medium">{row.author_name}</span>
									{#if row.primary_tag_name}
										in
										<span class="font-medium">{row.primary_tag_name}</span>
									{/if}
									• <span data-tooltip={format(row.updated_at)}>{format(row.updated_at)}</span>
								</span>
							</p>
						</a>

						<a
							href="#"
							class="ember-view permalink v-list-data v-post-list-status px-2 py-6"
							on:click={() => {
								selectedPost = row;
								drawerStore.open(createPageDrawer);
							}}
						>
							<div class="grid justify-items-end w-full">
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
			<div class="infinity-loader reached-infinity py-10" />
		</section>
	{:else}
		<div class="w-full my-60 flex">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full m-auto text-center">No pages match the current filter</div>
				<a href={$adminSiteUrl + '/pages'} class="button text-center">Show all pages</a>
			</div>
		</div>
	{/if}
</div>

<Drawer>
	{#if $drawerStore.id === 'pageEditorDrawer'}
		<button
			class="absolute left-2 top-2 btn btn-sm variant-filled rounded"
			on:click={() => {
				selectedPost = {};
				drawerStore.close();
			}}
		>
			<span>
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-4 h-4"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"
					/>
				</svg>
			</span>
			<span>Back</span></button
		>
		<button
			class="absolute right-2 top-2 rounded border-none p-2"
			on:click={() => {
				isDrawerSidebar = !isDrawerSidebar;
			}}
		>
			{#if !isDrawerSidebar}
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12.75"
					/>
				</svg>
			{:else}
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15m3 0l3-3m0 0l-3-3m3 3H9"
					/>
				</svg>
			{/if}
		</button>
		<AppShell>
			<!-- <svelte:fragment slot="sidebarLeft">
				
			</svelte:fragment> -->
			<svelte:fragment slot="sidebarRight">
				{#if isDrawerSidebar}
					<div id="sidebar-right" class="hidden lg:block">
						<div class="card w-[350px] h-screen p-4 px-2">
							<header class="card-header text-lg font-medium">Page settings</header>
							<section class="p-4">
								<RecordCreate
									{data}
									table={ENUM_DATABASE_TABLE.posts}
									bind:dataModal={$recordDataModal}
								/>
							</section>
						</div>
					</div>
				{/if}
			</svelte:fragment>
			<!-- Router Slot -->
			<div class="max-w-screen-md m-auto py-14 flex flex-col gap-4">
				<div>
					<FileDropzone name="files">
						<svelte:fragment slot="lead">
							<div class="flex">
								<svg
									xmlns="http://www.w3.org/2000/svg"
									fill="none"
									viewBox="0 0 24 24"
									stroke-width="1.5"
									stroke="currentColor"
									class="w-20 h-20 m-auto"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z"
									/>
								</svg>
							</div>
						</svelte:fragment>
						<svelte:fragment slot="message">Add feature image</svelte:fragment>
						<svelte:fragment slot="meta">PNG, JPG are allowed.</svelte:fragment>
					</FileDropzone>
				</div>
				<div class="parent font-bold text-4xl">
					<AutoResizableTextarea
						bind:value={$recordDataModal.title.value}
						classes={'input border-none focus:border-none active:border-none rounded-none overflow-hidden'}
						placeholder={'Page title...'}
					/>
				</div>
				<CompPageEditor {data} bind:dataModal={$recordDataModal} />
			</div>
			<!-- ---- / ---- -->
		</AppShell>
	{/if}
</Drawer>
