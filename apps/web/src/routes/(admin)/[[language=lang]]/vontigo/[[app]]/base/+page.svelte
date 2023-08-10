<script lang="ts">
	import { RevoGrid } from '@revolist/svelte-datagrid';
	import { defineCustomElements } from '@revolist/revogrid/loader';
	import { onMount } from 'svelte';
	import { AppBar } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { recordPostsDataModal } from '$lib/core/shared/stores/site';

	let reqData = [];
	let columns = [];
	let rows = [
		{
			name: 'New item 1',
			details: 'Item description'
		},
		{
			name: 'New item 2',
			details: 'Item description',
			id: 0
		}
	];

	onMount(async () => {
		const response = await fetch(`/api/database/posts/read`);
		reqData = await response.json();

		// console.log(reqData.rows);

		const structureRes = await fetch(`/api/database/posts`);
		const structureData = await structureRes.json();

		if (structureData.length > 0) {
			structureData.forEach((value: any, key: any) => {
				//$recordPostsDataModal[value.key] = value;
				columns.push({
					prop: value.key,
					name: value.key
				});

				console.log(columns);
			});
		}

		// const resPostsSchema = await fetch(`/api/admin/posts/${$page.params.type}/new/${id}`);
		// const dataPostsSchema = await resPostsSchema.json();

		// console.log(dataPostsSchema);

		// define webcomponent element in DOM
		await defineCustomElements();
	});
</script>

{#if columns}
	<RevoGrid source={reqData.rows} resize="true" {columns} theme="compact" />
{/if}
