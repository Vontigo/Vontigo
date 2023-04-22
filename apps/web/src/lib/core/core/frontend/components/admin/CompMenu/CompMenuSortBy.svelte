<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import { ListBox, ListBoxItem } from '@skeletonlabs/skeleton';
	import { popup } from '@skeletonlabs/skeleton';
	import type { PopupSettings } from '@skeletonlabs/skeleton';

	let menuSortByValue: string;
	let menuSortBy: PopupSettings = {
		event: 'focus-click',
		target: 'menuSortBy',
		placement: 'bottom',
		// Close the popup when the item is clicked
		closeQuery: '.listbox-item'
	};
</script>

<button type="button" class="btn btn-sm variant-soft" use:popup={menuSortBy}>
	<span>Sort by: {menuSortByValue ?? 'None'}</span>
	<span><IconArrowDown /></span>
</button>
<div class="card w-48 shadow-sm py-2" data-popup="menuSortBy">
	<!-- Listbox -->
	<ListBox rounded="rounded-none">
		<ListBoxItem bind:group={menuSortByValue} name="medium" value="All">Newest</ListBoxItem>
		<ListBoxItem bind:group={menuSortByValue} name="medium" value="Draft">Oldest</ListBoxItem>
		<ListBoxItem bind:group={menuSortByValue} name="medium" value="Published">
			Recently updated
		</ListBoxItem>
		<ListBoxItem bind:group={menuSortByValue} name="medium" value="Scheduled">
			Open rate
		</ListBoxItem>
	</ListBox>
	<!-- Arrow -->
	<div class="arrow bg-surface-100-800-token" />
</div>
