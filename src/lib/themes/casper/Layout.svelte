<script lang="ts">
	import Footer from './partials/Footer.svelte';
	import Header from './partials/Header.svelte';
	import './assets/built/screen.css';
	import { origin, language, siteUrl } from '$lib/core/shared/stores/site';
</script>

<!-- .viewport -->
<div class="app viewport" style="display: contents">
	<!-- {$origin} | {$language} -->
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
