<script lang="ts">
	import { AppBar, AppShell, Avatar } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';

	let repo: any;
	let releases: any[];
	let contributors: any[];

	onMount(async () => {
		const reqRepo = await fetch(`https://api.github.com/repos/vontigo/vontigo`);
		repo = await reqRepo.json();

		const reqReleases = await fetch(
			`https://api.github.com/repos/vontigo/vontigo/releases?per_page=5`
		);
		releases = (await reqReleases.json()) || [];

		const reqContributors = await fetch(
			`https://api.github.com/repos/vontigo/vontigo/contributors`
		);
		contributors = (await reqContributors.json()) || [];
	});
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold mb-1">Dashboard</h2></li>
		<!-- <li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">{$page.params.group || ''}</li> -->
	</ol>
</AppBar>
<div class="max-w-screen-xl mx-auto px-12 flex gap-8">
	<div class="w-[60%] flex flex-col gap-4">
		<div class="card">
			<header class="card-header font-medium flex gap-2">
				<svg
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
						d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125"
					/>
				</svg>

				Start creating content
			</header>
			<section class="p-4" />
			<footer class="card-footer">(footer)</footer>
		</div>
	</div>
	<div class="w-[40%] flex flex-col gap-4">
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
				</svg>
				Vontigo
			</header>
			<section class="p-4">
				{#await repo}
					loading...
				{:then item}
					{#if item?.description}
						{item.description}
					{/if}
				{/await}
			</section>
		</div>
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<svg
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
						d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z"
					/>
				</svg>
				Releases
			</header>
			<section class="p-4">
				{#if releases?.length}
					{#each releases as item}
						{item.tag_name} <br />
					{/each}
				{/if}
			</section>
		</div>
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<svg
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
						d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"
					/>
				</svg>
				Contributors
			</header>
			<section class="p-4">
				{#if contributors?.length}
					{#each contributors as item}
						{item.login} <br />
					{/each}
				{/if}
			</section>
		</div>
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<span class="">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1.5"
						stroke="red"
						class="w-6 h-6"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"
						/>
					</svg>
				</span>

				Sponsor
			</header>
			<section class="p-4">
				<ul class="list">
					<li>
						<span>
							<Avatar src="/img/logo/opencollective.png" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://opencollective.com/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							Open Collective
						</a>
					</li>
					<li>
						<span>
							<Avatar src="/img/logo/thelinuxfoundation.jpg" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://crowdfunding.lfx.linuxfoundation.org/projects/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							The Linux Foundation
						</a>
					</li>
					<li>
						<span>
							<Avatar src="/img/logo/patreon.png" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://patreon.com/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline">Patreon</a
						>
					</li>
					<li>
						<span>
							<Avatar src="/img/logo/paypal.jpg" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://www.paypal.me/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline">Paypal</a
						>
					</li>
					<li>
						<span>
							<Avatar src="/img/logo/buymeacoffee.png" width="w-8" rounded="rounded-full" /></span
						>
						<a
							href="https://www.buymeacoffee.com/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							Buy me a ☕
						</a>
					</li>
					<!-- ... -->
				</ul>
			</section>
		</div>
	</div>
</div>
