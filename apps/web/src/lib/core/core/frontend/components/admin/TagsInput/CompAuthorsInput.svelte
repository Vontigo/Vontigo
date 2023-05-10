<script lang="ts">
	import { InputChip } from '@skeletonlabs/skeleton';
	import ObjectID from 'bson-objectid';
	import { onMount } from 'svelte';
	import Tags from 'svelte-tags-input';
	import { Autocomplete } from '@skeletonlabs/skeleton';
	import type { AutocompleteOption } from '@skeletonlabs/skeleton';

	const table: string = 'posts_authors';
	export let postId: string;

	let data: any;
	let oldTaglist: string[] = [];
	let taglist: string[] = [];
	let tagWhitelist: AutocompleteOption[] = [];
	let inputChip = '';

	let showAutocomplete = false;

	onMount(async () => {
		getAllTags();
		getPostsTags(postId);
	});

	async function getAllTags() {
		const tagsResponse = await fetch(`/api/admin/users`);
		const tagsData = await tagsResponse.json();
		data = tagsData;
		tagWhitelist = tagsData.map((tag: string) => {
			return { label: tag.name, value: tag.name, keywords: tag.slug, meta: { healthy: true } };
		});
	}

	async function getPostsTags(post_id: string) {
		const resPostsTags = await fetch(`/api/admin/${table}/${post_id}`);
		const resPostsTagsData = await resPostsTags.json();
		// console.log(resPostsTagsData);
		oldTaglist = resPostsTagsData.rows.map((tag: string) => {
			return tag.name;
		});
		taglist = resPostsTagsData.rows.map((tag: string) => {
			return tag.name;
		});
	}

	let timeoutId;
	$: if (taglist) {
		clearTimeout(timeoutId);
		timeoutId = setTimeout(async () => {
			if (postId && JSON.stringify(taglist) != JSON.stringify(oldTaglist)) {
				// const filteredItems = data.filter((item) => taglist.includes(item.name));

				const filteredItems = data
					.map((item, index) => ({ item, index })) // Add an index property to each item
					.filter(({ item }) => taglist.includes(item.name)) // Filter by name
					.sort((a, b) => taglist.indexOf(a.item.name) - taglist.indexOf(b.item.name)) // Sort by original order
					.map(({ item }) => item); // Remove the index property from each item

				const tagsJson = filteredItems.map((item, index) => {
					return {
						id: new ObjectID().toHexString(),
						post_id: postId,
						author_id: item.id,
						sort_order: index
					};
				});
				if (tagsJson.length > 0) {
					const requestOptions = {
						method: 'POST',
						headers: { 'Content-Type': 'application/json' },
						body: JSON.stringify(tagsJson)
					};
					const response = await fetch(`/api/admin/${table}/${postId}`, requestOptions);
					const responseData = await response.json();

					// console.log('response', response);
				}
			}
		}, 2500);
	}
	function onInputChipSelect(event: any): void {
		// console.log('onInputChipSelect', event.detail);
		if (taglist.includes(event.detail.value) === false) {
			taglist = [...taglist, event.detail.value];
			inputChip = '';
		}
		showAutocomplete = false;
	}
</script>

<!-- {JSON.stringify(taglist)} -->
<!-- <Tags
	bind:tags={taglist}
	autoComplete={tagWhitelist}
	onlyAutocomplete={true}
	onlyUnique={true}
	placeholder={'Type to add...'}
/> -->
<!-- <InputChip
	name="chips"
	bind:value={taglist}
	autoComplete={tagWhitelist}
	onlyAutocomplete={true}
	onlyUnique={true}
	class="text-sm"
	placeholder={'Type to add...'}
/> -->
<InputChip
	bind:input={inputChip}
	bind:value={taglist}
	name="chips"
	class="text-sm"
	on:input={(e) => {
		if (e.target.value.length > 0) {
			showAutocomplete = true;
		} else {
			showAutocomplete = false;
		}
	}}
/>

<div class="w-full max-w-sm max-h-48 px-2 mt-2 overflow-y-auto {showAutocomplete ? '' : 'hidden'}">
	<Autocomplete
		emptyState="No tags found."
		class="text-sm border-none "
		bind:input={inputChip}
		options={tagWhitelist}
		denylist={taglist}
		on:selection={onInputChipSelect}
	/>
</div>

<style lang="postcss">
	input {
		@apply text-sm;
	}
</style>
