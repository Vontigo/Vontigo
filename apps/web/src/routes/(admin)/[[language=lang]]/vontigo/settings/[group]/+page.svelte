<script lang="ts">
	import { page } from '$app/stores';
	import { toastStore, type ToastSettings, Toast } from '@skeletonlabs/skeleton';
	import CompEditor from '$lib/core/core/frontend/components/admin/Editor/CompEditor.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { AppBar, AppShell, RadioGroup, RadioItem } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';
	import { adminSiteUrl, isEditorOpen } from '$lib/core/shared/stores/site';
	import type { Readable } from 'svelte/store';
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
		regionDrawer: 'overflow-y-hidden'
	};

	async function updateField(id: string, field: string, value: string, key: string) {
		const resData = await fetch(
			`/api/database/settings/put/${id}/${field}/${encodeURIComponent(value)}`
		);
		const resDataJson = await resData.json();
		if (resDataJson.row) {
			const t: ToastSettings = {
				message: `New value for [ ${key} ] key setting saved!`,
				timeout: 2000
			};
			toastStore.trigger(t);
		}
	}

</script>

<div class="max-w-screen-xl mx-auto px-10 py-2">
	<AppBar class="sticky top-0 z-10 p-4 bg-white">
		<!-- <svelte:fragment slot="lead">
			<Icon3BottomLeft />
		</svelte:fragment> -->
		<h2 class="text-xl font-bold">Settings</h2>
		<span class="uppercase text-sm font-semibold"
			><a href={$adminSiteUrl + `/settings`}>All</a> > {$page.params.group || ''}</span
		>
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
	{#if data.settings.length > 0}
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
							<th class="w-1 uppercase">Key</th>
							<th class="">Value</th>
							<th class="w-1 uppercase text-right">Type</th>
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
								<td class="cursor-pointer">
									<p class="unstyled text-sm font-medium antialiased tracking-wide uppercase">
										{row.key}
									</p>
									<!-- <p class="unstyled text-xs mt-1 text-slate-500">
									<span>{row.group}</span>
								</p> -->
								</td>
								<td>
									{#if row.type == 'string'}
										{#if row.key.indexOf('color') >= 0}
											<div class="grid grid-cols-[auto_1fr] gap-2">
												<input
													class="input"
													type="color"
													name={row.key}
													bind:value={row.value}
													on:change={() => {
														updateField(row.id, 'value', row.value, row.key);
													}}
												/>
												<input
													class="input w-1/3 p-2"
													type="text"
													bind:value={row.value}
													readonly
													tabindex="-1"
												/>
											</div>
										{:else if row.key.indexOf('image') >= 0}
											<input
												class="input w-full"
												type="file"
												bind:value={row.value}
												on:blur={() => {
													updateField(row.id, 'value', row.value, row.key);
												}}
											/>
										{:else}
											<input
												class="input p-2 w-full"
												type="text"
												name={row.key}
												bind:value={row.value}
												on:blur={() => {
													updateField(row.id, 'value', row.value, row.key);
												}}
											/>
										{/if}
									{:else if row.type == 'array'}
										<textarea
											class="textarea w-full rounded-xl p-2"
											rows="6"
											placeholder="Enter some long form content."
											name={row.key}
											bind:value={row.value}
											on:blur={() => {
												updateField(row.id, 'value', row.value, row.key);
											}}
										/>
									{:else if row.type == 'boolean'}
										<RadioGroup active="variant-filled-primary" hover="hover:variant-soft-primary">
											<RadioItem
												bind:group={row.value}
												name={row.key}
												value={'true'}
												on:change={() => {
													updateField(row.id, 'value', row.value, row.key);
												}}>TRUE</RadioItem
											>
											<RadioItem
												bind:group={row.value}
												name={row.key}
												value={'false'}
												on:change={() => {
													updateField(row.id, 'value', row.value, row.key);
												}}>FALSE</RadioItem
											>
										</RadioGroup>
									{:else}
										Unknow type...
									{/if}
								</td>
								<td>
									{row.type}
								</td>
							</tr>

							<!-- {assignPreviousSubGroup(row.key.split('_')[0])} -->
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
	{/if}
	<Toast />
</div>

<style global>
	.drawer-backdrop .drawer {
		height: calc(100vh - 2rem);
	}
</style>
