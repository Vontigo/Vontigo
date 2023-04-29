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
	import { adminSiteUrl, isEditorOpen, recordDataModal } from '$lib/core/shared/stores/site';
	import type { ReferenceStructure, TableStructure } from '$lib/core/shared/types';
	import { onMount } from 'svelte';
	import { tables } from '$lib/core/core/server/data/schema/schema';
	import { each } from 'svelte/internal';
	import { get } from 'svelte/store';

	export let data: PageData;
	export let dataModal: any;
	export let table: string;

	let selectedPost: any;
	let keysJson: string[];
	let colorValue;
	let formElement: any;

	const tableSchema = tables[table];

	// console.log(dataModal);

	// data.schema.forEach((value, key) => {
	// 	dataSchema[value.key] = value;
	// });
	// console.log(dataSchema);
	// console.log(tableSchema);

	// const formData = new FormData(formElement);
	// const formObject: any = {};

	// formData.forEach((value, key) => {
	// 	formObject[key] = value;
	// });

	// console.log(formObject);

	const initialFileValues: { [key: string]: string } = {};

	const initialRecordDataValues: { [key: string]: string } = {};

	let recordId = get(recordDataModal).id.value; //data.schema.find((obj) => obj.key === 'id').value;

	onMount(async () => {
		// Backup all of previous files to delete incase upload new files
		const fileInputs = document.querySelectorAll('.prevFileHidden');
		fileInputs.forEach((fileInput) => {
			initialFileValues[fileInput.id] = fileInput.value;
		});
		// console.log(initialFileValues);
	});

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
				//console.log(serverPath);
				await updateField(recordId, key, serverPath);
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
	let oldValues = {};
	$: {
		Object.keys(dataModal).forEach((key) => {
			if (dataModal[key].value !== null && dataModal[key].value !== oldValues[key]) {
				console.log(`${key} value changed:`, dataModal[key].value);
				updateField(recordId, dataModal[key].key, dataModal[key].value);
				oldValues[key] = dataModal[key].value;
			}
		});
	}
</script>

<!-- 
{#each Object.keys(recordDataModal) as row}
	{row}
{/each} -->
<!-- {recordDataModal.title.value} -->
{#if dataModal}
	<section class="view-container content-list">
		<ol class="records-list v-list flex flex-col">
			<li class="v-list-row header grid grid-cols-6 uppercase text-xs border-b md:hidden">
				<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-2">Key</div>
				<div class="v-list-header v-posts-status-header py-2 col-span-3">Value</div>
				<div class="v-list-header v-posts-status-header p-2 text-end">Type</div>
			</li>
			{#each Object.keys(dataModal) as key, i}
				<li
					class="v-list-row v-records-list-item grid md:grid-cols-1 border-b grid-cols-6 {i ==
					dataModal.length - 1
						? ' border-b'
						: ''}"
				>
					<div
						class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full capitalize md:grid-cols-1 col-span-2 md:pb-0"
					>
						<h3
							class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide flex gap-2"
						>
							{dataModal[key].key.replace(/_/g, ' ')}<span class="text-red-700 font-bold"
								>{tableSchema[dataModal[key].key].nullable == false ? '*' : ''}</span
							>
							{#if dataModal[key].reference}
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
						href={$adminSiteUrl + `/tags/${$page.params.visibility}/${dataModal[key].slug}`}
						class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full text-xs tracking-wide text-slate-500 col-span-3 md:pb-0"
					>
						{#if dataModal[key].reference && dataModal[key].value}
							{#await getReferenceValue(dataModal[key])}
								<ProgressRadial width="w-6" />
							{:then rec}
								{rec?.row?.name}
							{/await}
						{:else if dataModal[key].type == 'text'}
							<textarea
								class="textarea w-full rounded-xl p-2"
								id={dataModal[key].key}
								name={dataModal[key].key}
								rows="6"
								placeholder="Enter some long form content."
								maxlength={tableSchema[dataModal[key].key]?.validations?.isLength?.max
									? tableSchema[dataModal[key].key]?.validations?.isLength.max
									: ''}
								bind:value={dataModal[key].value}
								on:change={() => {
									updateField(recordId, dataModal[key].key, dataModal[key].value);
								}}
							/>
						{:else if dataModal[key].type == 'datetime'}
							<input
								class="input p-2 w-1/3 md:w-full"
								type="datetime-local"
								id={dataModal[key].key}
								name={dataModal[key].key}
								bind:value={dataModal[key].value}
								on:change={() => {
									updateField(recordId, dataModal[key].key, dataModal[key].value);
								}}
							/>
						{:else if dataModal[key].type == 'integer'}
							<input
								class="input p-2 w-1/3 md:w-full"
								type="number"
								id={dataModal[key].key}
								name={dataModal[key].key}
								bind:value={dataModal[key].value}
								on:change={() => {
									updateField(recordId, dataModal[key].key, dataModal[key].value);
								}}
							/>
						{:else if dataModal[key].type == 'boolean'}
							<RadioGroup active="variant-filled-primary" hover="hover:variant-soft-primary">
								<RadioItem
									bind:group={dataModal[key].value}
									id={dataModal[key].key}
									name={dataModal[key].key}
									value={'true'}
									on:change={() => {
										updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
									}}>TRUE</RadioItem
								>
								<RadioItem
									bind:group={dataModal[key].value}
									id={dataModal[key].key}
									name={dataModal[key].key}
									value={'false'}
									on:change={() => {
										updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
									}}>FALSE</RadioItem
								>
							</RadioGroup>
						{:else if dataModal[key].type == 'varchar'}
							{#if dataModal[key].key.indexOf('color') >= 0}
								<div class="grid grid-cols-[auto_1fr] gap-2">
									<input
										class="input"
										type="color"
										id={dataModal[key].key}
										name={dataModal[key].key}
										bind:value={dataModal[key].value}
										on:change={() => {
											updateField(recordId, dataModal[key].key, dataModal[key].value);
										}}
									/>
									<input
										class="input w-1/3 p-2 md:w-full"
										type="text"
										bind:value={dataModal[key].value}
										readonly
										tabindex="-1"
									/>
								</div>
							{:else if dataModal[key].key.indexOf('image') >= 0 || dataModal[key].key.indexOf('logo') >= 0 || dataModal[key].key.indexOf('icon') >= 0}
								<div class="flex flex-col gap-2">
									<input
										id={dataModal[key].key}
										class="prevFileHidden"
										type="hidden"
										bind:value={dataModal[key].value}
									/>
									<input
										id={dataModal[key].key + `-input`}
										class="input w-full"
										type="file"
										bind:value={dataModal[key].value}
										on:change={(e) => onFileSelected(e, dataModal[key].key)}
									/>
									{#if dataModal[key].value}
										<em>
											⚠️ Warning: Old file will be deleted from the server whenever new file has
											been uploaded.</em
										>
									{/if}
									<input
										id={dataModal[key].key + `-base64`}
										name={dataModal[key].key + `-base64`}
										type="hidden"
									/>
									<img
										id={dataModal[key].key + `-img`}
										name={dataModal[key].key + `-img`}
										src={dataModal[key].value}
										style="max-width: 50ch;"
										alt=""
									/>
								</div>
							{:else if dataModal[key].type == 'boolean'}
								<RadioGroup active="variant-filled-primary" hover="hover:variant-soft-primary">
									<RadioItem
										bind:group={dataModal[key].value}
										id={dataModal[key].key}
										name={dataModal[key].key}
										value={'true'}
										on:change={() => {
											updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
										}}>TRUE</RadioItem
									>
									<RadioItem
										bind:group={dataModal[key].value}
										id={dataModal[key].key}
										name={dataModal[key].key}
										value={'false'}
										on:change={() => {
											updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
										}}>FALSE</RadioItem
									>
								</RadioGroup>
							{:else if dataModal[key].key == 'id' || dataModal[key].key == 'uuid'}
								<input
									class="input p-2 w-full"
									type="text"
									id={dataModal[key].key}
									name={dataModal[key].key}
									bind:value={dataModal[key].value}
									on:change={() => {
										updateField(recordId, dataModal[key].key, dataModal[key].value);
									}}
									readonly="readonly"
								/>
							{:else if dataModal[key].type == 'varchar' && tableSchema[dataModal[key].key]?.validations?.isIn}
								<select
									id={dataModal[key].key}
									name={dataModal[key].key}
									class="select rounded-3xl w-1/3 md:w-full"
									bind:value={dataModal[key].value}
									on:change={() => {
										updateField(recordId, dataModal[key].key, dataModal[key].value);
									}}
								>
									<option value={''}>-- NULL --</option>
									{#each tableSchema[dataModal[key].key]?.validations?.isIn as optiongroup}
										{#each optiongroup as option}
											<option value={option}>{option}</option>
										{/each}
									{/each}
								</select>
							{:else if dataModal[key].key.indexOf('description') >= 0}
								<textarea
									class="textarea w-full rounded-xl p-2"
									rows="3"
									placeholder="Enter some long form content."
									id={dataModal[key].key}
									name={dataModal[key].key}
									maxlength={tableSchema[dataModal[key].key]?.validations?.isLength?.max
										? tableSchema[dataModal[key].key]?.validations?.isLength.max
										: ''}
									bind:value={dataModal[key].value}
									on:change={() => {
										updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
									}}
								/>
							{:else}
								<!-- {tableSchema[recordDataModal[key].key]?.validations?.matches?.toString().slice(1, -1)} -->
								<input
									class="input p-2 w-full"
									type="text"
									id={dataModal[key].key}
									name={dataModal[key].key}
									maxlength={tableSchema[dataModal[key].key]?.validations?.isLength?.max
										? tableSchema[dataModal[key].key]?.validations?.isLength.max
										: ''}
									pattern={tableSchema[dataModal[key].key]?.validations?.matches
										? tableSchema[dataModal[key].key]?.validations?.matches?.toString().slice(1, -1)
										: '.*'}
									required={tableSchema[dataModal[key].key]?.nullable == false ? 'required' : ''}
									bind:value={dataModal[key].value}
									on:change={(e) => {
										const regex = new RegExp(e.target.pattern);
										let isValid = regex.test(e.target.value);
										if (
											isValid &&
											tableSchema[dataModal[key].key]?.nullable == false &&
											e.target.value
										) {
											updateField(recordId, dataModal[key].key, dataModal[key].value);
										} else {
											alert('Invalid input format or value!');
										}
									}}
								/>
							{/if}
						{/if}
					</div>

					<div class="ember-view permalink v-list-data v-post-list-status px-2 py-6 md:pt-0">
						<div class="grid justify-items-end w-full text-sm text-slate-500">
							{dataModal[key].type}
						</div>
					</div>
				</li>
			{/each}
		</ol>
		<div class="infinity-loader reached-infinity py-10" />
	</section>
{/if}
<Toast />
