<script lang="ts">
	import { page } from '$app/stores';
	import { language, site, siteUrl, origin } from '$lib/core/shared/stores/site';
	import { get } from 'svelte/store';

	export let type: string = '';
	let navigation: any = JSON.parse(
		type == 'secondary' ? get(site).secondary_navigation : get(site).navigation
	);
</script>

{#if navigation}
	<ul class="nav">
		{#each navigation as item}
			<li class="nav-{item.label}">
				{#if item.url == '/vontigo' || item.url == '/vontigo/'}
					<a data-sveltekit-reload href={$siteUrl + item.url}>Portal</a>
				{:else if item.url.indexOf('http') > -1}
					<a href={item.url} target="_blank">{item.label}</a>
				{:else}
					<a href={$siteUrl + item.url}>{item.label}</a>
				{/if}
			</li>
		{/each}
	</ul>
{/if}
