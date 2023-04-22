<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import { ListBox, ListBoxItem } from '@skeletonlabs/skeleton';
	import { popup } from '@skeletonlabs/skeleton';
	import type { PopupSettings } from '@skeletonlabs/skeleton';

	let menuMembersAccessValue: string;
	let menuMembersAccess: PopupSettings = {
		event: 'focus-click',
		target: 'menuMembersAccess',
		placement: 'bottom',
		// Close the popup when the item is clicked
		closeQuery: '.listbox-item'
	};
</script>

<button type="button" class="btn btn-sm variant-soft" use:popup={menuMembersAccess}>
	<span>{menuMembersAccessValue ?? 'All access'}</span>
	<span><IconArrowDown /></span>
</button>
<div class="card w-48 shadow-sm py-2" data-popup="menuMembersAccess">
	<!-- Listbox -->
	<ListBox rounded="rounded-none">
		<ListBoxItem bind:group={menuMembersAccessValue} name="medium" value="All"
			>All access</ListBoxItem
		>
		<ListBoxItem bind:group={menuMembersAccessValue} name="medium" value="Public"
			>Public</ListBoxItem
		>
		<ListBoxItem bind:group={menuMembersAccessValue} name="medium" value="Members-only">
			Members-only
		</ListBoxItem>
		<ListBoxItem bind:group={menuMembersAccessValue} name="medium" value="Paid members-only">
			Paid members-only
		</ListBoxItem>
	</ListBox>
	<!-- Arrow -->
	<div class="arrow bg-surface-100-800-token" />
</div>
