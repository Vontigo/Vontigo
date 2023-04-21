<script lang="ts">
	// Your selected Skeleton theme:
	import '@skeletonlabs/skeleton/themes/theme-crimson.css';
	// import './vontigo.css';
	// This contains the bulk of Skeletons required styles:
	import '@skeletonlabs/skeleton/styles/all.css';
	// Finally, your application's global stylesheet (sometimes labeled 'app.css')
	import './app.postcss';

	import { Accordion, AccordionItem, AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { LightSwitch } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { language, origin, siteUrl, adminSiteUrl } from '$lib/core/shared/stores/site';
	import IconHome from '$lib/icons/IconHome.svelte';
	import IconWindow from '$lib/icons/IconWindow.svelte';
	import IconContent from '$lib/icons/IconContent.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconTag from '$lib/icons/IconTag.svelte';
	import IconUsers from '$lib/icons/IconUsers.svelte';

	import { computePosition, autoUpdate, flip, shift, offset, arrow } from '@floating-ui/dom';
	import { storePopup, type PopupSettings } from '@skeletonlabs/skeleton';
	storePopup.set({ computePosition, autoUpdate, flip, shift, offset, arrow });
	origin.set($page.url.host);

	let href: string;

	origin.set($page.url.host);

	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		adminSiteUrl.set($page.params.language ? '/' + $page.params.language + '/vontigo' : '/vontigo');
	}

	$: classesActive = (href: string) =>
		href === $page.url.pathname ? '!bg-primary-500 text-white' : '';
</script>

<!-- <div class="app">
	<main>
		<slot />
	</main>

	<footer>
		<p>visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to learn SvelteKit</p>
	</footer>
</div> -->

<AppShell regionPage="relative" slotPageHeader="sticky top-0 z-10 ">
	<!-- <svelte:fragment slot="header">Header</svelte:fragment> -->
	<svelte:fragment slot="sidebarLeft">
		<div
			id=""
			class="sidebar-left hidden lg:block text-lg drop-shadow-md border-e border-gray-300 h-full min-w-[250px]"
		>
			<nav class="list-nav space-y-4 h-full flex flex-col">
				<!-- (optionally you can provde a label here) -->
				<ul class="p-2 pl-8 px-6 pt-4">
					<li class="w-auto">
						<span class="badge bg-primary-500 w-10 h-10 font-bold text-xl">V</span>
						<span class="flex-auto text-base">Vontigo</span>
					</li>
				</ul>
				<ul class="p-2 px-6 pt-10">
					<li class="w-auto">
						<a
							class={classesActive($adminSiteUrl + '/dashboard')}
							href={$adminSiteUrl + '/dashboard'}
						>
							<IconHome />
							<span class="flex-auto text-base">Dashboard</span>
						</a>
					</li>
					<li class="w-auto">
						<a class=" {classesActive($adminSiteUrl + '/site')}" href={$adminSiteUrl + '/site'}>
							<IconWindow />
							<span class="flex-auto text-base">View site</span>
						</a>
					</li>
				</ul>
				<ul class="p-2 px-6">
					<li class="w-auto">
						<ul>
							<li class="w-auto">
								<a class={classesActive($adminSiteUrl + '/posts')} href={$adminSiteUrl + '/posts'}>
									<Icon3BottomLeft />
									<span class="flex-auto text-base">Posts</span>
								</a>
							</li>
							<li class="w-auto">
								<a
									class={classesActive($adminSiteUrl + '/posts/drafts')}
									href={$adminSiteUrl + '/posts/drafts'}
								>
									<span class="pl-10 flex-auto text-base">Drafts</span>
								</a>
							</li>
							<li class="w-auto">
								<a
									class={classesActive($adminSiteUrl + '/posts/scheduled')}
									href={$adminSiteUrl + '/posts/scheduled'}
								>
									<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
									<span class="pl-10 flex-auto text-base">Scheduled</span>
								</a>
							</li>
							<li class="w-auto">
								<a
									class={classesActive($adminSiteUrl + '/posts/published')}
									href={$adminSiteUrl + '/posts/published'}
								>
									<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
									<span class="pl-10 flex-auto text-base">Published</span>
								</a>
							</li>
						</ul>
					</li>
				</ul>
				<ul class="p-2 px-6">
					<li class="w-auto">
						<a class={classesActive($adminSiteUrl + '/pages')} href={$adminSiteUrl + '/pages'}>
							<IconContent />
							<span class="flex-auto text-base">Pages</span>
						</a>
					</li>
					<li class="w-auto">
						<a class={classesActive($adminSiteUrl + '/tags')} href={$adminSiteUrl + '/tags'}>
							<IconTag />
							<span class="flex-auto text-base">Tags</span>
						</a>
					</li>
					<li class="w-auto">
						<a class={classesActive($adminSiteUrl + '/members')} href={$adminSiteUrl + '/members'}>
							<IconUsers />
							<span class="flex-auto text-base">Members</span>
						</a>
					</li>
				</ul>
				<ul class="h-full" />
				<ul class="p-4 px-6">
					<li class="w-full text-end content-end">
						<span class="flex-auto text-base"><LightSwitch /></span>
					</li>
				</ul>
			</nav>
		</div>
	</svelte:fragment>
	<!-- <svelte:fragment slot="sidebarRight">Sidebar Right</svelte:fragment> -->
	<!-- <svelte:fragment slot="pageHeader">
		<AppBar class="text-3xl font-bold">Dashboard</AppBar>
	</svelte:fragment> -->
	<!-- Router Slot -->
	<slot />
	<!-- ---- / ---- -->
	<!-- <svelte:fragment slot="pageFooter">Page Footer</svelte:fragment> -->
	<!-- <svelte:fragment slot="footer">Footer</svelte:fragment> -->
</AppShell>
