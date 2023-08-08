<script>
	import { RevoGrid } from '@revolist/svelte-datagrid';
	import { defineCustomElements } from '@revolist/revogrid/loader';
	import { onMount } from 'svelte';

	const columns = [
		{
			prop: 'name',
			name: 'First'
		},
		{
			prop: 'details',
			name: 'Second',
			cellTemplate: (createElement, props) => {
				return createElement(
					'div',
					{
						style: {
							backgroundColor: 'gray'
						},
						class: {
							'inner-cell': true
						}
					},
					props.model[props.prop] || ''
				);
			}
		}
	];
	const rows = [
		{
			name: 'New item',
			details: 'Item description'
		}
	];

	onMount(async () => {
		// define webcomponent element in DOM
		await defineCustomElements();
	});
</script>

<!-- <RevoGrid
		bind:this={grid}
		source={rows}
		resize="true"
		columns={$columns}
		theme="compact"
		range
		rowClass="id"
		readonly
		{rowDefinitions}
		{editors}
		on:aftercolumnresize={onAfterColumnResize}
	/> -->
<RevoGrid source={rows} resize="true" {columns} theme="compact" />

<style>
	:global(revo-grid[theme='compact'] revogr-header .header-rgRow) {
		height: 32px;
	}

	:global(revo-grid[theme='compact'] revogr-header) {
		line-height: 32px;
	}

	:global(revo-grid .hovered .undb-select) {
		opacity: 1;
	}

	:global(revo-grid .hovered .undb-row-expand) {
		opacity: 1;
	}

	:global(revo-grid .hovered .undb-row-index) {
		display: none;
	}

	:global(revogr-header .header-rgRow) {
		background-color: #f7f7f7;
	}
	:global(.dark revogr-header .header-rgRow) {
		background-color: #374151;
	}

	:global(revogr-header .rgHeaderCell > .resizable-r) {
		width: 2px;
	}

	:global(revogr-focus) {
		border: 1px solid transparent;
	}

	:global(.dark .hovered) {
		background-color: var(--primary-color) !important;
	}

	:global(.dark revogr-data .rgRow.focused-rgRow) {
		background-color: #374151 !important;
	}

	:global(.dark revo-grid[theme='compact'] revogr-header .rgHeaderCell.focused-cell) {
		background-color: #374151 !important;
	}
</style>
