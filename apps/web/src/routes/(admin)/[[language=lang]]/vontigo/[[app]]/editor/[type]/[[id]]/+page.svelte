<script lang="ts">
	import { page } from '$app/stores';
	import { toastStore, type ToastSettings, Toast, ProgressRadial } from '@skeletonlabs/skeleton';
	import CompEditor from '$lib/core/core/frontend/components/admin/Editor/CompEditor.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { AppBar, AppShell, RadioGroup, RadioItem } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';
	import { STORE_ADMIN_SITE_URL, isEditorOpen } from '$lib/core/shared/stores/site';
	import type { ReferenceStructure, TableStructure } from '$lib/core/shared/types';
	export let data: PageData;
	let selectedPost: any;
	let keysJson: string[];
	let colorValue;
	// let previousSubGroup = '';

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	const settings: DrawerSettings = {
		id: 'postEditorDrawer',
		position: 'right',
		width: 'w-full lg:w-[80%]',
		// height: 'h-full',
		padding: 'p-4',
		rounded: 'rounded-xl',
		shadow: 'shadow-md',
		bgDrawer: 'bg-white',
		regionDrawer: 'overflow-y-hidden bg-white'
	};

	async function updateField(id: string, field: string, value: string) {
		const requestOptions = {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ body: value })
		};
		const resData = await fetch(`/api/database/posts/put/${id}/${field}`, requestOptions);
		const resDataJson = await resData.json();
		if (resDataJson.row) {
			const t: ToastSettings = {
				message: `Post saved!`,
				timeout: 2000
			};
			toastStore.trigger(t);
		}
	}
	async function updateAllFields(id: string, body: string) {
		const requestOptions = {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(body)
		};

		const resData = await fetch(`/api/database/posts/update/${id}`, requestOptions);
		const resDataJson = await resData.json();
		if (resDataJson.row) {
			const t: ToastSettings = {
				message: `Post saved!`,
				timeout: 2000
			};
			toastStore.trigger(t);
		}
	}
</script>

<div class="max-w-screen-xl mx-auto px-12">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
		<h2 class="text-xl font-bold">Editor</h2>
		<span class="uppercase text-sm font-semibold">{$page.params.slug || ''}</span>
		<svelte:fragment slot="trail">
			<!-- <div class="w-full "> -->
			<div class="hidden md:flex md:flex-row-reverse w-full items-center gap-6">
				<!-- <button
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
			<button type="button" class="md:hidden btn btn-sm variant-filled rounded">
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
	{#if data.post}
		<div class="postsList">
			<!-- Responsive Container (recommended) -->
			<div class="table-container rounded-none w-full">
				<input type="text" bind:value={data.post.title} name={data.post.id} class="input p-2" />
				<textarea bind:value={data.post.html} rows="20" class="input p-2" />
				<button
					type="button"
					on:click={() => {
						updateField(data.post.id, 'html', data.post.html);
					}}>Save body</button
				><button
					type="button"
					on:click={() => {
						updateAllFields(data.post.id, {
							title: data.post.title,
							html: data.post.html
						});
					}}>Save all</button
				>
			</div>
		</div>
	{/if}
	<!-- <Toast position={'tr'} /> -->
</div>
