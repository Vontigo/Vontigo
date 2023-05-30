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
		STORE_ADMIN_SITE_URL,
		isSignedIn,
		STORE_ADMIN_APP_TYPE
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
	import { ENUM_APP_TYPE, ENUM_POST_TYPE } from '$lib/core/shared/enum';
	import IconPost from '$lib/icons/IconPost.svelte';

	let visible = false;
	$STORE_ADMIN_APP_TYPE = ENUM_APP_TYPE[$page.params.app || ENUM_APP_TYPE.website];

	// alert($STORE_ADMIN_APP_TYPE);

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
		STORE_ADMIN_SITE_URL.set(
			$page.params.language ? '/' + $page.params.language + '/vontigo' : '/vontigo'
		);
	}

	$: classesActive = (href: string) =>
		$page.url.pathname.indexOf(href) > -1
			? '!bg-primary-500/10 text-primary-500'
			: 'hover:!bg-primary-500/20 hover:text-primary-500'; //'text-primary-500 font-bold' : ''; //'!bg-primary-500 text-white' : '';
</script>

<svelte:head>
	<script type="text/javascript">
		(function (c, l, a, r, i, t, y) {
			c[a] =
				c[a] ||
				function () {
					(c[a].q = c[a].q || []).push(arguments);
				};
			t = l.createElement(r);
			t.async = 1;
			t.src = 'https://www.clarity.ms/tag/' + i;
			y = l.getElementsByTagName(r)[0];
			y.parentNode.insertBefore(t, y);
		})(window, document, 'clarity', 'script', 'hc6w3fug2r');
	</script>
</svelte:head>

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
								<li class="w-auto py-2 text-primary-500">
									<!-- <span class="unstyled flex-auto font-bold antialiased"
										><span class="font-black text-4xl text-primary-500">V</span>ontigo</span
									> -->
									<svg
										class="h-6"
										viewBox="0 0 1216 193"
										fill="none"
										xmlns="http://www.w3.org/2000/svg"
									>
										<path
											d="M51.9324 4.75H0L103.5 183.75L207 4.75H155.068L103.5 93.9346L51.9324 4.75Z"
											fill="currentColor"
										/>
										<path
											d="M244.25 96.25C244.25 125.385 264.22 149 293.75 149C323.019 149 343 125.017 343 96.25C343 67.7934 323.833 43.5 293.75 43.5C263.691 43.5 244.25 67.7652 244.25 96.25ZM199.5 96.25C199.5 71.4177 208.449 47.5935 226.5 30.25C244.372 13.0789 269.22 4.75 293.75 4.75C318.296 4.75 343.112 13.0637 361 30.25C378.955 47.501 387.75 71.59 387.75 96.25C387.75 120.921 379.053 145.546 361.25 163C343.354 180.896 318.769 189.25 293.75 189.25C268.508 189.25 243.959 180.852 225.75 163C208.008 145.258 199.5 121.101 199.5 96.25Z"
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
											d="M920.273 120.5V88H1008.77C1010.29 113.469 1003.92 139.538 987.523 159.5C970.669 180.018 945.347 189.25 919.273 189.25C894.024 189.25 868.988 181.49 850.523 163.75C832.287 145.871 823.523 121.556 823.523 96.25C823.523 71.2848 832.534 46.7216 851.273 29.75C870.187 12.6208 895.538 4.75 920.773 4.75C952.716 4.75 981.721 19.4454 999.773 46.25L962.273 65.75C953.581 50.5386 938.275 41.5 920.773 41.5C889.279 41.5 867.773 66.0178 867.773 96.25C867.773 127.478 889.23 152.5 920.773 152.5C942.388 152.5 959.842 141.293 966.773 120.5H920.273Z"
											fill="currentColor"
										/>
										<path
											d="M1071.89 96.25C1071.89 125.385 1091.86 149 1121.39 149C1151.24 149 1170.64 124.514 1170.64 96.25C1170.64 67.118 1150.93 43.5 1121.39 43.5C1091.33 43.5 1071.89 67.7652 1071.89 96.25ZM1027.14 96.25C1027.14 71.4177 1036.09 47.5935 1054.14 30.25C1072.01 13.0789 1096.86 4.75 1121.39 4.75C1145.93 4.75 1170.75 13.0637 1188.64 30.25C1206.59 47.501 1215.39 71.59 1215.39 96.25C1215.39 120.921 1206.69 145.546 1188.89 163C1170.99 180.896 1146.41 189.25 1121.39 189.25C1096.14 189.25 1071.6 180.852 1053.39 163C1035.64 145.258 1027.14 121.101 1027.14 96.25Z"
											fill="currentColor"
										/>
									</svg>
								</li>
							</ul>
							<ul class="p-2 px-6 pt-0">
								<li class="w-auto">
									<a
										class={classesActive($STORE_ADMIN_SITE_URL + '/dashboard')}
										href={$STORE_ADMIN_SITE_URL + '/dashboard'}
									>
										<span class="text-base-500/50"> <IconHome /></span>
										<span class="flex-auto text-base">Dashboard</span>
									</a>
								</li>
								<li class="w-auto flex gap-2">
									<a
										class="w-full {classesActive($STORE_ADMIN_SITE_URL + '/site')}"
										href={$STORE_ADMIN_SITE_URL + '/site'}
									>
										<IconWindow />
										<span class="flex-auto text-base">View site</span>
									</a>
									<a data-sveltekit-reload class="p-2" href="/" target="_blank">
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
												d="M12.75 3.03v.568c0 .334.148.65.405.864l1.068.89c.442.369.535 1.01.216 1.49l-.51.766a2.25 2.25 0 01-1.161.886l-.143.048a1.107 1.107 0 00-.57 1.664c.369.555.169 1.307-.427 1.605L9 13.125l.423 1.059a.956.956 0 01-1.652.928l-.679-.906a1.125 1.125 0 00-1.906.172L4.5 15.75l-.612.153M12.75 3.031a9 9 0 00-8.862 12.872M12.75 3.031a9 9 0 016.69 14.036m0 0l-.177-.529A2.25 2.25 0 0017.128 15H16.5l-.324-.324a1.453 1.453 0 00-2.328.377l-.036.073a1.586 1.586 0 01-.982.816l-.99.282c-.55.157-.894.702-.8 1.267l.073.438c.08.474.49.821.97.821.846 0 1.598.542 1.865 1.345l.215.643m5.276-3.67a9.012 9.012 0 01-5.276 3.67m0 0a9 9 0 01-10.275-4.835M15.75 9c0 .896-.393 1.7-1.016 2.25"
											/>
										</svg>
									</a>
								</li>
							</ul>

							{#if $STORE_ADMIN_APP_TYPE === ENUM_APP_TYPE.website}
								<ul class="p-2 px-6">
									<li class="w-auto">
										<ul>
											<li class="w-auto">
												<a
													class={classesActive(`${$STORE_ADMIN_SITE_URL}/posts/post/page`)}
													href={`${$STORE_ADMIN_SITE_URL}/posts/post/page/1`}
												>
													<IconPost />
													<span class="flex-auto text-base">Posts</span>
												</a>
												<ul class="py-2">
													<li class="w-auto">
														<a
															class={classesActive(
																$STORE_ADMIN_SITE_URL + '/posts/post/drafts/page'
															)}
															href={$STORE_ADMIN_SITE_URL + '/posts/post/drafts/page/1'}
														>
															<span class="pl-10 flex-auto text-base">Drafts</span>
														</a>
													</li>
													<li class="w-auto">
														<a
															class={classesActive(
																$STORE_ADMIN_SITE_URL + '/posts/post/scheduled/page'
															)}
															href={$STORE_ADMIN_SITE_URL + '/posts/post/scheduled/page/1'}
														>
															<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
															<span class="pl-10 flex-auto text-base">Scheduled</span>
														</a>
													</li>
													<li class="w-auto">
														<a
															class={classesActive(
																$STORE_ADMIN_SITE_URL + '/posts/post/published/page'
															)}
															href={$STORE_ADMIN_SITE_URL + '/posts/post/published/page/1'}
														>
															<!-- <span class="badge bg-primary-500 w-10 h-10 bg-none">LOGO</span> -->
															<span class="pl-10 flex-auto text-base">Published</span>
														</a>
													</li>
												</ul>
											</li>
										</ul>
									</li>
								</ul>
								<ul class="p-2 px-6">
									<li class="w-auto">
										<a
											class={classesActive($STORE_ADMIN_SITE_URL + '/posts/page')}
											href={$STORE_ADMIN_SITE_URL + '/posts/page/page/1'}
										>
											<IconContent />
											<span class="flex-auto text-base">Pages</span>
										</a>
									</li>
									<li class="w-auto">
										<a
											class={classesActive($STORE_ADMIN_SITE_URL + '/tags/public')}
											href={$STORE_ADMIN_SITE_URL + '/tags/public'}
										>
											<IconTag />
											<span class="flex-auto text-base">Tags</span>
										</a>
									</li>
									<!-- <li class="w-auto">
						<a class={classesActive($STORE_ADMIN_SITE_URL + '/members')} href={$STORE_ADMIN_SITE_URL + '/members'}>
							<IconUsers />
							<span class="flex-auto text-base">Members</span>
						</a>
					</li> -->
									<!-- <li class="w-auto">
						<a class={classesActive($STORE_ADMIN_SITE_URL + '/base')} href={$STORE_ADMIN_SITE_URL + '/base'}>
							<IconDatabase />
							<span class="flex-auto text-base">Vontigobase</span>
						</a>
					</li> -->
								</ul>
							{:else if $STORE_ADMIN_APP_TYPE === ENUM_APP_TYPE.ecommerce}
								<ul class="p-2 px-6">
									<li class="w-auto">
										<a
											class={classesActive(
												`${$STORE_ADMIN_SITE_URL}/${$STORE_ADMIN_APP_TYPE}/posts/${ENUM_POST_TYPE.product}/page`
											)}
											href={`${$STORE_ADMIN_SITE_URL}/${$STORE_ADMIN_APP_TYPE}/posts/${ENUM_POST_TYPE.product}/page/1`}
										>
											<IconContent />
											<span class="flex-auto text-base">Products</span>
										</a>
									</li>
								</ul>
							{/if}
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
										class={classesActive($STORE_ADMIN_SITE_URL + '/settings') + ' mr-2'}
										href={$STORE_ADMIN_SITE_URL + '/settings'}
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
										class={classesActive($STORE_ADMIN_SITE_URL + '/settings/staff')}
										href={$STORE_ADMIN_SITE_URL +
											'/settings/staff/' +
											$page?.data?.session?.user?.slug}
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
									<a
										class={classesActive($STORE_ADMIN_SITE_URL + '/docs')}
										href={$STORE_ADMIN_SITE_URL + '/docs'}
									>
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
				<ProgressBar
					height={'h-1'}
					class="absolute top-0 w-full z-20"
					meter=" bg-primary-500"
					rounded="rounded-0"
				/>
			{/if}
			<slot />

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
<Toast position={'tr'} width={'max-w-[350px]'} buttonDismiss="hidden" />

<style lang="scss">
</style>
