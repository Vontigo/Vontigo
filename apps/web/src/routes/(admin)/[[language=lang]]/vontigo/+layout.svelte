<script lang="ts">
	// Your selected Skeleton theme:
	// import '@skeletonlabs/skeleton/themes/theme-crimson.css';
	import './vontigo.css';
	// This contains the bulk of Skeletons required styles:
	import '@skeletonlabs/skeleton/styles/all.css';
	// Finally, your application's global stylesheet (sometimes labeled 'app.css')
	import './app.postcss';

	import { signOut } from '@auth/sveltekit/client';

	import {
		AppShell,
		Avatar,
		ProgressBar,
		ProgressRadial,
		Toast,
		filter,
		popup
	} from '@skeletonlabs/skeleton';
	import { LightSwitch } from '@skeletonlabs/skeleton';
	import { page, navigating } from '$app/stores';
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import {
		language,
		origin,
		siteUrl,
		adminSiteUrl,
		isSignedIn
	} from '$lib/core/shared/stores/site';
	import IconHome from '$lib/icons/IconHome.svelte';
	import IconWindow from '$lib/icons/IconWindow.svelte';
	import IconContent from '$lib/icons/IconContent.svelte';
	import Icon3BottomLeft from '$lib/icons/Icon3BottomLeft.svelte';
	import IconTag from '$lib/icons/IconTag.svelte';
	// import IconUsers from '$lib/icons/IconUsers.svelte';

	import { computePosition, autoUpdate, flip, shift, offset, arrow } from '@floating-ui/dom';
	import { storePopup, type PopupSettings } from '@skeletonlabs/skeleton';
	// import IconDatabase from '$lib/icons/IconDatabase.svelte';
	import CompGravatar from '$lib/core/core/frontend/components/shared/CompGravatar/CompGravatar.svelte';

	import { fade } from 'svelte/transition';
	import { onMount } from 'svelte';

	let visible = false;

	onMount(() => {
		visible = true;
	});

	storePopup.set({ computePosition, autoUpdate, flip, shift, offset, arrow });
	origin.set($page.url.host);

	let href: string;

	origin.set($page.url.host);

	let popupSettings: PopupSettings = {
		// Set the event as: click | hover | hover-click | focus | focus-click
		event: 'click',
		// Provide a matching 'data-popup' value.
		target: 'examplePopup'
	};

	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		adminSiteUrl.set($page.params.language ? '/' + $page.params.language + '/vontigo' : '/vontigo');
	}

	$: classesActive = (href: string) =>
		$page.url.pathname.indexOf(href) > -1 ? '!bg-primary-500 text-white' : '';
</script>

{#if visible}
	<div transition:fade class="h-full w-full">
		<AppShell regionPage="relative" slotPageHeader="sticky top-0 z-10 ">
			<!-- <svelte:fragment slot="header">Header</svelte:fragment> -->
			<svelte:fragment slot="sidebarLeft">
				{#if $isSignedIn}
					<div
						id=""
						class="sidebar-left hidden lg:block text-lg border-e border-gray-300 h-full min-w-[300px]"
					>
						<nav class="list-nav space-y-4 h-full flex flex-col">
							<!-- (optionally you can provde a label here) -->
							<ul class="p-2 pl-10 px-6 pt-6">
								<li class="w-auto py-2">
									<!-- <span class="unstyled flex-auto font-bold antialiased"
										><span class="font-black text-4xl text-primary-500">V</span>ontigo</span
									> -->
									<svg
										viewBox="0 0 1216 193"
										fill="none"
										xmlns="http://www.w3.org/2000/svg"
										class="h-6"
									>
										<path
											d="M51.9324 4.75H0L103.5 183.75L207 4.75H155.068L103.5 93.9346L51.9324 4.75Z"
											fill="#FF0000"
										/>
										<path
											d="M244.25 96.25C244.25 106.583 246.25 115.75 250.25 123.75C254.417 131.583 260.167 137.75 267.5 142.25C275 146.75 283.75 149 293.75 149C303.583 149 312.167 146.75 319.5 142.25C327 137.75 332.75 131.583 336.75 123.75C340.917 115.75 343 106.583 343 96.25C343 85.9167 341 76.8333 337 69C333 61 327.333 54.75 320 50.25C312.667 45.75 303.917 43.5 293.75 43.5C283.75 43.5 275 45.75 267.5 50.25C260.167 54.75 254.417 61 250.25 69C246.25 76.8333 244.25 85.9167 244.25 96.25ZM199.5 96.25C199.5 82.75 201.833 70.4167 206.5 59.25C211.333 48.0833 218 38.4167 226.5 30.25C235 22.0833 245 15.8333 256.5 11.5C268 7 280.417 4.75 293.75 4.75C307.25 4.75 319.667 7 331 11.5C342.5 15.8333 352.5 22.0833 361 30.25C369.5 38.4167 376.083 48.0833 380.75 59.25C385.417 70.4167 387.75 82.75 387.75 96.25C387.75 109.75 385.417 122.167 380.75 133.5C376.25 144.833 369.75 154.667 361.25 163C352.917 171.333 343 177.833 331.5 182.5C320 187 307.417 189.25 293.75 189.25C279.917 189.25 267.25 187 255.75 182.5C244.25 177.833 234.25 171.333 225.75 163C217.417 154.667 210.917 144.833 206.25 133.5C201.75 122.167 199.5 109.75 199.5 96.25Z"
											fill="currentColor"
										/>
										<path
											d="M535.572 8.74999H576.322V192.5L455.322 85.25V183.75H414.822V0L535.572 107.25V8.74999Z"
											fill="currentColor"
										/>
										<path
											d="M595.809 46.5V8.74999H734.309V46.5H686.059V183.75H643.809V46.5H595.809Z"
											fill="currentColor"
										/>
										<path
											d="M753.445 8.74999H796.445V183.75H753.445V8.74999Z"
											fill="currentColor"
										/>
										<path
											d="M920.273 120.5V88H1008.77C1009.61 102 1008.19 115.083 1004.52 127.25C1000.86 139.417 995.19 150.167 987.523 159.5C979.857 168.833 970.273 176.167 958.773 181.5C947.273 186.667 934.107 189.25 919.273 189.25C905.273 189.25 892.44 187.083 880.773 182.75C869.107 178.25 859.023 171.917 850.523 163.75C842.023 155.417 835.357 145.583 830.523 134.25C825.857 122.75 823.523 110.083 823.523 96.25C823.523 82.4167 825.94 69.9167 830.773 58.75C835.607 47.4167 842.44 37.75 851.273 29.75C860.107 21.75 870.44 15.5833 882.273 11.25C894.107 6.91666 906.94 4.75 920.773 4.75C933.107 4.75 944.19 6.5 954.023 9.99999C963.857 13.5 972.523 18.4167 980.023 24.75C987.69 30.9167 994.273 38.0833 999.773 46.25L962.273 65.75C958.273 58.75 952.857 53 946.023 48.5C939.357 43.8333 930.94 41.5 920.773 41.5C911.107 41.5 902.19 43.6667 894.023 48C886.023 52.3333 879.607 58.5833 874.773 66.75C870.107 74.75 867.773 84.5833 867.773 96.25C867.773 107.75 870.023 117.75 874.523 126.25C879.19 134.583 885.44 141.083 893.273 145.75C901.273 150.25 910.44 152.5 920.773 152.5C927.107 152.5 932.857 151.75 938.023 150.25C943.19 148.583 947.607 146.333 951.273 143.5C954.94 140.5 958.023 137.083 960.523 133.25C963.19 129.25 965.273 125 966.773 120.5H920.273Z"
											fill="currentColor"
										/>
										<path
											d="M1071.89 96.25C1071.89 106.583 1073.89 115.75 1077.89 123.75C1082.05 131.583 1087.8 137.75 1095.14 142.25C1102.64 146.75 1111.39 149 1121.39 149C1131.22 149 1139.8 146.75 1147.14 142.25C1154.64 137.75 1160.39 131.583 1164.39 123.75C1168.55 115.75 1170.64 106.583 1170.64 96.25C1170.64 85.9167 1168.64 76.8333 1164.64 69C1160.64 61 1154.97 54.75 1147.64 50.25C1140.3 45.75 1131.55 43.5 1121.39 43.5C1111.39 43.5 1102.64 45.75 1095.14 50.25C1087.8 54.75 1082.05 61 1077.89 69C1073.89 76.8333 1071.89 85.9167 1071.89 96.25ZM1027.14 96.25C1027.14 82.75 1029.47 70.4167 1034.14 59.25C1038.97 48.0833 1045.64 38.4167 1054.14 30.25C1062.64 22.0833 1072.64 15.8333 1084.14 11.5C1095.64 7 1108.05 4.75 1121.39 4.75C1134.89 4.75 1147.3 7 1158.64 11.5C1170.14 15.8333 1180.14 22.0833 1188.64 30.25C1197.14 38.4167 1203.72 48.0833 1208.39 59.25C1213.05 70.4167 1215.39 82.75 1215.39 96.25C1215.39 109.75 1213.05 122.167 1208.39 133.5C1203.89 144.833 1197.39 154.667 1188.89 163C1180.55 171.333 1170.64 177.833 1159.14 182.5C1147.64 187 1135.05 189.25 1121.39 189.25C1107.55 189.25 1094.89 187 1083.39 182.5C1071.89 177.833 1061.89 171.333 1053.39 163C1045.05 154.667 1038.55 144.833 1033.89 133.5C1029.39 122.167 1027.14 109.75 1027.14 96.25Z"
											fill="currentColor"
										/>
									</svg>
								</li>
							</ul>
							<ul class="p-2 px-6 pt-0">
								<li class="w-auto">
									<a
										class={classesActive($adminSiteUrl + '/dashboard')}
										href={$adminSiteUrl + '/dashboard'}
									>
										<IconHome />
										<span class="flex-auto text-base">Dashboard</span>
									</a>
								</li>
								<li class="w-auto flex gap-2">
									<a
										class="w-full {classesActive($adminSiteUrl + '/site')}"
										href={$adminSiteUrl + '/site'}
									>
										<IconWindow />
										<span class="flex-auto text-base">View site</span>
									</a>
									<a data-sveltekit-reload class="p-2" href="/" target="_blank">
										<svg
											xmlns="http://www.w3.org/2000/svg"
											fill="none"
											viewBox="0 0 24 24"
											stroke-width="2"
											stroke="currentColor"
											class="w-6 h-5"
										>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25"
											/>
										</svg>
									</a>
								</li>
							</ul>
							<ul class="p-2 px-6">
								<li class="w-auto">
									<ul>
										<li class="w-auto">
											<a
												class={classesActive($adminSiteUrl + '/posts/post/page')}
												href={$adminSiteUrl + '/posts/post/page/1'}
											>
												<Icon3BottomLeft />
												<span class="flex-auto text-base">Posts</span>
											</a>
										</li>
										<li class="w-auto">
											<a
												class={classesActive($adminSiteUrl + '/posts/post/drafts/page')}
												href={$adminSiteUrl + '/posts/post/drafts/page/1'}
											>
												<span class="pl-10 flex-auto text-sm">Drafts</span>
											</a>
										</li>
										<li class="w-auto">
											<a
												class={classesActive($adminSiteUrl + '/posts/post/scheduled/page')}
												href={$adminSiteUrl + '/posts/post/scheduled/page/1'}
											>
												<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
												<span class="pl-10 flex-auto text-sm">Scheduled</span>
											</a>
										</li>
										<li class="w-auto">
											<a
												class={classesActive($adminSiteUrl + '/posts/post/published/page')}
												href={$adminSiteUrl + '/posts/post/published/page/1'}
											>
												<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
												<span class="pl-10 flex-auto text-sm">Published</span>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="p-2 px-6">
								<li class="w-auto">
									<a
										class={classesActive($adminSiteUrl + '/posts/page')}
										href={$adminSiteUrl + '/posts/page/page/1'}
									>
										<IconContent />
										<span class="flex-auto text-base">Pages</span>
									</a>
								</li>
								<li class="w-auto">
									<a
										class={classesActive($adminSiteUrl + '/tags/public')}
										href={$adminSiteUrl + '/tags/public'}
									>
										<IconTag />
										<span class="flex-auto text-base">Tags</span>
									</a>
								</li>
								<!-- <li class="w-auto">
						<a class={classesActive($adminSiteUrl + '/members')} href={$adminSiteUrl + '/members'}>
							<IconUsers />
							<span class="flex-auto text-base">Members</span>
						</a>
					</li> -->
								<!-- <li class="w-auto">
						<a class={classesActive($adminSiteUrl + '/base')} href={$adminSiteUrl + '/base'}>
							<IconDatabase />
							<span class="flex-auto text-base">Vontigobase</span>
						</a>
					</li> -->
							</ul>
							<ul class="h-full" />
							<ul class="sidebar-left__bottom p-8 flex flex-row">
								<li class="w-full mt-1 flex">
									<div
										class=" relative inline-block my-auto cursor-pointer"
										use:popup={popupSettings}
									>
										<span
											class="badge-icon bg-green-400 absolute -top-0 -right-0 z-10 w-2 h-2 border"
										/>
										{#if $page?.data?.session?.user?.profile_image}
											<Avatar
												src={$page?.data?.session?.user?.profile_image}
												action={filter}
												actionParams="#Apollo"
												width="w-8"
											/>
										{:else}
											<CompGravatar
												email={$page?.data?.session?.user?.email}
												size={32}
												default="robohash"
												class="rounded-full"
											/>
										{/if}
									</div>
								</li>
								<li class="w-full" />
								<li class="w-auto text-end content-end settings">
									<a
										class={classesActive($adminSiteUrl + '/settings') + ' mr-2'}
										href={$adminSiteUrl + '/settings'}
									>
										<svg
											xmlns="http://www.w3.org/2000/svg"
											fill="none"
											viewBox="0 0 24 24"
											stroke-width="1"
											stroke="currentColor"
											class="w-6 h-6"
										>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.324.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 011.37.49l1.296 2.247a1.125 1.125 0 01-.26 1.431l-1.003.827c-.293.24-.438.613-.431.992a6.759 6.759 0 010 .255c-.007.378.138.75.43.99l1.005.828c.424.35.534.954.26 1.43l-1.298 2.247a1.125 1.125 0 01-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.57 6.57 0 01-.22.128c-.331.183-.581.495-.644.869l-.213 1.28c-.09.543-.56.941-1.11.941h-2.594c-.55 0-1.02-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 01-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 01-1.369-.49l-1.297-2.247a1.125 1.125 0 01.26-1.431l1.004-.827c.292-.24.437-.613.43-.992a6.932 6.932 0 010-.255c.007-.378-.138-.75-.43-.99l-1.004-.828a1.125 1.125 0 01-.26-1.43l1.297-2.247a1.125 1.125 0 011.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.087.22-.128.332-.183.582-.495.644-.869l.214-1.281z"
											/>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
											/>
										</svg>
									</a>
								</li>
								<li class="w-auto text-end content-end py-2">
									<span class="flex-auto text-base">
										<LightSwitch height="h-5" width="w-10" rounded="rounded-full" />
									</span>
								</li>
							</ul>
						</nav>
					</div>

					<div class="card p-2 shadow text-base" data-popup="examplePopup">
						<nav class="list-nav">
							<!-- (optionally you can provide a label here) -->
							<ul>
								<li>
									<a
										class={classesActive($adminSiteUrl + '/settings/staff')}
										href={$adminSiteUrl + '/settings/staff/' + $page?.data?.session?.user?.slug}
									>
										<svg
											xmlns="http://www.w3.org/2000/svg"
											fill="none"
											viewBox="0 0 24 24"
											stroke-width="1.5"
											stroke="currentColor"
											class="w-5 h-5"
										>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z"
											/>
										</svg>

										<span class="flex-auto">My profile</span>
									</a>
								</li>
								<li>
									<a class={classesActive($adminSiteUrl + '/docs')} href={$adminSiteUrl + '/docs'}>
										<span class="">
											<svg
												xmlns="http://www.w3.org/2000/svg"
												fill="none"
												viewBox="0 0 24 24"
												stroke-width="1.5"
												stroke="currentColor"
												class="w-5 h-5"
											>
												<path
													stroke-linecap="round"
													stroke-linejoin="round"
													d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5"
												/>
											</svg>
										</span>
										<span class="flex-auto">Developer docs</span>
									</a>
								</li>
								<li>
									<a href="#" on:click={() => signOut()} class="p-1">
										<span class=""
											><svg
												xmlns="http://www.w3.org/2000/svg"
												fill="none"
												viewBox="0 0 24 24"
												stroke-width="1.5"
												stroke="currentColor"
												class="w-5 h-5"
											>
												<path
													stroke-linecap="round"
													stroke-linejoin="round"
													d="M5.636 5.636a9 9 0 1012.728 0M12 3v9"
												/>
											</svg>
										</span>
										<span class="flex-auto">Signout</span>
									</a>
								</li>
								<!-- ... -->
							</ul>
						</nav>
					</div>
				{/if}
			</svelte:fragment>
			<!-- <svelte:fragment slot="sidebarRight">Sidebar Right</svelte:fragment> -->
			<!-- <svelte:fragment slot="pageHeader">
		<AppBar class="text-3xl font-bold">Dashboard</AppBar>
	</svelte:fragment> -->
			<!-- Router Slot -->

			{#if $navigating}
				<ProgressBar height={'h-1'} class="absolute top-0 w-full z-20" />
			{:else}
				<slot />
			{/if}

			<!-- ---- / ---- -->
			<!-- <svelte:fragment slot="pageFooter">Page Footer</svelte:fragment> -->
			<!-- <svelte:fragment slot="footer">Footer</svelte:fragment> -->
		</AppShell>
	</div>
{:else}
	<div class="loading w-full h-full flex">
		<div class="m-auto">
			<!-- <ProgressRadial ... stroke={180} meter="stroke-primary-500" track="stroke-primary-500/30" /> -->
			<svg class="logo h-20" viewBox="0 0 579 500" fill="none" xmlns="http://www.w3.org/2000/svg">
				<path
					d="M145.062 0H0L289.106 500L578.212 0H433.15L289.106 249.119L145.062 0Z"
					fill="#FF0000"
				/>
			</svg>
		</div>
	</div>
{/if}
<Toast position={'tr'} width={'max-w-[350px]'} />

<style lang="scss">
</style>
