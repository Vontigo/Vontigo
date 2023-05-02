<script>
	export let data;
</script>

<div class="max-w-screen-sm m-auto flex h-screen">
	<div class="m-auto flex flex-col gap-6 px-20">
		<h3>Hi! : )</h3>
		<form action="/auth/callback/credentials" method="POST" class="flex flex-col gap-4">
			<input type="hidden" name="csrfToken" value={data.csrfToken} />
			<div>
				<label class="section-header" for="input-username-for-credentials-provider">Email</label
				><input
					name="username"
					id="input-username-for-credentials-provider"
					type="text"
					placeholder=""
					label="Username"
					class="input p-2 variant-form-material"
				/>
			</div>
			<div>
				<label class="section-header" for="input-password-for-credentials-provider">Password</label
				><input
					name="password"
					id="input-password-for-credentials-provider"
					type="password"
					placeholder=""
					label="Password"
					class="input p-2 variant-form-material"
				/>
			</div>
			<button id="submitButton" type="submit" class="btn variant-filled">Signin -></button>
			{#if data.error}
				<em> ⚠️ Error: {data.error} error! <br />Please try again.</em>
			{/if}
			<div class="text-center">
				<a data-sveltekit-reload href="/">Back to home.</a>
			</div>
		</form>
	</div>
</div>

<!-- 
<button
	type="button"
	on:click={async () => {
		const credentials = {
			username: 'huy@vontigo.org',
			password: 'P@ssw0rd'
		};
		const authResponse = await fetch('/auth/callback/credentials', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(credentials)
		});

		if (!authResponse.ok) {
			return null;
		}

		const user = await authResponse.json();
		console.log(user);
		alert(user);
	}}>Login</button
> -->
