<script>
	import { goto } from '$app/navigation';
</script>

<div class="max-w-screen-sm m-auto flex h-screen">
	<div class="m-auto flex flex-col gap-4">
		<h3>Step 3</h3>
		<button class="button" on:click={() => goto('/vontigo')}>Dashboard -></button>
	</div>
</div>
