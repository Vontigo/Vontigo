<script lang="ts">
	import Footer from './_comp/Footer.svelte';
	import Header from './_comp/Header.svelte';
	import '$lib/themes/casper/assets/built/screen.css';
	import { tenant, language, siteUrl } from '$lib/stores/site';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { page } from '$app/stores';
	tenant.set($page.url.host);
	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		siteUrl.set($page.params.language ? '/' + $page.params.language : '');
	}
</script>

<!-- .viewport -->
<div class="app viewport" style="display: contents">
	{$tenant} | {$language}
	<Header />
	<main class="site-content">
		<!-- All other templates get inserted here, index.hbs, post.hbs, etc -->
		<slot />
	</main>

	<Footer />
</div>

<!-- /.viewport -->

<style>
</style>
