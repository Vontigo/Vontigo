<script>
	import { RevoGrid } from '@revolist/svelte-datagrid';
	import { defineCustomElements } from '@revolist/revogrid/loader';
	import { onMount } from 'svelte';
	import { AppBar } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';

	const columns = [
		{
			prop: 'name',
			name: 'First'
		},
		{
			prop: 'details',
			name: 'Second'
			// cellTemplate: (createElement, props) => {
			// 	return createElement(
			// 		'div',
			// 		{
			// 			style: {
			// 				backgroundColor: 'gray'
			// 			},
			// 			class: {
			// 				'inner-cell': true
			// 			}
			// 		},
			// 		props.model[props.prop] || ''
			// 	);
			// }
		},
		{
			prop: 'id',
			name: 'Id'
		}
	];
	const rows = [
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
		// define webcomponent element in DOM
		await defineCustomElements();
	});
</script>

<RevoGrid source={rows} resize="true" {columns} theme="compact" />
