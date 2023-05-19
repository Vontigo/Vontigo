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
	import { onMount } from 'svelte';
	import { tables } from '$lib/core/core/server/data/schema/schema';
	import { each } from 'svelte/internal';

	export let data: PageData;
	export let table: string;

	let selectedPost: any;
	let keysJson: string[];
	let colorValue;

	const tableSchema = tables[table];
	// console.log(tableSchema);

	const initialFileValues: { [key: string]: string } = {};

	let recordId = data.record.find((obj) => obj.key === 'id').value;

	onMount(async () => {
		// Backup all of previous files to delete incase upload new files
		updateInitialFileValues();
		// console.log(initialFileValues);
	});
	function updateInitialFileValues() {
		const fileInputs = document.querySelectorAll('.prevFileHidden');
		fileInputs.forEach((fileInput) => {
			initialFileValues[fileInput.id] = fileInput.value;
		});
	}

	// let previousSubGroup = '';

	// if (data && data.posts) keysJson = Object.keys(data.posts[0]);

	// const settings: DrawerSettings = {
	// 	id: 'postEditorDrawer',
	// 	position: 'right',
	// 	width: 'w-full lg:w-[80%]',
	// 	// height: 'h-full',
	// 	padding: 'p-4',
	// 	rounded: 'rounded-xl',
	// 	shadow: 'shadow-md',
	// 	regionDrawer: 'overflow-y-hidden'
	// };

	const onFileSelected = (e, key: string) => {
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

			const reqUpFile = await uploadFile(key);

			// console.log(reqUpFile);
			if (reqUpFile.filePath) {
				const serverPath = reqUpFile.filePath.replace('static\\', '/').replace(/\\/g, '/');
				await updateField(recordId, key, serverPath);
				if (serverPath != initialFileValues[key]) await deletePrevFile(key);
				// console.log(serverPath);
				initialFileValues[key] = serverPath;
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

	async function updateField(id: string, field: string, value: string) {
		// console.log('id',id);

		const requestOptions = {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ body: value })
		};
		const resData = await fetch(`/api/database/${table}/put/${recordId}/${field}`, requestOptions);
		const resDataJson = await resData.json();
		if (resDataJson.row) {
			const t: ToastSettings = {
				message: `New value for [ ${field} ] key setting saved!`,
				timeout: 2000
			};
			toastStore.trigger(t);
		}
	}

	async function uploadFile(key: string) {
		let imgInputElement = document.getElementById(key + `-input`);
		let imgElement = document.getElementById(key + `-img`);
		let imgBase64Element = document.getElementById(key + `-base64`);

		var file = imgInputElement.value.split('\\');
		var fileName = recordId + '_' + file[file.length - 1];

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
	async function getReferenceValue(rec: TableStructure) {
		console.log(rec);

		const resData = await fetch(`/api/database/${rec.reference.table}/read/${rec.value}`);
		// console.log(await resData.json());

		return await resData.json();
	}
</script>

{#if data.record}
	<section class="view-container content-list">
		<ol class="records-list v-list flex flex-col">
			<li class="v-list-row header grid grid-cols-6 uppercase text-xs border-b">
				<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-2">Key</div>
				<div class="v-list-header v-posts-status-header py-2 col-span-3">Value</div>
				<div class="v-list-header v-posts-status-header p-2 text-end">Type</div>
			</li>
			{#each data.record as row, i}
				<li
					class="v-list-row v-records-list-item grid md:grid-cols-6 border-b p-2 hover:bg-secondary-500/20 grid-cols-1 {i ==
					data.record.length - 1
						? ' border-b'
						: ''}"
				>
					<div
						class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full capitalize col-span-2"
					>
						<h3
							class="v-content-entry-title unstyled font-medium antialiased tracking-wide flex gap-2"
						>
							{row.key.replace(/_/g, ' ')}<span class="text-red-700 font-bold"
								>{tableSchema[row.key].nullable == false ? '*' : ''}</span
							>
							{#if row.reference}
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
										d="M13.19 8.688a4.5 4.5 0 011.242 7.244l-4.5 4.5a4.5 4.5 0 01-6.364-6.364l1.757-1.757m13.35-.622l1.757-1.757a4.5 4.5 0 00-6.364-6.364l-4.5 4.5a4.5 4.5 0 001.242 7.244"
									/>
								</svg>
							{/if}
						</h3>
					</div>
					<div
						href={$STORE_ADMIN_SITE_URL + `/tags/${$page.params.visibility}/${row.slug}`}
						class="ember-view permalink v-list-data v-post-list-title py-4 w-full tracking-wide col-span-3"
					>
						{#if row.reference}
							{#await getReferenceValue(row)}
								<ProgressRadial width="w-6" />
							{:then rec}
								{rec?.row?.name}
							{/await}
						{:else if row.type == 'text'}
							<textarea
								class="textarea w-full rounded-xl p-2"
								rows="6"
								placeholder="Enter some long form content."
								name={row.key}
								maxlength={tableSchema[row.key]?.validations?.isLength?.max
									? tableSchema[row.key]?.validations?.isLength.max
									: ''}
								bind:value={row.value}
								on:change={() => {
									updateField(recordId, row.key, row.value);
								}}
							/>
						{:else if row.type == 'datetime'}
							<input
								class="input p-2 w-1/3"
								type="datetime-local"
								name={row.key}
								bind:value={row.value}
								on:change={() => {
									updateField(recordId, row.key, row.value);
								}}
							/>
						{:else if row.type == 'integer'}
							<input
								class="input p-2 w-1/3"
								type="number"
								name={row.key}
								bind:value={row.value}
								on:change={() => {
									updateField(recordId, row.key, row.value);
								}}
							/>
						{:else if row.type == 'boolean'}
							<RadioGroup active="variant-filled-primary" hover="hover:variant-soft-primary">
								<RadioItem
									bind:group={row.value}
									name={row.key}
									value={'true'}
									on:change={() => {
										updateField(row.id, row.key, row.value);
									}}>TRUE</RadioItem
								>
								<RadioItem
									bind:group={row.value}
									name={row.key}
									value={'false'}
									on:change={() => {
										updateField(row.id, row.key, row.value);
									}}>FALSE</RadioItem
								>
							</RadioGroup>
						{:else if row.type == 'varchar'}
							{#if row.key.indexOf('color') >= 0}
								<div class="grid grid-cols-[auto_1fr] gap-2">
									<input
										class="input"
										type="color"
										name={row.key}
										bind:value={row.value}
										on:change={() => {
											updateField(recordId, row.key, row.value);
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
							{:else if row.key.indexOf('image') >= 0 || row.key.indexOf('logo') >= 0 || row.key.indexOf('icon') >= 0}
								<div class="flex flex-col gap-2">
									<input id={row.key} class="prevFileHidden" type="hidden" bind:value={row.value} />
									<input
										id={row.key + `-input`}
										class="input w-full"
										type="file"
										bind:value={row.value}
										on:change={(e) => onFileSelected(e, row.key)}
									/>
									{#if row.value}
										<em>
											⚠️ Warning: Old file will be deleted from the server whenever new file has
											been uploaded.</em
										>
									{/if}
									<input id={row.key + `-base64`} name={row.key + `-base64`} type="hidden" />
									<img
										id={row.key + `-img`}
										name={row.key + `-img`}
										src={row.value}
										style="max-width: 50ch;"
										alt=""
									/>
								</div>
							{:else if row.type == 'boolean'}
								<RadioGroup active="variant-filled-primary" hover="hover:variant-soft-primary">
									<RadioItem
										bind:group={row.value}
										name={row.key}
										value={'true'}
										on:change={() => {
											updateField(row.id, row.key, row.value);
										}}>TRUE</RadioItem
									>
									<RadioItem
										bind:group={row.value}
										name={row.key}
										value={'false'}
										on:change={() => {
											updateField(row.id, row.key, row.value);
										}}>FALSE</RadioItem
									>
								</RadioGroup>
							{:else if row.key == 'id' || row.key == 'uuid'}
								<input
									class="input p-2 w-full"
									type="text"
									name={row.key}
									bind:value={row.value}
									on:change={() => {
										updateField(recordId, row.key, row.value);
									}}
									readonly="readonly"
								/>
							{:else if row.type == 'varchar' && tableSchema[row.key]?.validations?.isIn}
								<select
									class="select rounded-3xl w-1/3 text-base"
									bind:value={row.value}
									on:change={() => {
										updateField(recordId, row.key, row.value);
									}}
								>
									<option value={''}>-- NULL --</option>
									{#each tableSchema[row.key]?.validations?.isIn as optiongroup}
										{#each optiongroup as option}
											<option value={option}>{option}</option>
										{/each}
									{/each}
								</select>
							{:else if row.key.indexOf('description') >= 0}
								<textarea
									class="textarea w-full rounded-xl p-2"
									rows="5"
									placeholder="Enter some long form content."
									name={row.key}
									maxlength={tableSchema[row.key]?.validations?.isLength?.max
										? tableSchema[row.key]?.validations?.isLength.max
										: ''}
									bind:value={row.value}
									on:change={() => {
										updateField(row.id, row.key, row.value);
									}}
								/>
							{:else}
								<!-- {tableSchema[row.key]?.validations?.matches?.toString().slice(1, -1)} -->
								<input
									class="input p-2 w-full"
									type="text"
									name={row.key}
									maxlength={tableSchema[row.key]?.validations?.isLength?.max
										? tableSchema[row.key]?.validations?.isLength.max
										: ''}
									pattern={tableSchema[row.key]?.validations?.matches
										? tableSchema[row.key]?.validations?.matches?.toString().slice(1, -1)
										: '.*'}
									required={tableSchema[row.key]?.nullable == false ? 'required' : ''}
									bind:value={row.value}
									on:change={(e) => {
										const regex = new RegExp(e.target.pattern);
										let isValid = regex.test(e.target.value);
										if (isValid && tableSchema[row.key]?.nullable == false && e.target.value) {
											updateField(recordId, row.key, row.value);
										} else {
											alert('Invalid input format or value!');
										}
									}}
								/>
							{/if}
						{/if}
					</div>

					<div class="ember-view permalink v-list-data v-post-list-status px-2 py-4">
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
