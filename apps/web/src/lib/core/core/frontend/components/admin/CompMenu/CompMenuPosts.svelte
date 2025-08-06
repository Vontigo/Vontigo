<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';

	let menuPostsValue: string = 'All posts';
	
	function selectOption(value: string, label: string) {
		menuPostsValue = label;
		// Close dropdown by removing focus
		const dropdown = document.activeElement as HTMLElement;
		dropdown?.blur();
	}
</script>

<div class="dropdown">
	<div tabindex="0" role="button" class="btn btn-sm btn-outline">
		<span>{menuPostsValue}</span>
		<span><IconArrowDown /></span>
	</div>
	<ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-[1] w-48 p-2 shadow">
		<li><a href="#" on:click|preventDefault={() => selectOption('All', 'All posts')}>All posts</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Draft', 'Draft posts')}>Draft posts</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Published', 'Published posts')}>Published posts</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Scheduled', 'Scheduled posts')}>Scheduled posts</a></li>
	</ul>
</div>
