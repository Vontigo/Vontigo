<script lang="ts">
	import IconArrowDown from '$lib/icons/IconArrowDown.svelte';

	let menuMembersAccessValue: string = 'All access';
	
	function selectOption(value: string, label: string) {
		menuMembersAccessValue = label;
		// Close dropdown by removing focus
		const dropdown = document.activeElement as HTMLElement;
		dropdown?.blur();
	}
</script>

<div class="dropdown">
	<div tabindex="0" role="button" class="btn btn-sm btn-outline">
		<span>{menuMembersAccessValue}</span>
		<span><IconArrowDown /></span>
	</div>
	<ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-[1] w-48 p-2 shadow">
		<li><a href="#" on:click|preventDefault={() => selectOption('All', 'All access')}>All access</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Public', 'Public')}>Public</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Members-only', 'Members-only')}>Members-only</a></li>
		<li><a href="#" on:click|preventDefault={() => selectOption('Paid members-only', 'Paid members-only')}>Paid members-only</a></li>
	</ul>
</div>
