<script>
	import { goto } from '$app/navigation';
</script>

<div class="max-w-screen-sm m-auto flex h-screen">
	<div class="m-auto flex flex-col gap-6 px-20">
		<h3>All done!</h3>
		<em>Your brand new voyage is set up and ready to go. Hope you enjoy it!</em>
		<div class="pt-4">
			<button class="btn variant-filled" on:click={() => goto('/vontigo')}>Continue -></button>
		</div>
	</div>
</div>
