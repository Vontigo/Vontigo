<script>
	import '@svelteness/kit-docs/client/polyfills/index.js';
	import '@svelteness/kit-docs/client/styles/normalize.css';
	import '@svelteness/kit-docs/client/styles/fonts.css';
	import '@svelteness/kit-docs/client/styles/theme.css';
	import '@svelteness/kit-docs/client/styles/vars.css';
	import '../app.css';
	import { page } from '$app/stores';
	import {
		Button,
		KitDocs,
		KitDocsLayout,
		SocialLink,
		createSidebarContext
	} from '@svelteness/kit-docs';

	/** @type {import('./$types').LayoutData} */
	export let data;

	$: ({ meta, sidebar } = data);

	/** @type {import('@svelteness/kit-docs').NavbarConfig} */
	const navbar = {
		//links: [{ title: 'Documentation', slug: '/docs', match: /\/docs/ }]
		links: [
			{ title: 'Documentation', slug: '/', match: /\// }
			// { title: 'Github', slug: 'https://github.com/Vontigo/Vontigo', match: /\// },
			// { title: 'Home', slug: 'https://vontigo.org', match: /\// }
		]
	};

	const { activeCategory } = createSidebarContext(sidebar);

	$: category = $activeCategory ? `${$activeCategory}: ` : '';
	$: title = meta ? `${category}${meta.title} | Vontigo Docs` : null;
	$: description = meta?.description;
</script>

<svelte:head>
	{#key $page.url.pathname}
		{#if title}
			<title>{title}</title>
		{/if}
		{#if description}
			<meta name="description" content={description} />
		{/if}
	{/key}
</svelte:head>

<KitDocs {meta}>
	<KitDocsLayout {navbar} {sidebar}>
		<div class="logo font-semibold" slot="navbar-left">
			<Button href="/">
				<svg viewBox="0 0 62 74" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path
						fill-rule="evenodd"
						clip-rule="evenodd"
						d="M11.2273 0.511353H58.9432C59.6876 0.511353 60.4015 0.80707 60.9279 1.33345C61.4543 1.85983 61.75 2.57376 61.75 3.31817V59.4545C61.75 60.1989 61.4543 60.9129 60.9279 61.4393C60.4015 61.9656 59.6876 62.2614 58.9432 62.2614H11.2273C9.73844 62.2614 8.31059 62.8528 7.25783 63.9055C6.20507 64.9583 5.61364 66.3862 5.61364 67.875H53.3295C54.074 67.875 54.7879 68.1707 55.3143 68.6971C55.8406 69.2235 56.1364 69.9374 56.1364 70.6818C56.1364 71.4262 55.8406 72.1402 55.3143 72.6665C54.7879 73.1929 54.074 73.4886 53.3295 73.4886H2.80682C2.0624 73.4886 1.34848 73.1929 0.822098 72.6665C0.295718 72.1402 0 71.4262 0 70.6818V11.7386C0.00925298 8.76381 1.19509 5.91349 3.29861 3.80997C5.40213 1.70645 8.25246 0.520606 11.2273 0.511353ZM55.0641 8.5849H9.14581V54.5032H55.0641V8.5849Z"
						fill="currentColor"
					/>
				</svg>
			</Button>
		</div>
		<div class="socials flex" slot="navbar-right-alt">
			<SocialLink type="twitter" href="https://twitter.com/vontigo_org" />
			<SocialLink type="discord" href="https://discord.gg/gvpYbXTPvm" />
			<SocialLink type="gitHub" href="https://github.com/Vontigo/Vontigo" />
			<SocialLink type="youtube" href="https://www.youtube.com/@vontigo" />
		</div>
		<slot />
	</KitDocsLayout>
</KitDocs>

<style>
	:global(:root) {
		--kd-color-brand-rgb: 233, 127, 6;
	}

	:global(:root.dark) {
		--kd-color-brand-rgb: 213, 149, 76;
	}

	.logo :global(a) {
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.logo :global(svg) {
		height: 36px;
		overflow: hidden;
	}
</style>
