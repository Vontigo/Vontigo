<script>
	import { RevoGrid } from '@revolist/svelte-datagrid';
	import { defineCustomElements } from '@revolist/revogrid/loader';
	import { onMount } from 'svelte';

	let source = [
		{
			prop: 'name',
			name: 'First'
		},
		{
			prop: 'details',
			name: 'Second'
		}
	];
	let headers = [
		{
			name: '1',
			details: 'Item 1'
		}
	];

	onMount(async () => {
		// define webcomponent element in DOM
		await defineCustomElements();
	});
</script>

<RevoGrid {source} resize="true" columns={headers} theme="material" />
