<script>
	import Footer from './_comp/Footer.svelte';
	import Header from './_comp/Header.svelte';
	import '$lib/themes/casper/assets/built/screen.css';
</script>

<!-- .viewport -->
<div class="app viewport" style="display: contents">
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
