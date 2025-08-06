<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';

	let menuTagsValue: string = 'All tags';
	
	function selectOption(value: string, label: string) {
		menuTagsValue = label;
		// Close dropdown by removing focus
		const dropdown = document.activeElement as HTMLElement;
		dropdown?.blur();
	}
</script>

<div class="dropdown">
	<div tabindex="0" role="button" class="btn btn-sm btn-outline">
		<span>{menuTagsValue}</span>
		<span><IconArrowDown /></span>
	</div>
	<ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-[1] w-48 p-2 shadow">
		<li><a href="#" on:click|preventDefault={() => selectOption('All', 'All tags')}>All tags</a></li>
	</ul>
</div>
