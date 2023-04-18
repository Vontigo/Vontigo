<script lang="ts">
	// Your selected Skeleton theme:
	// import '@skeletonlabs/skeleton/themes/theme-crimson.css';
	import './vontigo.css';
	// This contains the bulk of Skeletons required styles:
	import '@skeletonlabs/skeleton/styles/all.css';
	// Finally, your application's global stylesheet (sometimes labeled 'app.css')
	import '../../../../app.postcss';

	import { Accordion, AccordionItem, AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { LightSwitch } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { language, origin, siteUrl } from '$lib/core/shared/stores/site';
	let href: string;

	origin.set($page.url.host);
	
	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		siteUrl.set($page.params.language ? '/' + $page.params.language + '/vontigo' : '/vontigo');
	}

	// $: classesActive = (href: string) => (href === $page.url.pathname ? '!bg-primary-500' : '');
</script>

<!-- <div class="app">
	<main>
		<slot />
	</main>

	<footer>
		<p>visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to learn SvelteKit</p>
	</footer>
</div> -->

<AppShell regionPage="relative" slotPageHeader="sticky top-0 z-10">
	<!-- <svelte:fragment slot="header">Header</svelte:fragment> -->
	<svelte:fragment slot="sidebarLeft">
		<div id="sidebar-left" class="hidden lg:block text-lg">
			<nav class="list-nav">
				<!-- (optionally you can provde a label here) -->
				<ul class="p-2 px-6">
					<li class="w-auto content-end text-end">
						<span class="badge bg-primary-500 w-10 h-10">LOGO</span>
						<span class="flex-auto">Vontigo</span>
					</li>
					<li class="w-auto content-end">
						<a href={ $siteUrl + '/dashboard'}>
							<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
							<span class="flex-auto">Dashboard</span>
						</a>
					</li>
					<li class="w-auto content-end">
						<a href={ $siteUrl + '/site'}>
							<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
							<span class="flex-auto">View site</span>
						</a>
					</li>
					<li class="w-auto content-end">
						<Accordion>
							<AccordionItem open>
								<svelte:fragment slot="lead">(icon)</svelte:fragment>
								<svelte:fragment slot="summary">Posts</svelte:fragment>
								<svelte:fragment slot="content">
									<ul>
										<li class="w-auto content-end">
											<a href={ $siteUrl + '/posts/drafts'}>
												<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
												<span class="flex-auto">Drafts</span>
											</a>
										</li>
										<li class="w-auto content-end">
											<a href={ $siteUrl + '/posts/scheduled'}>
												<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
												<span class="flex-auto">Scheduled</span>
											</a>
										</li>
										<li class="w-auto content-end">
											<a href={ $siteUrl + '/posts/published'}>
												<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
												<span class="flex-auto">Published</span>
											</a>
										</li>
									</ul>
								</svelte:fragment>
							</AccordionItem>

							<!-- ... -->
						</Accordion>
					</li>
					<li class="w-auto content-end">
						<a href={ $siteUrl + '/pages'}>
							<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
							<span class="flex-auto">Pages</span>
						</a>
					</li>
					<li class="w-auto content-end">
						<a href={ $siteUrl + '/tags'}>
							<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
							<span class="flex-auto">Tags</span>
						</a>
					</li>
					<li class="w-auto content-end">
						<a href={ $siteUrl + '/members'}>
							<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
							<span class="flex-auto">Members</span>
						</a>
					</li>
					<li class="w-full content-end">
						<span class="flex-auto"><LightSwitch /></span>
					</li>
					<!-- ... -->
				</ul>
			</nav>
		</div>
	</svelte:fragment>
	<!-- <svelte:fragment slot="sidebarRight">Sidebar Right</svelte:fragment> -->
	<svelte:fragment slot="pageHeader">
		<AppBar class="text-3xl font-bold">Dashboard</AppBar>
	</svelte:fragment>
	<!-- Router Slot -->
	<slot />
	<!-- ---- / ---- -->
	<svelte:fragment slot="pageFooter">Page Footer</svelte:fragment>
	<!-- <svelte:fragment slot="footer">Footer</svelte:fragment> -->
</AppShell>
