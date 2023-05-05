<script lang="ts">
	import Footer from './partials/Footer.svelte';
	import Header from './partials/Header.svelte';
	import {
		origin,
		language,
		siteUrl,
		site,
		templateType,
		theme
	} from '$lib/core/shared/stores/site';

	/*-- Theme assets - use the {asset} helper to reference styles & scripts,
    this will take care of caching and cache-busting automatically --*/
	import './assets/css/screen.css';

	let bodyClass = '';
	let isNavOpen: boolean = false;

	if ($theme.custom.navigation_layout.default == 'Logo on cover') {
		bodyClass += ` is-head-left-logo`;
	} else if ($theme.custom.navigation_layout.default == 'Logo in the middle') {
		bodyClass += ' is-head-middle-logo';
	} else {
		bodyClass += ' stacked';
	}

	if ($theme.custom.title_font.default == 'Elegant serif') {
		bodyClass += ` has-serif-title`;
	}

	if ($theme.custom.body_font.default == 'Modern sans-serif') {
		bodyClass += `  has-sans-body`;
	}

	if ($theme.custom.show_publication_cover.default) {
		bodyClass += ` has-cover`;
	}
</script>

<svelte:head>
	{@html `<style>:root {
		--ghost-accent-color:${$site.accent_color};
	}</style>`}
</svelte:head>

<div class="{$templateType}-template {bodyClass} {isNavOpen ? 'gh-head-open' : ''}">
	<!-- {$origin} | {$language} -->
	<Header bind:isNavOpen />
	<div class="site-content">
		<!-- All other templates get inserted here, index.hbs, post.hbs, etc -->
		<slot />
	</div>

	<!-- Scripts - handle member signups, responsive videos, infinite scroll, floating headers, and galleries -->
	<!-- <script
    src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous">
</script>
<script src="./built/casper.js"></script>
<script>
$(document).ready(function () {
    // Mobile Menu Trigger
    $('.gh-burger').click(function () {
        $('body').toggleClass('gh-head-open');
    });
    // FitVids - Makes video embeds responsive
    $(".gh-content").fitVids();
});
</script> -->

	<Footer />
</div>

<style>
</style>
