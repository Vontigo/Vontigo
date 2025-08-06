<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';

	let menuSortByValue: string = 'Newest';
	
	function selectOption(value: string, label: string) {
		menuSortByValue = label;
		// Close dropdown by removing focus
		const dropdown = document.activeElement as HTMLElement;
		dropdown?.blur();
	}
</script>

<div class="dropdown">
	<div tabindex="0" role="button" class="btn btn-sm btn-outline">
		<span>Sort by: {menuSortByValue}</span>
		<span><IconArrowDown /></span>
	</div>
	<ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-[1] w-48 p-2 shadow">
		<li><a href="#" on:click|preventDefault={() => selectOption('Newest', 'Newest')}>Newest</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Oldest', 'Oldest')}>Oldest</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Recently updated', 'Recently updated')}>Recently updated</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Open rate', 'Open rate')}>Open rate</a></li>
	</ul>
</div>
