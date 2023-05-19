<script lang="ts">
	// Your selected Skeleton theme:
	// import '@skeletonlabs/skeleton/themes/theme-crimson.css';
	import './vontigo.css';
	// This contains the bulk of Skeletons required styles:
	import '@skeletonlabs/skeleton/styles/all.css';
	// Finally, your application's global stylesheet (sometimes labeled 'app.css')
	import './app.postcss';

	import {
		Accordion,
		AccordionItem,
		AppBar,
		AppShell,
		Avatar,
		filter
	} from '@skeletonlabs/skeleton';
	import { LightSwitch } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import {
		language,
		origin,
		siteUrl,
		STORE_ADMIN_SITE_URL,
		isSignedIn
	} from '$lib/core/shared/stores/site';
	import IconHome from '$lib/icons/IconHome.svelte';
	import IconWindow from '$lib/icons/IconWindow.svelte';
	import IconContent from '$lib/icons/IconContent.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconTag from '$lib/icons/IconTag.svelte';
	import IconUsers from '$lib/icons/IconUsers.svelte';

	import { computePosition, autoUpdate, flip, shift, offset, arrow } from '@floating-ui/dom';
	import { storePopup, type PopupSettings } from '@skeletonlabs/skeleton';
	import IconDatabase from '$lib/icons/IconDatabase.svelte';
	storePopup.set({ computePosition, autoUpdate, flip, shift, offset, arrow });
	origin.set($page.url.host);

	let href: string;

	origin.set($page.url.host);

	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		STORE_ADMIN_SITE_URL.set(
			$page.params.language ? '/' + $page.params.language + '/vontigo' : '/vontigo'
		);
	}

	$: classesActive = (href: string) =>
		href === $page.url.pathname ? '!bg-primary-500 text-white' : '';
</script>

<AppShell regionPage="relative" slotPageHeader="sticky top-0 z-10 h-full">
	<!-- <svelte:fragment slot="header">Header</svelte:fragment> -->
	<!-- <svelte:fragment slot="sidebarRight">Sidebar Right</svelte:fragment> -->
	<!-- <svelte:fragment slot="pageHeader">
		<AppBar class="text-3xl font-bold">Dashboard</AppBar>
	</svelte:fragment> -->
	<!-- Router Slot -->

	<div
		style="
    background: url('/bg-ai-head.gif');
    background-size: cover;"
	>
		<div class="backdrop-blur-0 bg-white/80">
			<slot />
		</div>
	</div>
	<!-- ---- / ---- -->
	<!-- <svelte:fragment slot="pageFooter">Page Footer</svelte:fragment> -->
	<!-- <svelte:fragment slot="footer">Footer</svelte:fragment> -->
</AppShell>

<style>
	html {
		height: 100%;
	}
	body {
		height: 100%;
	}
</style>
