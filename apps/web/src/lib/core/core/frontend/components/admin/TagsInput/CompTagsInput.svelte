<script lang="ts">
	import ObjectID from 'bson-objectid';
	import { onMount } from 'svelte';

	const table: string = 'posts_tags';
	export let postId: string;

	let data: any;
	let oldTaglist: string[] = [];
	let taglist: string[] = [];
	let tagWhitelist: any[] = [];
	let inputValue = '';
	let filteredOptions: any[] = [];
	let showAutocomplete = false;

	onMount(async () => {
		getAllTags();
		getPostsTags(postId);
	});

	async function getAllTags() {
		const tagsResponse = await fetch(`/api/admin/tags/public`);
		const tagsData = await tagsResponse.json();
		data = tagsData;
		tagWhitelist = tagsData.map((tag: any) => {
			return { label: tag.name, value: tag.name, keywords: tag.slug, meta: { healthy: true } };
		});
	}

	async function getPostsTags(post_id: string) {
		const resPostsTags = await fetch(`/api/admin/${table}/${post_id}`);
		const resPostsTagsData = await resPostsTags.json();

		oldTaglist = resPostsTagsData.rows.map((tag: any) => {
			return tag.name;
		});
		taglist = resPostsTagsData.rows.map((tag: any) => {
			return tag.name;
		});
	}

	let timeoutId: any;
	$: if (taglist) {
		clearTimeout(timeoutId);
		timeoutId = setTimeout(async () => {
			if (postId && JSON.stringify(taglist) != JSON.stringify(oldTaglist)) {
				const filteredItems = data
					.map((item: any, index: number) => ({ item, index }))
					.filter(({ item }: any) => taglist.includes(item.name))
					.sort((a: any, b: any) => taglist.indexOf(a.item.name) - taglist.indexOf(b.item.name))
					.map(({ item }: any) => item);

				const tagsJson = filteredItems.map((item: any, index: number) => {
					return {
						id: new ObjectID().toHexString(),
						post_id: postId,
						tag_id: item.id,
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
				}
			}
		}, 2500);
	}

	function onInput() {
		if (inputValue.length > 0) {
			filteredOptions = tagWhitelist.filter(option => 
				!taglist.includes(option.value) && 
				option.label.toLowerCase().includes(inputValue.toLowerCase())
			);
			showAutocomplete = filteredOptions.length > 0;
		} else {
			showAutocomplete = false;
		}
	}

	function addTag(tag: string) {
		if (!taglist.includes(tag)) {
			taglist = [...taglist, tag];
		}
		inputValue = '';
		showAutocomplete = false;
	}

	function removeTag(index: number) {
		taglist = taglist.filter((_, i) => i !== index);
	}

	function onKeydown(event: KeyboardEvent) {
		if (event.key === 'Enter' && inputValue.trim()) {
			event.preventDefault();
			if (filteredOptions.length > 0) {
				addTag(filteredOptions[0].value);
			} else {
				addTag(inputValue.trim());
			}
		}
	}
</script>

<div class="w-full">
	<!-- Tags Display -->
	<div class="flex flex-wrap gap-2 mb-2">
		{#each taglist as tag, index}
			<div class="badge badge-primary gap-2">
				{tag}
				<button class="btn btn-ghost btn-xs" on:click={() => removeTag(index)}>✕</button>
			</div>
		{/each}
	</div>

	<!-- Input Field -->
	<div class="relative">
		<input
			type="text"
			bind:value={inputValue}
			on:input={onInput}
			on:keydown={onKeydown}
			placeholder="Type to add tags..."
			class="input input-bordered w-full text-sm"
		/>

		<!-- Autocomplete Dropdown -->
		{#if showAutocomplete}
			<div class="absolute z-10 w-full bg-base-100 border border-base-300 rounded-box shadow-lg max-h-48 overflow-y-auto mt-1">
				{#if filteredOptions.length > 0}
					{#each filteredOptions as option}
						<button
							class="block w-full text-left px-4 py-2 hover:bg-base-200 text-sm"
							on:click={() => addTag(option.value)}
						>
							{option.label}
						</button>
					{/each}
				{:else}
					<div class="px-4 py-2 text-sm text-base-content/60">No tags found.</div>
				{/if}
			</div>
		{/if}
	</div>
</div>

<style lang="postcss">
</style>
