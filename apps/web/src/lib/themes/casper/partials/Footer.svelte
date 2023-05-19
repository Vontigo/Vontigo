<script lang="ts">
	// import { site } from '$lib/core/shared/stores/site';
	import { page } from '$app/stores';
	import Navigation from './Navigation.svelte';
</script>

<!-- The global footer at the very bottom of the screen -->
<footer class="site-footer outer">
	<div class="inner">
		<section class="copyright">
			<a href={$page.url.origin}>{$page.data.settings.site.title}</a> &copy; {new Date().getFullYear()}
		</section>
		<nav class="site-footer-nav">
			<Navigation type={'secondary'} />
		</nav>
		<div class="gh-powered-by">
			<a href="https://vontigo.org" target="_blank" rel="noopener">Powered by Vontigo</a>
		</div>
	</div>
</footer>

<style>
</style>
