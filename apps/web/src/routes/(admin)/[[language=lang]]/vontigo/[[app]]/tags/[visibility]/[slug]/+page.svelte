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
	import {
		STORE_ADMIN_SITE_URL,
		isEditorOpen,
		recordTagsDataModal
	} from '$lib/core/shared/stores/site';
	import type { ReferenceStructure, TableStructure } from '$lib/core/shared/types';
	import { onMount } from 'svelte';
	import RecordDetail from '$lib/core/core/frontend/components/admin/Database/RecordDetail.svelte';
	import { ENUM_DATABASE_TABLE } from '$lib/core/shared/enum';
	import RecordCreate from '$lib/core/core/frontend/components/admin/Database/RecordCreate.svelte';
	export let data: PageData;

	// Reset
	$recordTagsDataModal = {};
	data.record.forEach((value, key) => {
		$recordTagsDataModal[value.key] = value;
	});
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<!-- <svelte:fragment slot="lead">
		<Icon3BottomLeft />
	</svelte:fragment> -->

	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold mb-1">Tags</h2></li>
		<li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">
			<a href={$STORE_ADMIN_SITE_URL + `/tags/${$page.params.visibility}`}>All tags</a>
		</li>
		<li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">{$page.params.slug || 'all status'}</li>
	</ol>
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
		<!-- <button type="button" class="md:hidden btn btn-sm variant-filled rounded">
			<span><IconPlusSmall /></span>
			<span>New post</span>
		</button> -->
		<!-- </div> -->
	</svelte:fragment>

	<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
</AppBar>
<div class="max-w-screen-xl mx-auto px-12">
	{#if data.record}
		<RecordCreate {data} table={ENUM_DATABASE_TABLE.tags} bind:dataModal={$recordTagsDataModal} />
	{/if}
</div>
