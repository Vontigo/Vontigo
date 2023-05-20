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
	import {
		AppBar,
		AppShell,
		Avatar,
		ProgressRadial,
		modalStore,
		toastStore
	} from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';
	import {
		STORE_ADMIN_SITE_URL,
		autoSaveCountDown,
		isEditorOpen,
		recordPostsDataModal,
		wordsCount
	} from '$lib/core/shared/stores/site';
	import { format } from 'timeago.js';
	import RecordCreate from '$lib/core/core/frontend/components/admin/Database/RecordCreate.svelte';
	import AutoResizableTextarea from '$lib/core/core/frontend/components/admin/Editor/components/AutoResizableTextarea.svelte';
	import CompPostEditor from '$lib/core/core/frontend/components/admin/Editor/CompPostEditor.svelte';
	import { ENUM_DATABASE_TABLE, ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';
	import ObjectID from 'bson-objectid';
	import { onMount } from 'svelte';
	import CompTagsInput from '$lib/core/core/frontend/components/admin/TagsInput/CompTagsInput.svelte';
	import CompAuthorsInput from '$lib/core/core/frontend/components/admin/TagsInput/CompAuthorsInput.svelte';
	import { fade } from 'svelte/transition';
	import Pagination from '$lib/core/core/frontend/helpers/components/Pagination.svelte';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';

	export let data: PageData;

	// console.log(data.brainiacminds);

	// let selectedPost: any;
	// let keysJson: string[];
	let isDrawerSidebar = true;
	let lastPosition: number;
	let showBackbutton = true;
	let showChatGPTButton = true;
	let generatingContent = false;
	let _compPostEditor: any;
	let aimResJson: any;

	onMount(async () => {});

	async function chatGPT() {
		if ($recordPostsDataModal.title.value != `Your new post is here...`) {
			//https://vontigo.services.brainiacminds.com/beta/sveltekit/js%20framworks/svelte
			const aimRes = await fetch(
				`/api/admin/3rd/brainiacminds/${$recordPostsDataModal.title.value}`
			);

			aimResJson = await aimRes.json();

			console.log('_________1', aimResJson);

			if (aimResJson?.brainiacminds?.Choices[0]?.Message?.Content) {
				$recordPostsDataModal.mobiledoc.value = await aimResJson?.brainiacminds?.Choices[0]?.Message
					?.Content;

				_compPostEditor.updateContent();

				toastStore.trigger({
					message: 'AI content generated!',
					timeout: 2000,
					background: 'variant-filled-success'
				});
			} else {
				toastStore.trigger({
					message: 'No content generated!',
					timeout: 2000,
					background: 'variant-filled-warning'
				});
			}
			generatingContent = false;
		} else {
			toastStore.trigger({
				message: 'Please ensure you has input your title idea!',
				timeout: 2000,
				background: 'variant-filled-warning'
			});
			generatingContent = false;
		}
	}

	let isDrawerDataReady: boolean = false;

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
		isDrawerDataReady = false;
		drawerStore.open(createPageDrawer);
		generatingContent = false;
		const resPostsSchema = await fetch(`/api/admin/posts/${$page.params.type}/new/${id}`);
		const dataPostsSchema = await resPostsSchema.json();
		if (dataPostsSchema) {
			dataPostsSchema.forEach((value, key) => {
				$recordPostsDataModal[value.key] = value;
			});
			isDrawerDataReady = true;
		}
		// console.log(dataPostsSchema);
	}

	async function closeDrawer() {
		// taglist = [];
		$recordPostsDataModal = {};
		drawerStore.close();
		await updateList();
	}

	async function updateList() {
		const response = await fetch(
			`/api/admin/posts/${$page.params.type}/${
				$page.params.status != 'drafts' ? $page.params.status : 'draft'
			}/page/${$page.params.page_number}`
		);
		const posts = await response.json();
		data.posts = posts;
	}

	// $: if (selectedPost) {
	// 	selectedPost = selectedPost;
	// }
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<!-- <svelte:fragment slot="lead">
		<Icon3BottomLeft />
	</svelte:fragment> -->
	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold py-1 capitalize">{$page.params.type}s</h2></li>
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
				<!-- <span><CompMenuPosts /></span> -->
				<!-- <span><CompMenuMembersAccess /></span> -->
				<!-- <span><CompMenuAuthors /></span> -->
				<!-- <span><CompMenuTags /></span> -->
				<!-- <span><CompMenuSortBy /></span> -->
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
	{#if data.posts.items.length > 0}
		<section class="view-container content-list">
			<ol class="posts-list v-list flex flex-col">
				<li class="v-list-row header grid grid-cols-4 uppercase text-xs border-b">
					<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-3">Title</div>
					<!-- <div class="v-list-header v-posts-status-header p-2 text-end" /> -->
					<div class="v-list-header v-posts-status-header p-2 text-end">Status</div>
				</li>
				{#each data.posts.items as row, i}
					<li
						class="v-list-row v-posts-list-item grid grid-cols-5 border-b hover:bg-secondary-500/20 {i ==
						data.posts.length - 1
							? ' border-b'
							: ''}"
					>
						<a
							href="#"
							class="ember-view permalink v-list-data v-post-list-title w-full py-5 col-span-3 w-full"
							on:click={() => {
								openDrawer(row.id);
							}}
						>
							<h3
								class="v-content-entry-title unstyled text-sm font-semibold antialiased tracking-wider"
							>
								{row.title}
							</h3>
							<p>
								<span class="v-content-entry-meta unstyled text-xs font-light mt-1 tracking-wide">
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
							class="ember-view permalink v-list-data v-post-list-title w-full m-auto grid justify-items-end w-full"
							on:click={() => {
								openDrawer(row.id);
							}}
						>
							{#if row?.feature_image}
								<Avatar
									src={img_url(row?.feature_image, ENUM_IMAGE_SIZE.XS)}
									width="w-12"
									rounded="rounded"
								/>
								<!-- <img src={img_url(row?.feature_image, ENUM_IMAGE_SIZE.XS)} /> -->
							{/if}
						</a>
						<a
							href="#"
							class="ember-view permalink v-list-data v-post-list-status px-2 py-6 my-auto"
							on:click={() => {
								openDrawer(row.id);
							}}
						>
							<div class="grid justify-items-end w-full">
								<span class="v-content-status-draft v-badge v-badge-pink nowrap">
									<span
										class="badge m-auto uppercase text-xs font-light pb-[1px] pt-[2px] px-3 {row.status ==
										'published'
											? 'variant-filled-success'
											: 'variant-filled-surface'}"
									>
										<span> {row.status}</span>
									</span>
								</span>
							</div>
						</a>
					</li>
				{/each}
			</ol>

			<div class="text-sm py-4 text-end">
				<Pagination
					page={data.posts.pagination.page}
					pages={data.posts.pagination.totalPages}
					next={data.posts.pagination.page < data.posts.pagination.totalPages}
					next_title={'Next'}
					page_url_next={`/vontigo/posts/post/page/${data.posts.pagination.page + 1}`}
					prev={data.posts.pagination.page - 1 > 0}
					prev_title={'Previous'}
					page_url_prev={`/vontigo/posts/post/page/${data.posts.pagination.page - 1}`}
				/>
			</div>
			<!-- <div class="infinity-loader reached-infinity p-2 py-4">Loading more..</div> -->
		</section>
	{:else}
		<div class="w-full flex my-60">
			<div class="flex flex-col w-2/4 m-auto">
				<div class="w-full h-full m-auto text-center">No posts match the current filter</div>
				<a
					href={`${$STORE_ADMIN_SITE_URL}/posts/${$page.params.type}/page/1`}
					class="button text-center">Show all posts</a
				>
			</div>
		</div>
	{/if}
</div>

<Drawer>
	{#if $drawerStore.id === 'postEditorDrawer'}
		{#if showBackbutton}
			<button
				class="absolute left-2 top-3 btn btn-sm border-none bg-white hover:variant-filled rounded z-10 shadow-md cursor-pointer"
				transition:fade
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
				<span>Back</span>
			</button>
		{/if}

		<button
			class="absolute right-2 top-2 rounded border-none p-2 z-10"
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
					class="w-6 h-6 stroke-black dark:stroke-white"
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
					class="w-6 h-6 stroke-black dark:stroke-white"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15m3 0l3-3m0 0l-3-3m3 3H9"
					/>
				</svg>
			{/if}
		</button>
		<AppShell
			regionPage="relative"
			slotPageFooter="sticky bottom-0 z-10"
			on:scroll={(e) => {
				if (e.target && e.target.scrollTop > 0) {
					if (lastPosition > e.target.scrollTop) {
						showBackbutton = true;
						showChatGPTButton = true;
					} else {
						showBackbutton = false;
						showChatGPTButton = false;
					}
					lastPosition = e.target.scrollTop;
				}
			}}
		>
			<svelte:fragment slot="pageHeader">
				<div class="sticky top-0">
					<div class=" w-full h-16 flex flex-row-reverse py-2 text-neutral-500 m-auto">
						{#if showChatGPTButton}
							<button
								transition:fade
								class="right-0 mr-10 btn border-none p-2 bg-white hover:variant-filled rounded z-20 shadow-md"
								on:click={async () => {
									generatingContent = true;
									await chatGPT();
								}}
							>
								{#if generatingContent}
									<span class="w-6 h-6">
										<ProgressRadial value={undefined} class="h-6 w-6 hover:" />
									</span>
									<span>Generating content ..</span>
								{:else}
									<span class="w-6 h-6">
										<img src="/brainiacminds-logo.png" title="BrainiacMinds" class="w-6 h-6" />
									</span>
									<span>BrainiacMinds</span>
								{/if}
							</button>
						{/if}
						{#if $autoSaveCountDown > 0}
							<div class="flex flex-row-reverse my-auto gap-2 mr-2">
								<ProgressRadial
									width="w-6"
									stroke={100}
									meter="stroke-primary-500"
									track="stroke-primary-500/30"
								/> Auto save after {$autoSaveCountDown / 1000}s
							</div>
						{/if}
					</div>
				</div>
			</svelte:fragment>
			<!-- <svelte:fragment slot="sidebarLeft">
				
			</svelte:fragment> -->
			<svelte:fragment slot="sidebarRight">
				{#if isDrawerDataReady}
					<div id="sidebar-right" class="hidden lg:{isDrawerSidebar ? 'block' : 'hidden'}">
						<div class="card w-[350px] h-full p-4 px-2">
							<header class="card-header text-lg font-medium">Post settings</header>
							<section class="p-4 pb-20">
								<RecordCreate
									{data}
									table={ENUM_DATABASE_TABLE.posts}
									bind:dataModal={$recordPostsDataModal}
								/>

								<div
									class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full capitalize md:grid-cols-1 col-span-2 md:pb-0 flex flex-col gap-2 border-b"
								>
									<h3
										class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide flex gap-2"
									>
										Tags
									</h3>
									<div class="pb-4">
										<CompTagsInput postId={$recordPostsDataModal.id.value} />
									</div>
								</div>
								<div
									class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full capitalize md:grid-cols-1 col-span-2 md:pb-0 flex flex-col gap-2 border-b"
								>
									<h3
										class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide flex gap-2"
									>
										Authors
									</h3>
									<div class="pb-4">
										<CompAuthorsInput postId={$recordPostsDataModal.id.value} />
									</div>
								</div>
								<div class="py-4 text-end">
									<button
										class="btn variant-filled-primary border-none"
										on:click={async () => {
											modalStore.trigger({
												type: 'confirm',
												// Data
												title: 'Please Confirm',
												body: 'Are you sure you wish to proceed?',
												// TRUE if confirm pressed, FALSE if cancel pressed
												response: async (r) => {
													if (r) {
														const requestOptions = {
															method: 'PUT',
															headers: { 'Content-Type': 'application/json' },
															body: JSON.stringify({
																body: $recordPostsDataModal.feature_image.value
															})
														};

														const resData = await fetch(`/api/admin/file/delete`, requestOptions);

														const delReq = await fetch(
															`/api/database/posts/remove/${$recordPostsDataModal.id.value}`
														);
														closeDrawer();
														// console.log(delReq);
													}
												}
											});
										}}
									>
										<span
											><svg
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
													d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0"
												/>
											</svg>
										</span>
										<span>Delete {$page.params.type}</span>
									</button>
								</div>
							</section>
						</div>
					</div>
				{/if}
			</svelte:fragment>
			<!-- Router Slot -->
			<slot>
				{#if isDrawerDataReady}
					<div id="editorBodySection" class="relative">
						<div class="max-w-screen-md m-auto flex flex-col gap-4 relative h-auto">
							<div>
								<img
									src={$recordPostsDataModal.feature_image.value}
									class="w-full rounded"
									alt=""
								/>
							</div>
							<div class="parent font-light text-6xl">
								<AutoResizableTextarea
									bind:value={$recordPostsDataModal.title.value}
									classes={'input p-0 bg-surface-50 font-light text-6xl border-none rounded-none focus:border-none active:border-none overflow-hidden resize-none dark:bg-transparent'}
									placeholder={'Page title...'}
								/>
							</div>
							<div class="mb-20 h-full">
								<CompPostEditor
									bind:this={_compPostEditor}
									{data}
									bind:dataModal={$recordPostsDataModal}
								/>
							</div>
						</div>
					</div>
				{/if}
			</slot>
			<svelte:fragment slot="pageFooter">
				<div class="pt-1 bottom-0 mr-3 mb-3 float-right w-fit flex flex-row-reverse gap-2">
					<!-- {#if $wordsCount} -->
					<div class="">
						{$wordsCount} words
					</div>
					<!-- {/if} -->
					<div class={aimResJson?.brainiacminds?.Usage?.TotalTokens ? '' : 'hidden'}>
						Tokens Usage: {JSON.stringify(aimResJson?.brainiacminds.Usage.TotalTokens)}
						/
					</div>
				</div>
			</svelte:fragment>

			<!-- ---- / ---- -->
		</AppShell>
	{/if}
</Drawer>
<!-- 
<style>
	#editorBodySection{
		
	}
</style> -->
