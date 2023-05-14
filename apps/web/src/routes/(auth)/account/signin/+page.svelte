<script>
	export let data;
</script>

<div
	style="
    background: url('/bg-ai-head.gif');
    background-size: cover;"
>
	<div class="backdrop-blur-0 bg-white/80">
		<div class="max-w-screen-sm ml-auto flex h-screen backdrop-blur-sm">
			<div class="m-auto flex flex-col gap-6 w-56">
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
						<label class="section-header" for="input-password-for-credentials-provider"
							>Password</label
						><input
							name="password"
							id="input-password-for-credentials-provider"
							type="password"
							placeholder=""
							label="Password"
							class="input p-2 variant-form-material"
						/>
					</div>
					<button id="submitButton" type="submit" class="btn variant-filled mt-4">
						<span>Let me in</span>
						<span
							><svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1.5"
								stroke="currentColor"
								class="w-6 h-6"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"
								/>
							</svg>
						</span>
					</button>
					{#if data.error}
						<em> ⚠️ Error: {data.error} error! <br />Please try again.</em>
					{/if}
					<div class="text-center">
						<a data-sveltekit-reload href="/" class="unstyled">Back to home</a>
					</div>
				</form>
			</div>
		</div>
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
<style lang="postcss">
	input {
		@apply bg-transparent;
	}
	input:focus-visible {
		@apply outline-none;
	}
</style>
