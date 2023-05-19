<script lang="ts">
	import { page } from '$app/stores';
	import {
		toastStore,
		type ToastSettings,
		Toast,
		clipboard,
		modalStore
	} from '@skeletonlabs/skeleton';
	import CompEditor from '$lib/core/core/frontend/components/admin/Editor/CompEditor.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { AppBar, AppShell, RadioGroup, RadioItem } from '@skeletonlabs/skeleton';
	import { Drawer, drawerStore } from '@skeletonlabs/skeleton';
	import type { DrawerSettings } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';
	import { STORE_ADMIN_SITE_URL, isEditorOpen } from '$lib/core/shared/stores/site';
	import type { Readable } from 'svelte/store';
	import { onMount } from 'svelte';
	export let data: PageData;
	let selectedPost: any;
	let keysJson: string[];
	let colorValue;
	const initialFileValues: { [key: string]: string } = {};
	// let recordId = data.records.find((obj) => obj.key === 'id').value;

	onMount(async () => {
		// Backup all of previous files to delete incase upload new files
		const fileInputs = document.querySelectorAll('.prevFileHidden');
		fileInputs.forEach((fileInput) => {
			initialFileValues[fileInput.id] = fileInput.value;
		});
		// console.log(initialFileValues);
	});

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

	const onFileSelected = (e, key: string, id: string) => {
		// console.log(key);

		//let imgSrc;
		let imgElement = document.getElementById(key + `-img`);
		let imgBase64Element = document.getElementById(key + `-base64`);

		let image = e.target.files[0];
		let reader = new FileReader();
		reader.readAsDataURL(image);
		reader.onload = async (e) => {
			// console.log(e);

			//imgSrc = e.target.result;
			imgElement.src = e.target.result;
			imgBase64Element.value = e.target.result;

			const reqUpFile = await uploadFile(key, id);

			// console.log(reqUpFile);
			if (reqUpFile.filePath) {
				const serverPath = reqUpFile.filePath.replace('static\\', '/').replace(/\\/g, '/');
				//console.log(serverPath);
				await updateField(id, 'value', serverPath, key);
				if (serverPath != initialFileValues[key]) await deletePrevFile(key);
			}
		};
	};

	async function deletePrevFile(key: string) {
		// console.log('deletePrevFile ', initialFileValues);

		const requestOptions = {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ body: initialFileValues[key] })
		};
		const resData = await fetch(`/api/admin/file/delete`, requestOptions);
		const resDataJson = await resData.json();
	}

	async function updateField(id: string, field: string, value: string, key: string) {
		const requestOptions = {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ body: value })
		};
		const resData = await fetch(`/api/database/settings/put/${id}/${field}`, requestOptions);
		const resDataJson = await resData.json();
		if (resDataJson.row) {
			const t: ToastSettings = {
				message: `New value for [ ${key} ] key setting saved!`,
				timeout: 2000,
				background: 'variant-filled-success'
			};
			toastStore.trigger(t);
		}
	}

	async function uploadFile(key: string, id: string) {
		let imgInputElement = document.getElementById(key + `-input`);
		let imgElement = document.getElementById(key + `-img`);
		let imgBase64Element = document.getElementById(key + `-base64`);

		var file = imgInputElement.value.split('\\');
		var fileName = id + '_' + file[file.length - 1];

		const requestOptions = {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				fileName: fileName,
				fileBase64: imgBase64Element.value
			})
		};

		const resData = await fetch(`/api/admin/file/create`, requestOptions);
		return resData.json();
	}
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<!-- <svelte:fragment slot="lead">
		<Icon3BottomLeft />
	</svelte:fragment> -->
	<!-- <h2 class="text-xl font-bold">Settings</h2>
	<span class="uppercase text-sm font-semibold"
		><a href={$STORE_ADMIN_SITE_URL + `/settings`}>All</a> > {$page.params.group || ''}</span
	>
	 -->
	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold mb-1">Settings</h2></li>
		<li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">{$page.params.group || ''}</li>
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
		<!-- </div> -->
	</svelte:fragment>

	<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
</AppBar>
<div class="max-w-screen-xl mx-auto px-12">
	<Drawer>
		{#if $drawerStore.id === 'postEditorDrawer'}
			<CompEditor postData={selectedPost} />
		{/if}
	</Drawer>
	{#if data.records.length > 0}
		<section class="view-container content-list">
			<ol class="records-list v-list flex flex-col">
				<li class="v-list-row header grid grid-cols-6 uppercase text-xs border-b">
					<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-2">Key</div>
					<div class="v-list-header v-posts-status-header py-2 col-span-3">Value</div>
					<div class="v-list-header v-posts-status-header p-2 text-end">Type</div>
				</li>
				{#each data.records as row, i}
					<li
						class="v-list-row v-records-list-item grid md:grid-cols-6 border-b p-2 hover:bg-secondary-500/20 grid-cols-1 {i ==
						data.records.length - 1
							? ' border-b'
							: ''}"
					>
						<div
							class="ember-view permalink v-list-data v-post-list-title w-full py-4 capitalize col-span-2"
						>
							<h3
								class="v-content-entry-title unstyled font-medium antialiased tracking-wide flex gap-2"
							>
								{row.key.replace(/_/g, ' ')}
							</h3>
						</div>
						<div
							class="ember-view permalink v-list-data v-post-list-title w-full py-4 text-xs tracking-wide col-span-3"
						>
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
								{:else if row.key.indexOf('codeinjection') >= 0}
									<textarea
										class="textarea w-full rounded-xl p-2"
										rows="6"
										placeholder="Enter some HTML code here..."
										name={row.key}
										bind:value={row.value}
										on:change={() => {
											updateField(row.id, 'value', row.value, row.key);
										}}
									/>
								{:else if row.key.indexOf('image') >= 0 || row.key.indexOf('logo') >= 0 || row.key.indexOf('icon') >= 0}
									<!-- <input
									class="input w-full"
									type="file"
									bind:value={row.value}
									on:blur={() => {
										updateField(row.id, 'value', row.value, row.key);
									}}
								/> -->

									<div class="flex flex-col gap-2">
										<input
											id={row.key}
											class="prevFileHidden"
											type="hidden"
											bind:value={row.value}
										/>
										<input
											id={row.key + `-input`}
											class="input w-full"
											type="file"
											bind:value={row.value}
											on:change={(e) => onFileSelected(e, row.key, row.id)}
										/>
										{#if row.value}
											<em>
												⚠️ Warning: Old file will be deleted from the server whenever new file has
												been uploaded.</em
											>
										{/if}
										<input id={row.key + `-base64`} name={row.key + `-base64`} type="hidden" />
										<div class="w-full relative">
											<img
												id={row.key + `-img`}
												name={row.key + `-img`}
												src={row.value}
												style="max-width: 50ch;"
												class="w-full rounded"
												alt=""
											/>
											{#if row.value}
												<div class="absolute top-1 right-1 flex flex-row-reverse">
													<!-- {row.value} -->
													<button
														class="btn-icon variant-soft h-4 w-4 p-3 text-white justify-center items-center content-center border-none rounded"
														on:click={() => {
															deletePrevFile(row.key);
															row.value = '';
															updateField(row.id, 'value', row.value, row.key);
															toastStore.trigger({
																message: 'Image deleted!',
																timeout: 2000,
																background: 'variant-filled-success'
															});
														}}
													>
														<span>
															<svg
																xmlns="http://www.w3.org/2000/svg"
																class="icon icon-tabler icon-tabler-trash"
																width="24"
																height="24"
																viewBox="0 0 24 24"
																stroke-width="2"
																stroke="currentColor"
																fill="none"
																stroke-linecap="round"
																stroke-linejoin="round"
															>
																<path stroke="none" d="M0 0h24v24H0z" fill="none" />
																<path d="M4 7l16 0" />
																<path d="M10 11l0 6" />
																<path d="M14 11l0 6" />
																<path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" />
																<path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" />
															</svg>
														</span>
													</button>
													<button
														class="btn-icon variant-soft h-4 w-4 p-3 text-white justify-center items-center content-center border-none rounded"
														use:clipboard={row.value}
														on:click={() => {
															toastStore.trigger({
																message: 'Link coppied!',
																timeout: 2000,
																background: 'variant-filled-success'
															});
														}}
													>
														<span>
															<svg
																xmlns="http://www.w3.org/2000/svg"
																class="icon icon-tabler icon-tabler-copy"
																width="24"
																height="24"
																viewBox="0 0 24 24"
																stroke-width="2"
																stroke="currentColor"
																fill="none"
																stroke-linecap="round"
																stroke-linejoin="round"
															>
																<path stroke="none" d="M0 0h24v24H0z" fill="none" />
																<path
																	d="M8 8m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z"
																/>
																<path
																	d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2"
																/>
															</svg>
														</span>
													</button>
												</div>
											{/if}
										</div>
									</div>
								{:else}
									<input
										class="input p-2 w-full"
										type="text"
										name={row.key}
										bind:value={row.value}
										on:change={() => {
											updateField(row.id, 'value', row.value, row.key);
										}}
									/>
								{/if}
							{:else if row.type == 'array' || row.type == 'text'}
								<textarea
									class="textarea w-full rounded-xl p-2"
									rows="6"
									placeholder="Enter some long form content."
									name={row.key}
									bind:value={row.value}
									on:change={() => {
										updateField(row.id, 'value', row.value, row.key);
									}}
								/>
							{:else if row.type == 'number'}
								<input
									class="input p-2 w-full"
									type="number"
									name={row.key}
									bind:value={row.value}
									on:change={() => {
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
						</div>

						<div class="ember-view permalink v-list-data v-post-list-status px-2 py-6">
							<div class="grid justify-items-end w-full text-sm">
								{row.type}
							</div>
						</div>
					</li>
				{/each}
			</ol>
			<div class="infinity-loader reached-infinity py-10" />
		</section>
	{/if}
	<!-- <Toast position={'tr'} /> -->
</div>
