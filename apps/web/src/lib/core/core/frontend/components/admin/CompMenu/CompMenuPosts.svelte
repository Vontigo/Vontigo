<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';
	import { ListBox, ListBoxItem } from '@skeletonlabs/skeleton';
	import { popup } from '@skeletonlabs/skeleton';
	import type { PopupSettings } from '@skeletonlabs/skeleton';

	let menuPostsValue: string;
	let menuPosts: PopupSettings = {
		event: 'focus-click',
		target: 'menuPosts',
		placement: 'bottom',
		// Close the popup when the item is clicked
		closeQuery: '.listbox-item'
	};
</script>

<button type="button" class="btn btn-sm variant-soft" use:popup={menuPosts}>
	<span>{menuPostsValue ?? 'All posts'}</span>
	<span><IconArrowDown /></span>
</button>
<div class="card w-48 shadow-sm py-2" data-popup="menuPosts">
	<!-- Listbox -->
	<ListBox rounded="rounded-none">
		<ListBoxItem bind:group={menuPostsValue} name="medium" value="All">All posts</ListBoxItem>
		<ListBoxItem bind:group={menuPostsValue} name="medium" value="Draft">Draft posts</ListBoxItem>
		<ListBoxItem bind:group={menuPostsValue} name="medium" value="Published">
			Published posts
		</ListBoxItem>
		<ListBoxItem bind:group={menuPostsValue} name="medium" value="Scheduled">
			Scheduled posts
		</ListBoxItem>
	</ListBox>
	<!-- Arrow -->
	<div class="arrow bg-surface-100-800-token" />
</div>
