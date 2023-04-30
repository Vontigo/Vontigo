<script>
	import { goto } from '$app/navigation';
	import { isSignedIn } from '$lib/core/shared/stores/site';
</script>

<div>
	Signin
	<button
		type="button"
		on:click={() => {
			$isSignedIn = true;
			goto('/vontigo/dashboard');
		}}>Signin</button
	>
</div>
