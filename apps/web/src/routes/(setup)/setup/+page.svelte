<script lang="ts">
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';

	let formFields = {};

	let isSubmitted = false;
	let setupBody = {
		siteTitle: '',
		fullName: '',
		email: '',
		password: ''
	};
	let errorBody = {
		siteTitle: '',
		fullName: '',
		email: '',
		password: ''
	};

	let isValidEmail = false;
	function validateEmail() {
		const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		isValidEmail = regex.test(setupBody.email);
	}
</script>

<div class="max-w-screen-sm ml-auto flex h-screen backdrop-blur-sm">
	<div class="m-auto flex flex-col gap-6 px-20">
		<h3>Hi! Vontigoers!</h3>
		<em
			>Welcome to Vontigo, we're thrilled to have you join us and can't wait to see how you'll use
			our CMS to bring your website to life.</em
		>
		<div class="flex flex-col gap-4 md:max-w-[80%]">
			<div class="flex flex-col gap-2">
				<label>Site title<sup class="text-[red]">*</sup></label>
				<input
					on:change={(e) => {
						isSubmitted = false;
					}}
					bind:this={formFields.siteTitle}
					bind:value={setupBody.siteTitle}
					class="input p-2 variant-form-material {isSubmitted && errorBody.siteTitle != ''
						? 'input-error'
						: ''}"
					type="text"
					minlength="4"
					placeholder="My Voyage"
				/>
				{#if isSubmitted && errorBody.siteTitle != ''}
					<span class="text-[red]">{errorBody.siteTitle}</span>
				{/if}
			</div>
			<div class="flex flex-col gap-2">
				<label>Full name<sup class="text-[red]">*</sup></label>
				<input
					on:change={() => {
						isSubmitted = false;
					}}
					bind:this={formFields.fullName}
					bind:value={setupBody.fullName}
					class="input p-2 variant-form-material {isSubmitted && errorBody.fullName != ''
						? 'input-error'
						: ''}"
					type="text"
					minlength="2"
					placeholder="Huy Nguyen"
				/>
				{#if isSubmitted && errorBody.fullName != ''}
					<span class="text-[red]">{errorBody.fullName}</span>
				{/if}
			</div>
			<div class="flex flex-col gap-2">
				<label>Email address<sup class="text-[red]">*</sup></label>
				<input
					on:change={() => {
						isSubmitted = false;
						validateEmail();
					}}
					bind:this={formFields.email}
					bind:value={setupBody.email}
					class="input p-2 variant-form-material {isSubmitted && errorBody.email != ''
						? 'input-error'
						: ''}"
					type="email"
					minlength="4"
					placeholder="huy@example.com"
				/>
				{#if isSubmitted && errorBody.email != ''}
					<span class="text-[red]">{errorBody.email}</span>
				{/if}
			</div>
			<div class="flex flex-col gap-2">
				<label>Password<sup class="text-[red]">*</sup></label>
				<input
					on:change={() => {
						isSubmitted = false;
					}}
					bind:this={formFields.password}
					bind:value={setupBody.password}
					class="input p-2 variant-form-material {isSubmitted && errorBody.password != ''
						? 'input-error'
						: ''}"
					type="password"
					minlength="7"
					placeholder="At least 7 characters"
				/>
				{#if isSubmitted && errorBody.password != ''}
					<span class="text-[red]">{errorBody.password}</span>
				{/if}
			</div>
		</div>
		<div class="pt-4">
			<button
				class="btn variant-filled"
				on:click={async () => {
					if (!isSubmitted) {
						isSubmitted = true;
						for (let x in setupBody) {
							if (setupBody[x] == '') {
								errorBody[x] = 'Field required.';
							} else {
								if (setupBody[x].length < formFields[x].minLength || setupBody[x].length < 2) {
									errorBody[x] = `At least ${formFields[x].minLength} characters required.`;
								} else {
									errorBody[x] = '';
									if (x == 'email' && !isValidEmail) {
										errorBody[x] = 'Invalid email.';
									}
								}
							}
						}
						for (let x in errorBody) {
							if (errorBody[x] != '') {
								return;
							}
						}

						// if (setupBody.siteTitle == '') {
						// 	errorBody.siteTitle = 'Field required.';
						// 	return;
						// }
						// if (setupBody.fullName == '') {
						// 	return;
						// }
						// if (setupBody.email == '') {
						// 	return;
						// }
						// if (setupBody.password == '') {
						// 	return;
						// }
						// console.log('Submit');

						const requestOptions = {
							method: 'POST',
							headers: { 'Content-Type': 'application/json' },
							body: JSON.stringify(setupBody)
						};

						const request = await fetch(`/api/setup`, requestOptions);
						if (request) {
							const response = await request.json();
							if (response.code == 2000) {
								goto('/setup/done');
							}
						}
					}
				}}
			>
				<span>Continue</span>
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
		</div>
	</div>
</div>

<style lang="postcss">
	input {
		@apply bg-transparent;
	}
	input:focus-visible {
		@apply outline-none;
	}
</style>
