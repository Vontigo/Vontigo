<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import { ListBox, ListBoxItem } from '@skeletonlabs/skeleton';
	import { popup } from '@skeletonlabs/skeleton';
	import type { PopupSettings } from '@skeletonlabs/skeleton';

	let menuTagsValue: string;
	let menuTags: PopupSettings = {
		event: 'focus-click',
		target: 'menuTags',
		placement: 'bottom',
		// Close the popup when the item is clicked
		closeQuery: '.listbox-item'
	};
</script>

<button type="button" class="btn btn-sm variant-soft" use:popup={menuTags}>
	<span>{menuTagsValue ?? 'All tags'}</span>
	<span><IconArrowDown /></span>
</button>
<div class="card w-48 shadow-sm py-2" data-popup="menuTags">
	<!-- Listbox -->
	<ListBox rounded="rounded-none">
		<ListBoxItem bind:group={menuTagsValue} name="medium" value="All">All tags</ListBoxItem>
	</ListBox>
	<!-- Arrow -->
	<div class="arrow bg-surface-100-800-token" />
</div>
