<script lang="ts">
	import { page } from '$app/stores';
	import {
		toastStore,
		type ToastSettings,
		Toast,
		ProgressRadial,
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
	import {
		STORE_ADMIN_SITE_URL,
		autoSaveCountDown,
		isEditorOpen,
		recordPostsDataModal
	} from '$lib/core/shared/stores/site';
	import type { ReferenceStructure, TableStructure } from '$lib/core/shared/types';
	import { onMount } from 'svelte';
	import { tables } from '$lib/core/core/server/data/schema/schema';
	import { each, empty } from 'svelte/internal';
	import { get } from 'svelte/store';
	import { CONST_AUTOSAVE_COUNTDOWN_MS } from '$lib/core/shared/const';

	export let data: PageData;
	export let dataModal: any;
	export let table: string;
	let isInitDone: boolean = false;

	// let selectedPost: any;
	// let keysJson: string[];
	// let colorValue;
	// let formElement: any;

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

	let recordId = dataModal.id.value; //data.schema.find((obj) => obj.key === 'id').value;

	onMount(async () => {
		// Backup all of previous files to delete incase upload new files
		updateInitialFileValues();
		initOldValues();
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
				dataModal[key].value = serverPath;
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
				message: `New value for <strong>${field}</strong> setting saved!`,
				timeout: 2000,
				background: 'variant-filled-success'
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
		// console.log(rec);

		const resData = await fetch(`/api/database/${rec.reference.table}/read/${rec.value}`);
		// console.log(await resData.json());

		return await resData.json();
	}

	function initOldValues() {
		Object.keys(dataModal).forEach(async (key) => {
			oldValues[key] = dataModal[key].value;
		});
		isInitDone = true;
		return '';
	}

	let oldValues: any = {};
	let timeoutId: any;

	// Conditions for each kind of value on change
	$: if (dataModal && isInitDone) {
		// console.log(dataModal);

		// Show / Hide autosave status
		autoSaveCountDown.set(0);
		Object.keys(dataModal).forEach(async (key) => {
			if (dataModal[key].value !== null && dataModal[key].value !== oldValues[key]) {
				if (key == 'title' || key == 'mobiledoc' || key == 'html' || key == 'plaintext') {
					autoSaveCountDown.set(CONST_AUTOSAVE_COUNTDOWN_MS);
					clearTimeout(
						setTimeout(() => {
							autoSaveCountDown.set($autoSaveCountDown - 1000);
						}, 1000)
					);
				}

				//
				if (key == 'status') {
					if (dataModal[key].value == 'published') {
						dataModal['published_at'].value = new Date().toISOString().slice(0, 16);
						dataModal['published_by'].value = $page?.data?.session?.user?.id;
					}
				}

				if (key == 'published_at' || key == 'published_by') {
					updateField(recordId, dataModal[key].key, dataModal[key].value);
					oldValues[key] = dataModal[key].value;
				}
			}
		});

		clearTimeout(timeoutId);
		timeoutId = setTimeout(() => {
			Object.keys(dataModal).forEach(async (key) => {
				if (dataModal[key].value !== null && dataModal[key].value !== oldValues[key]) {
					// Update editor values
					if (key == 'title' || key == 'mobiledoc' || key == 'html' || key == 'plaintext') {
						// console.log(`${key} value changed:`, dataModal[key].value);
						updateField(recordId, dataModal[key].key, dataModal[key].value);
						oldValues[key] = dataModal[key].value;

						if (key == 'title') {
							//newTagBody.slug = await createUniqueSlug(newTagBody.name);
							const response = await fetch(`/api/admin/slugs/posts/${dataModal[key].value}`);
							const resJson = await response.json();
							// console.log(resJson);

							dataModal['slug'].value = resJson?.slugs[0]?.slug;

							updateField(recordId, dataModal['slug'].key, dataModal['slug'].value);
							oldValues['slug'] = dataModal['slug'].value;
						}
						autoSaveCountDown.set(0);
					}
				}
			});
		}, CONST_AUTOSAVE_COUNTDOWN_MS);
	}
</script>

<!-- 
{#each Object.keys(recordDataModal) as row}
	{row}
{/each} -->
<!-- {recordDataModal.title.value} -->
{#if dataModal}
	<section class="view-container content-list @container">
		<ol class="records-list v-list flex flex-col">
			<li class="v-list-row header @xs:grid grid-cols-6 uppercase text-xs border-b hidden">
				<div class="v-list-header v-posts-title-header w-full p-2 ps-0 col-span-2">Key</div>
				<div class="v-list-header v-posts-status-header py-2 col-span-3">Value</div>
				<!-- <div class="v-list-header v-posts-status-header p-2 text-end">Type</div> -->
			</li>
			{#each Object.keys(dataModal) as key, i}
				<li
					class="v-list-row v-records-list-item grid grid-cols-1 @lg:grid-cols-6 border-b
					{i == dataModal.length - 1 ? ' border-b' : ''}
					{tableSchema[dataModal[key].key].isHidden == true ? ' hidden' : ''}"
				>
					<div
						class="ember-view permalink v-list-data v-post-list-title w-full py-4 w-full capitalize md:grid-cols-1 col-span-2 md:pb-0 flex"
					>
						<div
							class="v-content-entry-title unstyled text-sm font-medium antialiased tracking-wide flex @xs:flex-col w-full gap-2"
						>
							<div class="flex flex-1 @xs:flex-none gap-2">
								<label class="" for={dataModal[key].key}>
									{dataModal[key].key.replace(/_/g, ' ')}
									<i class="text-red-700 font-bold">
										{tableSchema[dataModal[key].key].nullable == false ? '*' : ''}
									</i>
								</label>

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
							</div>
							<i class="font-light text-xs text-slate-400">[ {dataModal[key].type} ]</i>
						</div>

						<!-- <div class="ember-view permalink v-list-data v-post-list-status px-2 py-6 md:pt-0"> -->
						<!-- <div class="grid justify-items-end w-full text-sm text-slate-500">
							{dataModal[key].type}
						</div> -->
						<!-- </div> -->
					</div>
					<div
						href={$STORE_ADMIN_SITE_URL + `/tags/${$page.params.visibility}/${dataModal[key].slug}`}
						class="ember-view permalink v-list-data v-post-list-title w-full tracking-wide col-span-3 pt-2 pb-4"
					>
						{#if dataModal[key].reference && dataModal[key].value}
							{#await getReferenceValue(dataModal[key])}
								<ProgressRadial width="w-6" />
							{:then rec}
								{rec?.row?.name}
							{/await}
						{:else if dataModal[key].type == 'text'}
							<textarea
								class="textarea w-full p-2 text-sm"
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
								class="input p-2 w-1/3 md:w-full text-sm"
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
								class="input p-2 w-1/3 md:w-full text-sm"
								type="number"
								id={dataModal[key].key}
								name={dataModal[key].key}
								bind:value={dataModal[key].value}
								on:change={() => {
									updateField(recordId, dataModal[key].key, dataModal[key].value);
								}}
							/>
						{:else if dataModal[key].type == 'boolean'}
							<RadioGroup
								active="variant-filled-primary"
								hover="hover:variant-soft-primary"
								class="text-sm"
							>
								<RadioItem
									bind:group={dataModal[key].value}
									id={dataModal[key].key}
									name={dataModal[key].key}
									value={1}
									on:change={() => {
										updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
									}}
								>
									<span class="text-sm">True</span>
								</RadioItem>
								<RadioItem
									bind:group={dataModal[key].value}
									id={dataModal[key].key}
									name={dataModal[key].key}
									value={0}
									on:change={() => {
										updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
									}}
								>
									<span class="text-sm">False</span>
								</RadioItem>
							</RadioGroup>
						{:else if dataModal[key].type == 'varchar'}
							{#if dataModal[key].key.indexOf('color') >= 0}
								<div class="grid grid-cols-[auto_1fr] gap-2">
									<input
										class="input text-sm"
										type="color"
										id={dataModal[key].key}
										name={dataModal[key].key}
										bind:value={dataModal[key].value}
										on:change={() => {
											updateField(recordId, dataModal[key].key, dataModal[key].value);
										}}
									/>
									<input
										class="input w-1/3 p-2 md:w-full text-sm"
										type="text"
										bind:value={dataModal[key].value}
										readonly
										tabindex="-1"
									/>
								</div>
							{:else if dataModal[key].key.indexOf('image') >= 0 || dataModal[key].key.indexOf('logo') >= 0 || dataModal[key].key.indexOf('icon') >= 0}
								<div class="flex flex-col gap-2 relative">
									<input
										id={dataModal[key].key}
										class="prevFileHidden"
										type="hidden"
										bind:value={dataModal[key].value}
									/>
									<input
										id={dataModal[key].key + `-input`}
										class="input w-full text-sm"
										type="file"
										on:change={(e) => onFileSelected(e, dataModal[key].key)}
									/>
									{#if dataModal[key].value}
										<em class="text-sm">
											⚠️ Warning: Old file will be deleted from the server whenever new file has
											been uploaded.
										</em>
									{/if}
									<input
										id={dataModal[key].key + `-base64`}
										name={dataModal[key].key + `-base64`}
										type="hidden"
									/>
									<div class="w-full relative">
										<img
											id={dataModal[key].key + `-img`}
											name={dataModal[key].key + `-img`}
											src={dataModal[key].value}
											style="max-width: 50ch;"
											class="w-full rounded"
											alt=""
										/>
										{#if dataModal[key].value}
											<div class="absolute top-1 right-1 flex flex-row-reverse">
												<!-- {dataModal[key].value} -->
												<button
													class="btn-icon variant-soft h-4 w-4 p-3 text-white justify-center items-center content-center border-none rounded"
													on:click={() => {
														modalStore.trigger({
															type: 'confirm',
															// Data
															title: 'Please Confirm',
															body: 'Are you sure you wish to proceed?',
															// TRUE if confirm pressed, FALSE if cancel pressed
															response: (r) => {
																if (r) {
																	deletePrevFile(dataModal[key].key);
																	dataModal[key].value = '';
																	updateField(recordId, dataModal[key].key, dataModal[key].value);
																	toastStore.trigger({
																		message: 'Image deleted!',
																		timeout: 2000,
																		background: 'variant-filled-success'
																	});
																}
															}
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
													use:clipboard={dataModal[key].value}
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
								<!-- {:else if dataModal[key].type == 'boolean'}
								<RadioGroup
									active="variant-filled-primary"
									hover="hover:variant-soft-primary"
									class="text-sm"
								>
									<RadioItem
										bind:group={dataModal[key].value}
										id={dataModal[key].key}
										name={dataModal[key].key}
										value={'1'}
										on:change={() => {
											updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
										}}>TRUE</RadioItem
									>
									<RadioItem
										bind:group={dataModal[key].value}
										id={dataModal[key].key}
										name={dataModal[key].key}
										value={'0'}
										on:change={() => {
											updateField(dataModal[key].id, dataModal[key].key, dataModal[key].value);
										}}>FALSE</RadioItem
									>
								</RadioGroup> -->
							{:else if dataModal[key].key == 'id' || dataModal[key].key == 'uuid'}
								<input
									class="input p-2 w-full text-sm"
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
									class="select w-1/3 md:w-full text-sm"
									bind:value={dataModal[key].value}
									on:change={() => {
										updateField(recordId, dataModal[key].key, dataModal[key].value);
									}}
								>
									<option value={''}>-- NULL --</option>
									{#each tableSchema[dataModal[key].key]?.validations?.isIn as optiongroup}
										{#each optiongroup as option}
											<option value={option} class="capitalize">{option}</option>
										{/each}
									{/each}
								</select>
							{:else if dataModal[key].key.indexOf('description') >= 0 || dataModal[key].key.indexOf('excerpt') >= 0}
								<textarea
									class="textarea w-full p-2 text-sm"
									rows="5"
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
									class="input p-2 w-full text-sm"
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
										// console.log(isValid);
										if (isValid) {
											if (
												tableSchema[dataModal[key].key]?.nullable == false &&
												e.target.value.trim() == ''
											) {
												alert('Value should not be blank!');
											} else updateField(recordId, dataModal[key].key, dataModal[key].value);
										} else {
											alert('Invalid input format or value! Regex: ' + regex);
										}
									}}
								/>
							{/if}
						{/if}
					</div>
				</li>
			{/each}
		</ol>
		<!-- <div class="infinity-loader reached-infinity py-10" /> -->
	</section>
{/if}
