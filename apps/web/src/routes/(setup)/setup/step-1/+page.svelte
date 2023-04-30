<script>
	import { goto } from '$app/navigation';
</script>

<div class="max-w-screen-sm m-auto flex h-screen">
	<div class="m-auto flex flex-col gap-4">
		<h3>Step 1</h3>
		<button class="button" on:click={() => goto('/setup/step-2')}>Continue -></button>
	</div>
</div>
