<script lang="ts">
	import { page } from '$app/stores';
	import { signIn, signOut } from '@auth/sveltekit/client';
	import { language, site, siteUrl, origin, theme, member } from '$lib/core/shared/stores/site';
	import Navigation from './Navigation.svelte';
	import IconSearch from './icons/IconSearch.svelte';
	// let postUrl = $siteUrl + '/' + post.slug;
	export let isNavOpen: boolean = false;
</script>

<header
	id="gh-head"
	class="gh-head outer{$theme.custom.header_style.default == 'Hidden' ? 'is-header-hidden' : ''}"
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
			<!-- <button class="gh-search gh-icon-btn" aria-label="Search this site" data-ghost-search
				><IconSearch /></button
			> -->
			<div />
			<button
				class="gh-burger"
				on:click={() => {
					isNavOpen = !isNavOpen;
				}}
			/>
		</div>

		<nav class="gh-head-menu">
			<Navigation />

			{#if !$site.members_enabled}
				{#if $theme.custom.navigation_layout.default == 'Stacked'}
					<button class="gh-search gh-icon-btn" aria-label="Search this site" data-ghost-search>
						<IconSearch />
					</button>
				{/if}
			{/if}
		</nav>

		<div class="gh-head-actions">
			{#if $page.data.session}
				{#if $page.data.session.user?.image}
					<!-- <div class=" relative inline-block">
						<span class="badge-icon variant-filled-success absolute -top-0 -right-0 z-10 w-3 h-3" />
						<img src={$page.data.session.user.image} />
					</div> -->
					<div
						class="gh-user-avatar relative"
						style="background-image: url(
							{$page.data.session.user.image}
							); width:40px; height:40px; background-size: 40px; border-radius: 9999px;"
					>
						<span class="absolute dib ba b--white br-100 gh-whats-new-badge-account" />
					</div>
				{/if}
				<span class="signedInText">
					<small>Signed in as</small><br />
					<a class="gh-head-link" data-sveltekit-reload href="/vontigo">
						<strong>{$page.data.session.user?.name ?? 'User'}</strong>
					</a>
				</span>
				<a href="#signout" on:click={() => signOut()} class="gh-head-link">Sign out</a>
			{:else}
				<!-- <span class="notSignedInText">You are not signed in</span> -->
				<a href="#signin" class="gh-head-link" on:click={() => signIn('google')}>Sign In</a>
			{/if}
			<!-- <li class="language-switch" style="width: 10rem; text-align: right;">
				{($page.params.language ? $page.params.language : 'en-us').toUpperCase()}
			</li> -->
			{#if !$site.members_enabled}
				{#if $theme.custom.navigation_layout.default != 'Stacked'}
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
