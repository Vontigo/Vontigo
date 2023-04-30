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
	import { adminSiteUrl, isEditorOpen, recordDataModal } from '$lib/core/shared/stores/site';
	import { format } from 'timeago.js';
	import RecordCreate from '$lib/core/core/frontend/components/admin/Database/RecordCreate.svelte';
	import AutoResizableTextarea from '$lib/core/core/frontend/components/admin/Editor/components/AutoResizableTextarea.svelte';
	import CompPostEditor from '$lib/core/core/frontend/components/admin/Editor/CompPostEditor.svelte';
	import { ENUM_DATABASE_TABLE } from '$lib/core/shared/enum';
	import ObjectID from 'bson-objectid';
	import { onMount } from 'svelte';
	import CompTagsInput from '$lib/core/core/frontend/components/admin/TagsInput/CompTagsInput.svelte';
	import CompAuthorsInput from '$lib/core/core/frontend/components/admin/TagsInput/CompAuthorsInput.svelte';

	export let data: PageData;
	let selectedPost: any;
	let keysJson: string[];
	let isDrawerSidebar = true;

	onMount(async () => {});

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	const createPageDrawer: DrawerSettings = {
		id: 'postEditorDrawer',
		position: 'right',
		width: 'w-full lg:w-[100%]',
		height: 'h-full',
		// padding: 'p-4',
		// rounded: 'rounded',
		shadow: 'shadow-md',
		regionDrawer: 'overflow-y-hidden'
	};
	async function openDrawer(id: string = '') {
		const resPostsSchema = await fetch(`/api/admin/posts/post/new/${id}`);
		const dataPostsSchema = await resPostsSchema.json();
		dataPostsSchema.forEach((value, key) => {
			$recordDataModal[value.key] = value;
		});
		// await getPostsTags($recordDataModal.id.value);
		drawerStore.open(createPageDrawer);
	}
	async function closeDrawer() {
		// taglist = [];
		$recordDataModal = {};
		drawerStore.close();
	}

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
					openDrawer();
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
				openDrawer();
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
								openDrawer(row.id);
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
								openDrawer(row.id);
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
		<div class="w-full flex my-60">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full h-full m-auto text-center">No posts match the current filter</div>
				<a href={$adminSiteUrl + '/posts'} class="button text-center">Show all posts</a>
			</div>
		</div>
	{/if}
</div>

<Drawer>
	{#if $drawerStore.id === 'postEditorDrawer'}
		<button
			class="absolute left-2 top-2 btn btn-sm variant-filled rounded"
			on:click={() => {
				closeDrawer();
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
				<div id="sidebar-right" class="hidden lg:{isDrawerSidebar ? 'block' : 'hidden'}">
					<div class="card w-[350px] h-screen p-4 px-2">
						<header class="card-header text-lg font-medium">Post settings</header>
						<section class="p-4 pb-20">
							<RecordCreate
								{data}
								table={ENUM_DATABASE_TABLE.posts}
								bind:dataModal={$recordDataModal}
							/>

							<div
								class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full capitalize md:grid-cols-1 col-span-2 md:pb-0 flex flex-col gap-4"
							>
								<h3
									class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide flex gap-2"
								>
									Tags
								</h3>
								<CompTagsInput postId={$recordDataModal.id.value} />
							</div>
							<div
								class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full capitalize md:grid-cols-1 col-span-2 md:pb-0 flex flex-col gap-4"
							>
								<h3
									class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide flex gap-2"
								>
									Authors
								</h3>
								<CompAuthorsInput postId={$recordDataModal.id.value} />
							</div>
						</section>
					</div>
				</div>
			</svelte:fragment>
			<!-- Router Slot -->
			<div class="max-w-screen-md m-auto py-14 flex flex-col gap-4">
				<div>
					<img src={$recordDataModal.feature_image.value} class="w-full" alt="" />
				</div>
				<div class="parent font-bold text-4xl">
					<AutoResizableTextarea
						bind:value={$recordDataModal.title.value}
						classes={'input border-none focus:border-none active:border-none rounded-xl overflow-hidden bg-white'}
						placeholder={'Page title...'}
					/>
				</div>
				<div class="mb-20">
					<CompPostEditor {data} bind:dataModal={$recordDataModal} />
				</div>
			</div>
			<!-- ---- / ---- -->
		</AppShell>
	{/if}
</Drawer>
