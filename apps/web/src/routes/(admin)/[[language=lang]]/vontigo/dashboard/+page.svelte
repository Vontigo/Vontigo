<script lang="ts">
	import { AppBar, AppShell, Avatar } from '@skeletonlabs/skeleton';
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
			<header class="card-header font-medium">Start creating content</header>
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
						d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"
					/>
				</svg>

				Sponsor
			</header>
			<section class="p-4">
				<ul class="list">
					<li>
						<span>
							<Avatar
								src="data:image/png;base64,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"
								width="w-8"
								rounded="rounded-full"
							/>
						</span>
						<span class="flex-auto">Opencollective</span>
					</li>
					<li>
						<span>
							<Avatar
								src="data:image/png;base64,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"
								width="w-8"
								rounded="rounded-full"
							/>
						</span>
						<span class="flex-auto">Communitybridge</span>
					</li>
					<li>
						<span>
							<Avatar
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAkFBMVEX/Qk3///8kHhL/RFC+NjscHRBbJR8EHA3/QUz/PEj/LDr/Okb/MT//P0r/O0f/NEH/KDf/8/T/ZW3/zc//5OX/+fr/f4X/w8X/n6T/c3r/vL//2tz/6On/0tQAGQFMIxz/lJn/tLf/rbD/VV//Xmb/vcD/cXj/S1X/jJH/jZL/mp//goj/a3L/pqr/WGH/eoGgkOELAAAEsUlEQVR4nO2d3VbbOhBGrUPPqfVn2XEMhCRtElJCCTTv/3YlpBy62pCMZGlst9++4Y7FXpIsaTQzZBkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD84Vwcxfe35FY7o5R54fmn0zJP8dcG8OHTxyN89lKUThWjxbIeV414pqnG9XLxKJWTqf5qHz58/Od3/v2PbliYcrIciyOMlztlis6Hsp2hdWZ3dczulfrSOJvW4BxtDK3JVtUpvz3VamM6dQw3tGZzcvjeuLrt0jHY0NkvNL8XxwvX2XoMNJTqmu6350l19WENM3TrmZ+gELOR4TH6lRBDW3oO4I9hLDtZjQGGUs9DBIWYyi5mqr+hvj27Q7xH9U3zmb3ibegeQ/32TByj2wFfQ7drIyjEJfv3xtPQXbYTFGLLPYp+hnrSVlCIHbOil2Gxbi8oxIj3c+NjaLMmhmGzYd0XfQzV0WugPzPFeUj1MFTLOIJCfFG9NIzxlXllx7gUyYa5i7IIDzSab56SDc1NPMHnCyPfPKUa2igbxRsjtkM41bCcxjUcsw0i0bCI+Jk5cFn0yzDWVvjGrOyVobyLLfi8YzANIs1QBd7qTzFlWokkQ7uJLyjELc/xlGToVikMlzzXKJKhCo7MnKLimaYUQztKISjEI8uuTzFMM0m5pinFMP5meGDGMk0JhrlMIyjEBcfXlGAoWwYQ34fl5EYwTLUMhVhxLESCoalTGc45wsMEQ+X9kkaFZUekGKYSFILjZfi8YZpD6QGOyCnBMNGJZg/Hqea8oYx+vX+DY7s4b1hs0xneM8RNzxvq+3SGX/94w0U/DBPO0n6MYdH62fd9+rEOU8TZXtn1YreIHc//mXUvdvw8S2fIcUEknEvLZIJNP86lyYIYTGEMyg2YmCjrT92T+6EOykSk8MTx2E0wTHe5uOMImFJibSaVIctrPiVeahK8PO3heX2iGOqHNIbXLDknpHeLRHEMnuwv2ttTkh2RKVmBZKgXKQwfeBKjSIa5S2FoefKiaO/4LmpC1IErpnxomqG9jW/I9IxPzqeJ/nZRcyVFEQ3jDyLH5dfHMDMelWoU+JITybmJNq5hxpbrTc4vdVH3xAe+kgR6FnTM/Eu+3Esfw5inU856BI9c/XjB73vOshmveotIJxvWYgS/qqA4S3HMWlDiZ2hdhKSFSvMWy/rVrtm8dZZiw5IIFWyYyU1LxWbDXQvsW0Mqs1aKFbugfx2wlS1CGjPLX83tX8ttw29SdRf9MQLq8fMyMLp4XXbRHCOoa4RbByzGqqO2EWF9MaTyzshcdtX6I7C3SW7WXueb8dp01b4luD+NLXfkA85sW3bXFKtFF6Wi3JI2jvFWddAO439adcLSanT2ffjqsVO/1t3MpNH3J7bH+Vdtum7a1rpfW66Nu3ua/lYG3UxXE2cYK5rfo7Vhti/IcKa8mCxWN/V8Pp3XN6uH3aY0rh+NBWMYvmCldu7QN9E5LTtuQ/cT0Qx7CwyHDwyHDwyHDwyHDwyHDwyHDwyHDwyHDwyHDwyHDwyHDwyHDwyHz19gGOH/PfWcOP+zCwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBRvgPS3mCEJuMAhAAAAABJRU5ErkJggg=="
								width="w-8"
								rounded="rounded-full"
							/>
						</span>
						<span class="flex-auto">Patreon</span>
					</li>
					<li>
						<span>
							<Avatar
								src="https://1000logos.net/wp-content/uploads/2017/05/emblem-Paypal.jpg"
								width="w-8"
								rounded="rounded-full"
							/>
						</span>
						<span class="flex-auto">Paypal</span>
					</li>
					<li>
						<span>
							<Avatar
								src="data:image/png;base64,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"
								width="w-8"
								rounded="rounded-full"
							/></span
						>
						<span class="flex-auto">Buymeacoffee</span>
					</li>
					<!-- ... -->
				</ul>
			</section>
		</div>
	</div>
</div>
