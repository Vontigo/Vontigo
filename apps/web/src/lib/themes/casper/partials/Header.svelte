<script lang="ts">
	import { page } from '$app/stores';
	import { language, site, siteUrl, origin, custom, member } from '$lib/core/shared/stores/site';
	import Navigation from './Navigation.svelte';
	import IconSearch from './icons/IconSearch.svelte';
	// let postUrl = $siteUrl + '/' + post.slug;
</script>

<header
	id="gh-head"
	class="gh-head outer{$custom.header_style.default == 'Hidden' ? 'is-header-hidden' : ''}"
>
	<div class="gh-head-inner inner">
		<div class="gh-head-brand">
			<a class="gh-head-logo{$site.logo == '' ? ' no-image' : ''}" href={$page.url.origin}>
				{#if $site.logo}
					<img src={$site.logo} alt={$site.title} />
				{:else}
					{$site.title}
				{/if}
			</a>
			<button class="gh-search gh-icon-btn" aria-label="Search this site" data-ghost-search
				><IconSearch /></button
			>
			<button class="gh-burger" />
		</div>

		<nav class="gh-head-menu">
			<Navigation />

			{#if !$site.members_enabled}
				{#if $custom.navigation_layout.default == 'Stacked'}
					<button class="gh-search gh-icon-btn" aria-label="Search this site" data-ghost-search
						><IconSearch /></button
					>
				{/if}
			{/if}
		</nav>

		<div class="gh-head-actions">
			<li class="language-switch" style="width: 10rem; text-align: right;">
				{$page.params.language ? $page.params.language : 'en-us'}
			</li>
			{#if !$site.members_enabled}
				{#if $custom.navigation_layout.default != 'Stacked'}
					<button class="gh-search gh-icon-btn" data-ghost-search><IconSearch /></button>
				{/if}
			{:else}
				<button class="gh-search gh-icon-btn" data-ghost-search><IconSearch /></button>
				<div class="gh-head-members">
					{#if !$member}
						{#if !$site.members_invite_only}
							<a class="gh-head-link" href="#/portal/signin" data-portal="signin">Sign in</a>
							<a class="gh-head-button" href="#/portal/signup" data-portal="signup">Subscribe</a>
						{:else}
							<a class="gh-head-button" href="#/portal/signin" data-portal="signin">Sign in</a>
						{/if}
					{:else}
						<a class="gh-head-button" href="#/portal/account" data-portal="account">Account</a>
					{/if}
				</div>
			{/if}
		</div>
	</div>
</header>

<style>
	.gh-head-menu {
		width: 100%;
	}
</style>
