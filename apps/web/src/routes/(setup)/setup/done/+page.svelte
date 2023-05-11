<script>
	import { goto } from '$app/navigation';
</script>

<div class="max-w-screen-sm ml-auto flex h-screen backdrop-blur-sm">
	<div class="m-auto flex flex-col gap-6 px-20">
		<h3>All done! ; )</h3>
		<em>Your brand new voyage is set up and ready to go.<br /> Hope you enjoy it!</em>
		<div class="pt-4">
			<button class="btn variant-filled" on:click={() => goto('/vontigo')}>
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
