<script lang="ts">
	// Finally, your application's global stylesheet (sometimes labeled 'app.css')
	import '../../app.postcss';
	import './vontigo.css';

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
	import IconDatabase from '$lib/icons/IconDatabase.svelte';

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
		href === $page.url.pathname ? '!bg-primary text-white' : '';
</script>

<div class="min-h-screen relative">
	<!-- Background -->
	<div
		style="
    background: url('/bg-ai-head.gif');
    background-size: cover;"
	>
		<div class="backdrop-blur-0 bg-white/80 min-h-screen">
			<slot />
		</div>
	</div>
</div>

<style>
	html {
		height: 100%;
	}
	body {
		height: 100%;
	}
</style>
