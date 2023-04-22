<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import { ListBox, ListBoxItem } from '@skeletonlabs/skeleton';
	import { popup } from '@skeletonlabs/skeleton';
	import type { PopupSettings } from '@skeletonlabs/skeleton';

	let menuAuthorsValue: string;
	let menuAuthors: PopupSettings = {
		event: 'focus-click',
		target: 'menuAuthors',
		placement: 'bottom',
		// Close the popup when the item is clicked
		closeQuery: '.listbox-item'
	};
</script>

<button type="button" class="btn btn-sm variant-soft" use:popup={menuAuthors}>
	<span>{menuAuthorsValue ?? 'All authors'}</span>
	<span><IconArrowDown /></span>
</button>
<div class="card w-48 shadow-sm py-2" data-popup="menuAuthors">
	<!-- Listbox -->
	<ListBox rounded="rounded-none">
		<ListBoxItem bind:group={menuAuthorsValue} name="medium" value="All">All authors</ListBoxItem>
	</ListBox>
	<!-- Arrow -->
	<div class="arrow bg-surface-100-800-token" />
</div>
