<script lang="ts">
	import { AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';

	let repo: any;
	let releases: any;
	let contributors: any;

	onMount(async () => {
		const reqRepo = await fetch(`https://api.github.com/repos/vontigo/vontigo`);
		repo = await reqRepo.json();

		const reqReleases = await fetch(
			`https://api.github.com/repos/vontigo/vontigo/releases?per_page=5`
		);
		releases = await reqReleases.json();

		const reqContributors = await fetch(
			`https://api.github.com/repos/vontigo/vontigo/contributors`
		);
		contributors = await reqContributors.json();
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
			<header class="card-header">Start creating content</header>
			<section class="p-4">
				(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)
			</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
	</div>
	<div class="w-[40%] flex flex-col gap-4">
		<div class="card">
			<header class="card-header uppercase">Vontigo</header>
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
			<header class="card-header uppercase">Releases</header>
			<section class="p-4">
				{#await releases}
					loading...
				{:then items}
					<!-- {JSON.stringify(items)} -->
					{#if items}
						{#each items as item}
							{item.tag_name} <br />
						{/each}
					{/if}
				{/await}
			</section>
		</div>
		<div class="card">
			<header class="card-header uppercase">Contributors</header>
			<section class="p-4">
				{#await contributors}
					loading...
				{:then items}
					<!-- {JSON.stringify(items)} -->
					{#if items}
						{#each items as item}
							{item.login} <br />
						{/each}
					{/if}
				{/await}
			</section>
		</div>
	</div>
</div>
